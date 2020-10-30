import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 100

        Item {
            x: 10
            height: 50
            width: 100
            CustomText { text: qsTr("User: ") + Settings.userName; textSize: 2}
        }
    }

    Column {

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

    AppSettings { id: settings }
}
