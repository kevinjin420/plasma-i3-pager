import QtQuick
import QtQuick.Controls as QC2
import QtQuick.Layouts as Layouts
import QtQuick.Dialogs
import org.kde.kirigami as Kirigami

Layouts.ColumnLayout {
    id: root

    property string title: i18n("Appearance")

    // Dimensions
    property int cfg_heightMode
    property int cfg_heightModeDefault: 0
    property int cfg_boxWidth
    property int cfg_boxWidthDefault: 18
    property int cfg_boxHeight
    property int cfg_boxHeightDefault: 24
    property int cfg_boxPadding
    property int cfg_boxPaddingDefault: 2
    property int cfg_spacing
    property int cfg_spacingDefault: 4

    // Text
    property int cfg_fontSize
    property int cfg_fontSizeDefault: 14
    property bool cfg_fontBold
    property bool cfg_fontBoldDefault: false
    property bool cfg_textEnabledSelected
    property bool cfg_textEnabledSelectedDefault: true
    property bool cfg_textEnabledUnselected
    property bool cfg_textEnabledUnselectedDefault: true
    property string cfg_textColorSelected
    property string cfg_textColorSelectedDefault: "#ffffff"
    property string cfg_textColorUnselected
    property string cfg_textColorUnselectedDefault: "#ffffff"

    // Style
    property int cfg_cornerRadius
    property int cfg_cornerRadiusDefault: 4

    // Border
    property bool cfg_borderEnabledSelected
    property bool cfg_borderEnabledSelectedDefault: true
    property bool cfg_borderEnabledUnselected
    property bool cfg_borderEnabledUnselectedDefault: true
    property int cfg_borderWidth
    property int cfg_borderWidthDefault: 1
    property string cfg_borderColorSelected
    property string cfg_borderColorSelectedDefault: "#3daee9"
    property string cfg_borderColorUnselected
    property string cfg_borderColorUnselectedDefault: "#76797c"

    // Shading
    property bool cfg_shadingEnabledSelected
    property bool cfg_shadingEnabledSelectedDefault: true
    property bool cfg_shadingEnabledUnselected
    property bool cfg_shadingEnabledUnselectedDefault: true
    property string cfg_shadingColorSelected
    property string cfg_shadingColorSelectedDefault: "#3daee9"
    property string cfg_shadingColorUnselected
    property string cfg_shadingColorUnselectedDefault: "#31363b"

    component ColorPicker: Layouts.RowLayout {
        id: picker
        property string colorValue

        Rectangle {
            width: 24; height: 24
            color: picker.colorValue
            border.width: 1
            border.color: Kirigami.Theme.textColor
            radius: 2

            MouseArea {
                anchors.fill: parent
                onClicked: dialogLoader.item.open()
            }
        }

        QC2.TextField {
            text: picker.colorValue
            onEditingFinished: picker.colorValue = text
            Layouts.Layout.preferredWidth: 80
        }

        Loader {
            id: dialogLoader
            active: false
            sourceComponent: ColorDialog {
                selectedColor: picker.colorValue
                onAccepted: picker.colorValue = selectedColor
            }
        }

        Component.onCompleted: dialogLoader.active = true
    }

    function resetToDefaults() {
        cfg_heightMode = cfg_heightModeDefault
        cfg_boxWidth = cfg_boxWidthDefault
        cfg_boxHeight = cfg_boxHeightDefault
        cfg_boxPadding = cfg_boxPaddingDefault
        cfg_spacing = cfg_spacingDefault
        cfg_fontSize = cfg_fontSizeDefault
        cfg_fontBold = cfg_fontBoldDefault
        cfg_textEnabledSelected = cfg_textEnabledSelectedDefault
        cfg_textEnabledUnselected = cfg_textEnabledUnselectedDefault
        cfg_textColorSelected = cfg_textColorSelectedDefault
        cfg_textColorUnselected = cfg_textColorUnselectedDefault
        cfg_cornerRadius = cfg_cornerRadiusDefault
        cfg_borderEnabledSelected = cfg_borderEnabledSelectedDefault
        cfg_borderEnabledUnselected = cfg_borderEnabledUnselectedDefault
        cfg_borderWidth = cfg_borderWidthDefault
        cfg_borderColorSelected = cfg_borderColorSelectedDefault
        cfg_borderColorUnselected = cfg_borderColorUnselectedDefault
        cfg_shadingEnabledSelected = cfg_shadingEnabledSelectedDefault
        cfg_shadingEnabledUnselected = cfg_shadingEnabledUnselectedDefault
        cfg_shadingColorSelected = cfg_shadingColorSelectedDefault
        cfg_shadingColorUnselected = cfg_shadingColorUnselectedDefault
    }

    QC2.ScrollView {
        Layouts.Layout.fillWidth: true
        Layouts.Layout.fillHeight: true

        Kirigami.FormLayout {
            // Dimensions
            Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Dimensions") }

            QC2.SpinBox {
                Kirigami.FormData.label: i18n("Box width:")
                from: 8; to: 100
                value: cfg_boxWidth
                onValueChanged: cfg_boxWidth = value
            }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Box height:")

                QC2.ComboBox {
                    model: [i18n("Fill"), i18n("Manual")]
                    currentIndex: cfg_heightMode
                    onCurrentIndexChanged: cfg_heightMode = currentIndex
                    implicitWidth: 100
                }
                QC2.Label { visible: cfg_heightMode === 0; text: i18n("padding:"); opacity: 0.7 }
                QC2.SpinBox {
                    visible: cfg_heightMode === 0
                    from: 0; to: 20
                    value: cfg_boxPadding
                    onValueChanged: cfg_boxPadding = value
                }
                QC2.Label { visible: cfg_heightMode === 1; text: i18n("height:"); opacity: 0.7 }
                QC2.SpinBox {
                    visible: cfg_heightMode === 1
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

            // Text
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

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Current desktop:")
                QC2.CheckBox {
                    checked: cfg_textEnabledSelected
                    onCheckedChanged: cfg_textEnabledSelected = checked
                }
                ColorPicker {
                    enabled: cfg_textEnabledSelected
                    colorValue: cfg_textColorSelected
                    onColorValueChanged: cfg_textColorSelected = colorValue
                }
            }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Other desktops:")
                QC2.CheckBox {
                    checked: cfg_textEnabledUnselected
                    onCheckedChanged: cfg_textEnabledUnselected = checked
                }
                ColorPicker {
                    enabled: cfg_textEnabledUnselected
                    colorValue: cfg_textColorUnselected
                    onColorValueChanged: cfg_textColorUnselected = colorValue
                }
            }

            // Style
            Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Style") }

            QC2.SpinBox {
                Kirigami.FormData.label: i18n("Corner radius:")
                from: 0; to: 20
                value: cfg_cornerRadius
                onValueChanged: cfg_cornerRadius = value
            }

            // Border
            Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Border") }

            QC2.SpinBox {
                Kirigami.FormData.label: i18n("Border width:")
                from: 1; to: 10
                value: cfg_borderWidth
                onValueChanged: cfg_borderWidth = value
            }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Current desktop:")
                QC2.CheckBox {
                    checked: cfg_borderEnabledSelected
                    onCheckedChanged: cfg_borderEnabledSelected = checked
                }
                ColorPicker {
                    enabled: cfg_borderEnabledSelected
                    colorValue: cfg_borderColorSelected
                    onColorValueChanged: cfg_borderColorSelected = colorValue
                }
            }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Other desktops:")
                QC2.CheckBox {
                    checked: cfg_borderEnabledUnselected
                    onCheckedChanged: cfg_borderEnabledUnselected = checked
                }
                ColorPicker {
                    enabled: cfg_borderEnabledUnselected
                    colorValue: cfg_borderColorUnselected
                    onColorValueChanged: cfg_borderColorUnselected = colorValue
                }
            }

            // Shading
            Item { Kirigami.FormData.isSection: true; Kirigami.FormData.label: i18n("Shading") }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Current desktop:")
                QC2.CheckBox {
                    checked: cfg_shadingEnabledSelected
                    onCheckedChanged: cfg_shadingEnabledSelected = checked
                }
                ColorPicker {
                    enabled: cfg_shadingEnabledSelected
                    colorValue: cfg_shadingColorSelected
                    onColorValueChanged: cfg_shadingColorSelected = colorValue
                }
            }

            Layouts.RowLayout {
                Kirigami.FormData.label: i18n("Other desktops:")
                QC2.CheckBox {
                    checked: cfg_shadingEnabledUnselected
                    onCheckedChanged: cfg_shadingEnabledUnselected = checked
                }
                ColorPicker {
                    enabled: cfg_shadingEnabledUnselected
                    colorValue: cfg_shadingColorUnselected
                    onColorValueChanged: cfg_shadingColorUnselected = colorValue
                }
            }

            // Reset
            Item { Kirigami.FormData.isSection: true }

            QC2.Button {
                text: i18n("Reset to Defaults")
                icon.name: "edit-undo"
                onClicked: root.resetToDefaults()
            }
        }
    }
}
