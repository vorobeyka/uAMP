import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

Item {
    id: root
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
    Column {
        y: header.height + 10
        x: 10
        spacing: 10
        Text {
            text: "Streams online radio\nPut url in field to add stream"
            color: _textColor
            font.pixelSize: Qt.application.font.pixelSize * 1.2
        }
        Row {
        CustomTextField {
            id: inputStream
            width: (root.width - 10) / 2
        }
        CustomButton { buttonText: "add" }
        }
    }

//    ScrollView {
//        id: scroll
//        anchors.horizontalCenter: parent.horizontalCenter
//        width: parent.width - 20
//        height: parent.height - header.height - 50
//        y: 50 + header.height
//        clip: true
//        ScrollBar.vertical.interactive: false
//        ScrollBar.horizontal.visible: false

//        ListView {
//            id: musicList
//            model: ListModel {}
//            delegate: MusicDelegate {
//                _index: model.index
//                width: scroll.width
//                height: 40
//                bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
//            }
//        }
//    }
}
