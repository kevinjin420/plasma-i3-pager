#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLASMOID_ID="org.kevinjin.plasma.i3pager"
CONFIG="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"

# install plasmoid
echo "Installing $PLASMOID_ID..."
if kpackagetool6 -t Plasma/Applet -l 2>/dev/null | grep -q "$PLASMOID_ID"; then
    kpackagetool6 -t Plasma/Applet -u "$SCRIPT_DIR"
else
    kpackagetool6 -t Plasma/Applet -i "$SCRIPT_DIR"
fi

# stop plasmashell through systemd so it can't overwrite our config edits
# ASSUMES distro uses systemd. non-systemd distros can't use this script
echo "Stopping plasmashell..."
systemctl --user stop plasma-plasmashell.service

# config
echo "Configuring panel..."

# check existing panel id
EXISTING_ID=""
current_aid=""
while IFS= read -r line; do
    if [[ "$line" =~ ^\[.*\[Applets\]\[([0-9]+)\]$ ]]; then
        current_aid="${BASH_REMATCH[1]}"
    elif [ "$line" = "plugin=$PLASMOID_ID" ] && [ -n "$current_aid" ]; then
        EXISTING_ID="$current_aid"
        break
    fi
done < "$CONFIG"

if [ -n "$EXISTING_ID" ] && grep "AppletOrder=" "$CONFIG" | grep -qE "(^|;)$EXISTING_ID(;|$)"; then
    echo "Already installed and in panel, skipping."
    systemctl --user start plasma-plasmashell.service
    exit 0
fi

# find the bottom panel containment (location=4, formfactor=2)
CONTAINMENT_ID=""
while IFS= read -r cid; do
    loc=$(kreadconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group Containments --group "$cid" --key location)
    ff=$(kreadconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group Containments --group "$cid" --key formfactor)
    if [ "$loc" = "4" ] && [ "$ff" = "2" ]; then
        CONTAINMENT_ID="$cid"
        break
    fi
done < <(grep -oP '^\[Containments\]\[\K\d+(?=\]$)' "$CONFIG")

[ -n "$CONTAINMENT_ID" ] || { echo "ERROR: no bottom panel found"; exit 1; }
echo "Panel containment: $CONTAINMENT_ID"

# find the kicker/kickoff applet ID within the panel
KICKER_ID=""
while IFS= read -r aid; do
    plugin=$(kreadconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
        --group Containments --group "$CONTAINMENT_ID" --group Applets --group "$aid" --key plugin)
    if echo "$plugin" | grep -qE 'org\.kde\.plasma\.kick(er|off)'; then
        KICKER_ID="$aid"
        break
    fi
done < <(grep -oP "^\[Containments\]\[$CONTAINMENT_ID\]\[Applets\]\[\K\d+(?=\]$)" "$CONFIG")

[ -n "$KICKER_ID" ] || echo "WARNING: menu applet not found, will append to end"
echo "Kicker ID: $KICKER_ID"

# reuse existing ID if config section is already there, otherwise create a new one
if [ -n "$EXISTING_ID" ]; then
    NEW_ID="$EXISTING_ID"
    echo "Reusing existing applet ID: $NEW_ID"
else
    MAX_ID=$(grep -oP '(?<=\[Applets\]\[)\d+' "$CONFIG" | sort -n | tail -1)
    NEW_ID=$((MAX_ID + 1))
    echo "New applet ID: $NEW_ID"

    cat >> "$CONFIG" << EOF

[Containments][$CONTAINMENT_ID][Applets][$NEW_ID]
immutability=1
plugin=$PLASMOID_ID

[Containments][$CONTAINMENT_ID][Applets][$NEW_ID][Configuration][General]
borderEnabledSelected=false
borderEnabledUnselected=false
boxPadding=1
boxWidth=16
cornerRadius=0
shadingColorSelected=#555555
shadingEnabledUnselected=false
EOF
fi

# insert or append NEW_ID after KICKER_ID in AppletOrder
CURRENT_ORDER=$(kreadconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
    --group Containments --group "$CONTAINMENT_ID" --group General --key AppletOrder)

if [ -n "$KICKER_ID" ]; then
    NEW_ORDER=$(echo "$CURRENT_ORDER" | \
        sed -E "s/(^|;)$KICKER_ID(;|$)/\1$KICKER_ID;$NEW_ID\2/")
else
    NEW_ORDER="$CURRENT_ORDER;$NEW_ID"
fi

kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc \
    --group Containments --group "$CONTAINMENT_ID" --group General \
    --key AppletOrder "$NEW_ORDER"

echo "AppletOrder: $NEW_ORDER"

# --replace handles both suspend and replacing plasmashell
echo "Restarting plasmashell..."
plasmashell --replace > /dev/null 2>&1 &
disown

echo "Done."
