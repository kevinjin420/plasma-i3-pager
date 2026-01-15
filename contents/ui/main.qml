import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.pager
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    readonly property int boxWidth: Plasmoid.configuration.boxWidth
    readonly property int boxHeight: Plasmoid.configuration.boxHeight
    readonly property int boxSpacing: Plasmoid.configuration.spacing
    readonly property int paddingH: Plasmoid.configuration.paddingHorizontal
    readonly property int paddingV: Plasmoid.configuration.paddingVertical
    readonly property int desktopCount: pagerModel.count
    readonly property bool isHorizontal: Plasmoid.formFactor !== PlasmaCore.Types.Vertical

    readonly property int contentWidth: isHorizontal
        ? (boxWidth * desktopCount) + (boxSpacing * Math.max(0, desktopCount - 1))
        : boxWidth
    readonly property int contentHeight: isHorizontal
        ? boxHeight
        : (boxHeight * desktopCount) + (boxSpacing * Math.max(0, desktopCount - 1))
    readonly property int totalWidth: contentWidth + (paddingH * 2)
    readonly property int totalHeight: contentHeight + (paddingV * 2)

    readonly property int cornerRadius: Plasmoid.configuration.cornerRadius
    readonly property bool borderEnabled: Plasmoid.configuration.borderEnabled
    readonly property int borderWidth: Plasmoid.configuration.borderWidth
    readonly property color borderColorSelected: Plasmoid.configuration.borderColorSelected
    readonly property color borderColorUnselected: Plasmoid.configuration.borderColorUnselected
    readonly property bool shadingEnabled: Plasmoid.configuration.shadingEnabled
    readonly property color shadingColorSelected: Plasmoid.configuration.shadingColorSelected
    readonly property color shadingColorUnselected: Plasmoid.configuration.shadingColorUnselected
    readonly property color textColorSelected: Plasmoid.configuration.textColorSelected
    readonly property color textColorUnselected: Plasmoid.configuration.textColorUnselected

    preferredRepresentation: fullRepresentation

    Layout.minimumWidth: totalWidth
    Layout.maximumWidth: totalWidth
    Layout.preferredWidth: totalWidth
    Layout.minimumHeight: totalHeight
    Layout.maximumHeight: totalHeight
    Layout.preferredHeight: totalHeight

    PagerModel {
        id: pagerModel
        enabled: true
        showDesktop: false
        screenGeometry: Plasmoid.containment.screenGeometry
        pagerType: PagerModel.VirtualDesktops
    }

    fullRepresentation: Item {
        implicitWidth: root.totalWidth
        implicitHeight: root.totalHeight

        Grid {
            id: container
            anchors.centerIn: parent
            columns: root.isHorizontal ? root.desktopCount : 1
            rows: root.isHorizontal ? 1 : root.desktopCount
            spacing: root.boxSpacing

            Repeater {
                model: pagerModel.count

                Rectangle {
                    id: desktopBox
                    width: root.boxWidth
                    height: root.boxHeight
                    radius: root.cornerRadius

                    property bool isActive: index === pagerModel.currentPage

                    color: root.shadingEnabled
                        ? (isActive ? root.shadingColorSelected : root.shadingColorUnselected)
                        : "transparent"

                    border.width: root.borderEnabled ? root.borderWidth : 0
                    border.color: root.borderEnabled
                        ? (isActive ? root.borderColorSelected : root.borderColorUnselected)
                        : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                        color: desktopBox.isActive
                            ? root.textColorSelected
                            : root.textColorUnselected
                        font.pixelSize: Plasmoid.configuration.fontSize
                        font.bold: Plasmoid.configuration.fontBold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: pagerModel.changePage(index)
                    }
                }
            }
        }
    }
}
