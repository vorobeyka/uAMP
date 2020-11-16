import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 170
    height: 170
    property int _index: 0
    property string name: "PlaylistName"
    property bool isHovered: false
    Rectangle {
        id: bg
        width: 150
        height: 150
        color: isHovered ? _hoverColor : _backGroundColor
        border.color: _themeColor
        radius: 75
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: icon
            width: parent.width - 50
            height: parent.height - 50
            source: "/images/music-playlist"
            visible: false
            anchors.centerIn: parent
        }

        ColorOverlay {
            id: coloredIcon
            anchors.fill: icon
            source: icon
            color: _textColor
            opacity: 0.8
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: { isHovered = true }
            onExited: { isHovered = false }
            onClicked: {
                if (_initialItem !== "pledit") {
                    _currentPage.visible = false
                    _currentPage = _musicPlaylistEditPage
                    _currentPage.visible = true
                }
                _initialItem = "pledit"
                console.log("playlist index = ", _index)
            }
        }
    }
    Text {
        text: name
        color: _textColor
        font.pixelSize: Qt.application.font.pixelSize * 1.2
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
