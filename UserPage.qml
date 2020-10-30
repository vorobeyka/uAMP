import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root

    Rectangle {
        id: header
        width: parent.width
        height: 40
        color: _backGroundColor
        border.color: _themeColor
        border.width: 5
        Item {
            x: 10
            height: 40
            CustomText { text: qsTr("User: ") + Settings.userName; textSize: 2}
        }
    }

    Rectangle {
        id: radioWrapper
        width: parent.width
        height: 40
        color: _backGroundColor
//        border.color: _themeColor
        anchors.top: header.bottom
        ButtonGroup { id: group }
        Row {
            x: 10
            spacing: 10
            UserRadioButton { buttonGroup: group; buttonText: "All musics" }
            UserRadioButton { buttonGroup: group; buttonText: "Playlists" }
            UserRadioButton { buttonGroup: group; buttonText: "blyat" }
        }
    }

    Rectangle {
        id: separator
        color: _textColor
        width: parent.width - 20
        height: 2
        radius: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: radioWrapper.bottom
        opacity: 0.5
    }

    CustomButton {
        width: 100
        buttonText: "Log out"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            Settings.userName = ""
            Settings.authorized = 0
            authVisible = true
        }
    }
}
