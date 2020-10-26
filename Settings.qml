import QtQuick 2.0

Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 50

        CustomText {
            text: qsTr("Settings")
            anchors.horizontalCenter: parent.horizontalCenter
            textSize: 2
        }
    }

    Column {
        id: content
        width: parent.width
        height: parent.height - 100
        anchors.top: header.bottom
        Rectangle {
            width: parent.width
            height: 100
            color: settings.backGroundColor
            border.color: settings.themeColor
        }
        Rectangle {
            width: parent.width
            height: 100
            color: settings.backGroundColor
            border.color: settings.themeColor
        }
        Rectangle {
            width: parent.width
            height: 100
            color: settings.backGroundColor
            border.color: settings.themeColor
        }
    }

    Item {
        id: footer
        width: parent.width
        height: 50
    }

    AppSettings { id: settings }
}
