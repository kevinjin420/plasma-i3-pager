import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.pager

PlasmoidItem {
    id: root

    readonly property int desktopCount: pagerModel.count
    readonly property bool isHorizontal: Plasmoid.formFactor !== PlasmaCore.Types.Vertical

    readonly property int contentWidth: isHorizontal
        ? (Plasmoid.configuration.boxWidth * desktopCount) + (Plasmoid.configuration.spacing * Math.max(0, desktopCount - 1))
        : Plasmoid.configuration.boxWidth
    readonly property int contentHeight: isHorizontal
        ? Plasmoid.configuration.boxHeight
        : (Plasmoid.configuration.boxHeight * desktopCount) + (Plasmoid.configuration.spacing * Math.max(0, desktopCount - 1))
    readonly property int totalWidth: contentWidth + (Plasmoid.configuration.paddingHorizontal * 2)
    readonly property int totalHeight: contentHeight + (Plasmoid.configuration.paddingVertical * 2)

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
            anchors.centerIn: parent
            columns: root.isHorizontal ? root.desktopCount : 1
            rows: root.isHorizontal ? 1 : root.desktopCount
            spacing: Plasmoid.configuration.spacing

            Repeater {
                model: pagerModel.count

                Rectangle {
                    id: box
                    width: Plasmoid.configuration.boxWidth
                    height: Plasmoid.configuration.boxHeight
                    radius: Plasmoid.configuration.cornerRadius

                    property bool active: index === pagerModel.currentPage

                    color: Plasmoid.configuration.shadingEnabled
                        ? (active ? Plasmoid.configuration.shadingColorSelected : Plasmoid.configuration.shadingColorUnselected)
                        : "transparent"

                    border.width: Plasmoid.configuration.borderEnabled ? Plasmoid.configuration.borderWidth : 0
                    border.color: Plasmoid.configuration.borderEnabled
                        ? (active ? Plasmoid.configuration.borderColorSelected : Plasmoid.configuration.borderColorUnselected)
                        : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                        color: box.active
                            ? Plasmoid.configuration.textColorSelected
                            : Plasmoid.configuration.textColorUnselected
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
