import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as QtLayouts
import QtQuick.Dialogs
import org.kde.kirigami as Kirigami

QtLayouts.ColumnLayout {
    id: configPage

    property string title: i18n("Appearance")

    property int cfg_boxWidth
    property int cfg_boxWidthDefault: 24
    property int cfg_boxHeight
    property int cfg_boxHeightDefault: 24
    property int cfg_spacing
    property int cfg_spacingDefault: 4
    property int cfg_paddingHorizontal
    property int cfg_paddingHorizontalDefault: 0
    property int cfg_paddingVertical
    property int cfg_paddingVerticalDefault: 0
    property int cfg_fontSize
    property int cfg_fontSizeDefault: 12
    property bool cfg_fontBold
    property bool cfg_fontBoldDefault: false
    property string cfg_textColorSelected
    property string cfg_textColorSelectedDefault: "#ffffff"
    property string cfg_textColorUnselected
    property string cfg_textColorUnselectedDefault: "#eff0f1"
    property int cfg_cornerRadius
    property int cfg_cornerRadiusDefault: 4
    property bool cfg_borderEnabled
    property bool cfg_borderEnabledDefault: true
    property int cfg_borderWidth
    property int cfg_borderWidthDefault: 1
    property string cfg_borderColorSelected
    property string cfg_borderColorSelectedDefault: "#3daee9"
    property string cfg_borderColorUnselected
    property string cfg_borderColorUnselectedDefault: "#76797c"
    property bool cfg_shadingEnabled
    property bool cfg_shadingEnabledDefault: true
    property string cfg_shadingColorSelected
    property string cfg_shadingColorSelectedDefault: "#3daee9"
    property string cfg_shadingColorUnselected
    property string cfg_shadingColorUnselectedDefault: "#31363b"

    component ColorPicker: QtLayouts.RowLayout {
        property string colorValue
        property alias dialogTitle: colorDialog.title

        Rectangle {
            width: 24
            height: 24
            color: colorValue
            border.width: 1
            border.color: Kirigami.Theme.textColor
            radius: 2
            MouseArea {
                anchors.fill: parent
                onClicked: colorDialog.open()
            }
        }
        QC2.TextField {
            text: colorValue
            onTextChanged: colorValue = text
            QtLayouts.Layout.preferredWidth: 80
        }
        ColorDialog {
            id: colorDialog
            selectedColor: colorValue
            onAccepted: colorValue = selectedColor
        }
    }

    Kirigami.FormLayout {
        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Dimensions") }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Box size:")
            QC2.SpinBox {
                from: 8; to: 100
                value: cfg_boxWidth
                onValueChanged: cfg_boxWidth = value
            }
            QC2.Label { text: "x" }
            QC2.SpinBox {
                from: 8; to: 100
                value: cfg_boxHeight
                onValueChanged: cfg_boxHeight = value
            }
        }

        QC2.SpinBox {
            Kirigami.FormData.label: i18n("Box spacing:")
            from: 0; to: 20
            value: cfg_spacing
            onValueChanged: cfg_spacing = value
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Padding:")
            QC2.SpinBox {
                from: 0; to: 20
                value: cfg_paddingHorizontal
                onValueChanged: cfg_paddingHorizontal = value
            }
            QC2.Label { text: "x" }
            QC2.SpinBox {
                from: 0; to: 20
                value: cfg_paddingVertical
                onValueChanged: cfg_paddingVertical = value
            }
        }

        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Text") }

        QC2.SpinBox {
            Kirigami.FormData.label: i18n("Font size:")
            from: 8; to: 32
            value: cfg_fontSize
            onValueChanged: cfg_fontSize = value
        }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Bold font:")
            checked: cfg_fontBold
            onCheckedChanged: cfg_fontBold = checked
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Text selected:")
            colorValue: cfg_textColorSelected
            onColorValueChanged: cfg_textColorSelected = colorValue
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Text unselected:")
            colorValue: cfg_textColorUnselected
            onColorValueChanged: cfg_textColorUnselected = colorValue
        }

        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Style") }

        QC2.SpinBox {
            Kirigami.FormData.label: i18n("Corner radius:")
            from: 0; to: 20
            value: cfg_cornerRadius
            onValueChanged: cfg_cornerRadius = value
        }

        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Border") }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Border enabled:")
            checked: cfg_borderEnabled
            onCheckedChanged: cfg_borderEnabled = checked
        }

        QC2.SpinBox {
            Kirigami.FormData.label: i18n("Border width:")
            from: 1; to: 10
            enabled: cfg_borderEnabled
            value: cfg_borderWidth
            onValueChanged: cfg_borderWidth = value
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Border selected:")
            enabled: cfg_borderEnabled
            colorValue: cfg_borderColorSelected
            onColorValueChanged: cfg_borderColorSelected = colorValue
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Border unselected:")
            enabled: cfg_borderEnabled
            colorValue: cfg_borderColorUnselected
            onColorValueChanged: cfg_borderColorUnselected = colorValue
        }

        Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Shading") }

        QC2.CheckBox {
            Kirigami.FormData.label: i18n("Shading enabled:")
            checked: cfg_shadingEnabled
            onCheckedChanged: cfg_shadingEnabled = checked
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Shading selected:")
            enabled: cfg_shadingEnabled
            colorValue: cfg_shadingColorSelected
            onColorValueChanged: cfg_shadingColorSelected = colorValue
        }

        ColorPicker {
            Kirigami.FormData.label: i18n("Shading unselected:")
            enabled: cfg_shadingEnabled
            colorValue: cfg_shadingColorUnselected
            onColorValueChanged: cfg_shadingColorUnselected = colorValue
        }
    }

    Item { QtLayouts.Layout.fillHeight: true }
}
