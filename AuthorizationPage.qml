import QtQuick 2.0

Rectangle {
    id: root
    color: settings.backGroundColor

    Text {
        anchors.centerIn: parent
        text: qsTr("Authorization page")
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: settings.textColor
    }

    AppSettings { id: settings }
}
