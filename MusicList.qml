import QtQuick 2.0

Rectangle {
    id: root
    color: _backGroundColor
    border.color: _themeColor

    Text {
        anchors.centerIn: parent
        text: qsTr("MusicList")
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: _textColor
    }
}
