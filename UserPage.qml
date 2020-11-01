import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 40

        Item {
            x: 10
            height: 40
            CustomText { text: qsTr("User: ") + Settings.userName; textSize: 2}
        }
        CustomButton {
            width: 100
            buttonText: "Log out"
            anchors.right: parent.right
//            anchors.bottom: parent.bottom
            onClicked: {
                Settings.userName = ""
                Settings.authorized = 0
                authVisible = true
            }
        }
    }

    property int stackIndex: 0
    ButtonGroup { id: group }
    Row {
        id: radioWrapper
        x: 10
        spacing: 10
        anchors.top: header.bottom

        UserRadioButton {
            buttonGroup: group
            buttonText: "Library"
            _checked: true
            onClicked: {
                stackIndex = 0
                stackView.pop("UserPageAllMusics.qml")
            }
        }
//        UserRadioButton { buttonGroup: group; buttonText: "Playlists" }
        UserRadioButton {
            buttonGroup: group
            buttonText: "Favourite"
            onClicked: {
                if (!stackIndex)
                    stackView.push("UserPageFavourite.qml")
                stackIndex = 1
            }
        }
    }

    Rectangle {
        id: separator
        color: _textColor
        width: parent.width - 20
        height: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: radioWrapper.bottom
        opacity: 0.5
    }

    Item  {
        id: userStack
        width: parent.width - 20
        height: root.height - header.height - radioWrapper.height - separator.height
        anchors.top: separator.bottom
        anchors.horizontalCenter: parent.horizontalCenter
//        color: _backGroundColor
//        border.color: _themeColor

        StackView {
            id: stackView
            initialItem: "UserPageAllMusics.qml"
            anchors.fill: parent
            clip: true
        }
    }
}
