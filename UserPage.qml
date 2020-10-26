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
                CustomText { text: "userName" }
            }

            Item {
                height: 50
                width: 100
                CustomText { text: "userPassword" }
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
                root.visible = false
                isToolBarVisible = false
                authVisible = true
            }
        }
    }

    AppSettings { id: settings }
}
