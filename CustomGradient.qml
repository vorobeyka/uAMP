import QtQuick 2.0
import QtGraphicalEffects 1.14

Item {
    anchors.fill: parent

    property int xxMouse: 0
    property string gradientColor: settings.themeColor

    LinearGradient {
        width: xMouse
        height: parent.height
        start: Qt.point(0, 0)
        end: Qt.point(xxMouse, 0)
        opacity: settings.opacityGradient
        gradient: Gradient {
            GradientStop { position: 0.0; color: settings.toolBarBackGroundColor }
            GradientStop { position: 1.0; color: gradientColor }
        }
    }
    LinearGradient {
        x: xMouse
        y: 0
        height: parent.height
        width: parent.width - xxMouse
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        opacity: settings.opacityGradient
        gradient: Gradient {
            GradientStop { position: 0.0; color: gradientColor }
            GradientStop { position: 1.0; color: settings.toolBarBackGroundColor }
        }
    }
}
