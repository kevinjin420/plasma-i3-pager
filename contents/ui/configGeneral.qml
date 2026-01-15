import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as QtLayouts
import QtQuick.Dialogs
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

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

    Kirigami.FormLayout {

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Dimensions")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Box size:")
            QC2.SpinBox {
                id: boxWidthSpinBox
                from: 8
                to: 100
                value: cfg_boxWidth
                onValueChanged: cfg_boxWidth = value
            }
            QC2.Label { text: "x" }
            QC2.SpinBox {
                id: boxHeightSpinBox
                from: 8
                to: 100
                value: cfg_boxHeight
                onValueChanged: cfg_boxHeight = value
            }
        }

        QC2.SpinBox {
            id: spacingSpinBox
            Kirigami.FormData.label: i18n("Box spacing:")
            from: 0
            to: 20
            value: cfg_spacing
            onValueChanged: cfg_spacing = value
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Padding:")
            QC2.SpinBox {
                id: paddingHSpinBox
                from: 0
                to: 20
                value: cfg_paddingHorizontal
                onValueChanged: cfg_paddingHorizontal = value
            }
            QC2.Label { text: "x" }
            QC2.SpinBox {
                id: paddingVSpinBox
                from: 0
                to: 20
                value: cfg_paddingVertical
                onValueChanged: cfg_paddingVertical = value
            }
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Text")
        }

        QC2.SpinBox {
            id: fontSizeSpinBox
            Kirigami.FormData.label: i18n("Font size:")
            from: 8
            to: 32
            value: cfg_fontSize
            onValueChanged: cfg_fontSize = value
        }

        QC2.CheckBox {
            id: fontBoldCheckBox
            Kirigami.FormData.label: i18n("Bold font:")
            checked: cfg_fontBold
            onCheckedChanged: cfg_fontBold = checked
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Text selected:")
            Rectangle {
                width: 24; height: 24
                color: cfg_textColorSelected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: textSelectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_textColorSelected
                onTextChanged: cfg_textColorSelected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Text unselected:")
            Rectangle {
                width: 24; height: 24
                color: cfg_textColorUnselected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: textUnselectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_textColorUnselected
                onTextChanged: cfg_textColorUnselected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Style")
        }

        QC2.SpinBox {
            id: cornerRadiusSpinBox
            Kirigami.FormData.label: i18n("Corner radius:")
            from: 0
            to: 20
            value: cfg_cornerRadius
            onValueChanged: cfg_cornerRadius = value
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Border")
        }

        QC2.CheckBox {
            id: borderEnabledCheckBox
            Kirigami.FormData.label: i18n("Border enabled:")
            checked: cfg_borderEnabled
            onCheckedChanged: cfg_borderEnabled = checked
        }

        QC2.SpinBox {
            id: borderWidthSpinBox
            Kirigami.FormData.label: i18n("Border width:")
            from: 1
            to: 10
            enabled: cfg_borderEnabled
            value: cfg_borderWidth
            onValueChanged: cfg_borderWidth = value
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Border selected:")
            enabled: cfg_borderEnabled
            Rectangle {
                width: 24; height: 24
                color: cfg_borderColorSelected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: borderSelectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_borderColorSelected
                onTextChanged: cfg_borderColorSelected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Border unselected:")
            enabled: cfg_borderEnabled
            Rectangle {
                width: 24; height: 24
                color: cfg_borderColorUnselected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: borderUnselectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_borderColorUnselected
                onTextChanged: cfg_borderColorUnselected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Shading")
        }

        QC2.CheckBox {
            id: shadingEnabledCheckBox
            Kirigami.FormData.label: i18n("Shading enabled:")
            checked: cfg_shadingEnabled
            onCheckedChanged: cfg_shadingEnabled = checked
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Shading selected:")
            enabled: cfg_shadingEnabled
            Rectangle {
                width: 24; height: 24
                color: cfg_shadingColorSelected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: shadingSelectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_shadingColorSelected
                onTextChanged: cfg_shadingColorSelected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Shading unselected:")
            enabled: cfg_shadingEnabled
            Rectangle {
                width: 24; height: 24
                color: cfg_shadingColorUnselected
                border.width: 1
                border.color: Kirigami.Theme.textColor
                MouseArea {
                    anchors.fill: parent
                    onClicked: shadingUnselectedDialog.open()
                }
            }
            QC2.TextField {
                text: cfg_shadingColorUnselected
                onTextChanged: cfg_shadingColorUnselected = text
                QtLayouts.Layout.preferredWidth: 80
            }
        }
    }

    Item {
        QtLayouts.Layout.fillHeight: true
    }

    ColorDialog {
        id: textSelectedDialog
        selectedColor: cfg_textColorSelected
        onAccepted: cfg_textColorSelected = selectedColor
    }
    ColorDialog {
        id: textUnselectedDialog
        selectedColor: cfg_textColorUnselected
        onAccepted: cfg_textColorUnselected = selectedColor
    }
    ColorDialog {
        id: borderSelectedDialog
        selectedColor: cfg_borderColorSelected
        onAccepted: cfg_borderColorSelected = selectedColor
    }
    ColorDialog {
        id: borderUnselectedDialog
        selectedColor: cfg_borderColorUnselected
        onAccepted: cfg_borderColorUnselected = selectedColor
    }
    ColorDialog {
        id: shadingSelectedDialog
        selectedColor: cfg_shadingColorSelected
        onAccepted: cfg_shadingColorSelected = selectedColor
    }
    ColorDialog {
        id: shadingUnselectedDialog
        selectedColor: cfg_shadingColorUnselected
        onAccepted: cfg_shadingColorUnselected = selectedColor
    }
}
