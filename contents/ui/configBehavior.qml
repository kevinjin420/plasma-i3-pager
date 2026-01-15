import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as Layouts
import org.kde.kirigami as Kirigami

Layouts.ColumnLayout {
    id: root

    property string title: i18n("Behavior")

    property bool cfg_clickToSwitch
    property bool cfg_clickToSwitchDefault: true
    property bool cfg_scrollEnabled
    property bool cfg_scrollEnabledDefault: true
    property bool cfg_scrollWrap
    property bool cfg_scrollWrapDefault: true
    property bool cfg_scrollInverted
    property bool cfg_scrollInvertedDefault: false

    Kirigami.FormLayout {
        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Click") }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Click to switch:")
            checked: cfg_clickToSwitch
            onCheckedChanged: cfg_clickToSwitch = checked
        }

        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Scroll") }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Scroll to switch:")
            checked: cfg_scrollEnabled
            onCheckedChanged: cfg_scrollEnabled = checked
        }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Wrap around:")
            enabled: cfg_scrollEnabled
            checked: cfg_scrollWrap
            onCheckedChanged: cfg_scrollWrap = checked
        }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Invert scroll:")
            enabled: cfg_scrollEnabled
            checked: cfg_scrollInverted
            onCheckedChanged: cfg_scrollInverted = checked
        }
    }

    Item { Layouts.Layout.fillHeight: true }
}
