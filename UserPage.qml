import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 100

        Column {
            id: userInfo
            width: parent.width
            height: 100
            x: 10

            Item {
                height: 50
                width: 100
                CustomText { text: qsTr("User: ") + Settings.userName; textSize: 2}
            }
        }
    }

    Column {
        id: logInButtons
        width: 200
        anchors.centerIn: parent
        spacing: 10


    }

    Item {
        id: footer
        height: 100
        width: parent.width
        anchors.bottom: parent.bottom

        CustomButton {
            width: 100
            buttonText: "Log out"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onClicked: {
                Settings.userName = ""
                Settings.authorized = 0
                authVisible = true
//                root.visible = false
            }
        }
    }

    AppSettings { id: settings }
}
