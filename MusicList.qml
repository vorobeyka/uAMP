import QtQuick 2.0

Rectangle {
    id: root
    color: settings.backGroundColor
    border.color: settings.themeColor

    Text {
        anchors.centerIn: parent
        text: qsTr("MusicList")
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: settings.textColor
    }

    AppSettings { id: settings }
}
