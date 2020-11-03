import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    Item {
        id: header
        width: parent.width
        height: 50

        Row {
            x: 10
            height: parent.height - 1
            spacing: 5

            Image {
                id: icon
                source: "/images/radio"
                visible: false
            }

            ColorOverlay {
                id: coloredicon
                anchors.verticalCenter: parent.verticalCenter
                source: icon
                color: _textColor
                width: 25
                height: 25
                opacity: 0.8
            }

            CustomText { text: "Radio"; textSize: 2 }
        }

        Rectangle {
            id: separator
            color: _textColor
            width: parent.width - 20
            height: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: header.bottom
            opacity: 0.5
        }
    }
}
