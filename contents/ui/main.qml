import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.taskmanager
import org.kde.plasma.workspace.dbus as DBus

PlasmoidItem {
    id: root

    readonly property int desktopCount: desktopInfo.numberOfDesktops
    readonly property bool isHorizontal: Plasmoid.formFactor !== PlasmaCore.Types.Vertical
    readonly property bool fillHeight: Plasmoid.configuration.heightMode === 0

    readonly property int boxW: Plasmoid.configuration.boxWidth
    readonly property int boxH: fillHeight
        ? Math.max(8, (isHorizontal ? height : width) - Plasmoid.configuration.boxPadding * 2)
        : Plasmoid.configuration.boxHeight

    readonly property int contentWidth: isHorizontal
        ? boxW * desktopCount + Plasmoid.configuration.spacing * Math.max(0, desktopCount - 1)
        : boxW
    readonly property int contentHeight: isHorizontal
        ? boxH
        : boxH * desktopCount + Plasmoid.configuration.spacing * Math.max(0, desktopCount - 1)

    preferredRepresentation: fullRepresentation

    Layout.minimumWidth: contentWidth
    Layout.preferredWidth: contentWidth
    Layout.fillHeight: fillHeight
    Layout.minimumHeight: fillHeight ? -1 : boxH
    Layout.preferredHeight: fillHeight ? -1 : boxH

    function switchToDesktop(index) {
        DBus.SessionBus.asyncCall({
            service: "org.kde.KWin",
            path: "/VirtualDesktopManager",
            iface: "org.freedesktop.DBus.Properties",
            member: "Set",
            signature: "(ssv)",
            arguments: ["org.kde.KWin.VirtualDesktopManager", "current", new DBus.variant(desktopInfo.desktopIds[index])]
        })
    }

    VirtualDesktopInfo {
        id: desktopInfo
    }

    fullRepresentation: Item {
        implicitWidth: root.contentWidth
        implicitHeight: root.contentHeight

        Grid {
            anchors.centerIn: parent
            columns: root.isHorizontal ? root.desktopCount : 1
            rows: root.isHorizontal ? 1 : root.desktopCount
            spacing: Plasmoid.configuration.spacing

            Repeater {
                model: desktopInfo.numberOfDesktops

                Rectangle {
                    id: box
                    required property int index

                    property bool isActive: desktopInfo.desktopIds.indexOf(desktopInfo.currentDesktop) === index
                    property var cfg: Plasmoid.configuration

                    width: root.boxW
                    height: root.boxH
                    radius: cfg.cornerRadius

                    color: isActive
                        ? (cfg.shadingEnabledSelected ? cfg.shadingColorSelected : "transparent")
                        : (cfg.shadingEnabledUnselected ? cfg.shadingColorUnselected : "transparent")
                    border.width: isActive
                        ? (cfg.borderEnabledSelected ? cfg.borderWidth : 0)
                        : (cfg.borderEnabledUnselected ? cfg.borderWidth : 0)
                    border.color: isActive
                        ? (cfg.borderEnabledSelected ? cfg.borderColorSelected : "transparent")
                        : (cfg.borderEnabledUnselected ? cfg.borderColorUnselected : "transparent")

                    Text {
                        anchors.centerIn: parent
                        text: box.index + 1
                        visible: box.isActive ? cfg.textEnabledSelected : cfg.textEnabledUnselected
                        color: box.isActive ? cfg.textColorSelected : cfg.textColorUnselected
                        font.pixelSize: cfg.fontSize
                        font.bold: cfg.fontBold
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            if (cfg.clickToSwitch) switchToDesktop(box.index)
                        }

                        onWheel: function(wheel) {
                            if (!cfg.scrollEnabled) return

                            var delta = cfg.scrollInverted ? -wheel.angleDelta.y : wheel.angleDelta.y
                            var current = desktopInfo.desktopIds.indexOf(desktopInfo.currentDesktop)
                            var count = desktopInfo.numberOfDesktops
                            var next = current

                            if (delta > 0) {
                                next = current - 1
                                if (next < 0) next = cfg.scrollWrap ? count - 1 : 0
                            } else if (delta < 0) {
                                next = current + 1
                                if (next >= count) next = cfg.scrollWrap ? 0 : count - 1
                            }

                            if (next !== current) switchToDesktop(next)
                        }
                    }
                }
            }
        }
    }
}
