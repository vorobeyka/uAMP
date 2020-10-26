import QtQuick 2.0
import QtQuick.Controls 2.12

TextField {
    id: control
    width: parent.width
    font.pixelSize: Qt.application.font.pixelSize * 1.2
    color: settings.textColor
    background: Rectangle {
        anchors.fill: parent
        color: settings.backGroundColor
        border.color: control.activeFocus ? settings.themeColor : settings.textColor
    }

    AppSettings { id: settings }
}
