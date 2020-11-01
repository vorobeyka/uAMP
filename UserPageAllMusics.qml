import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    Item {
        width: parent.width
        height: 50

        Row {
            x: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            CustomText { text: "Sort by: " }
            MouseArea {
                id: sortButton
                width: 60
                height: 20
                CustomText { id: sortText; text: "Title"; color: _themeColor }
                onClicked: sortPopup.open()
            }
        }

        Popup {
            id: sortPopup
            width: 100
            padding: 0
            x: 100
            modal: true
            focus: true

            Column {
                spacing: 0
                anchors.fill: parent
                Repeater {
                    model: ["Title", "Artist", "Album", "Rating", "Most played", "Newest"]
                    RadioButton {
                        width: parent.width
                        height: 20
                        checked: !index ? true : false

                        indicator: Rectangle {
                            anchors.fill: parent
                            color: parent.checked ? _themeColor : _toolBarBackGroundColor
                            CustomText { x: 10; text: modelData }
                        }
                        onClicked: {
                            sortPopup.close()
                            sortText.text = modelData
                        }
                    }
                }
            }
        }
    }

    ScrollView {
        id: scroll
        width: parent.width
        height: parent.height - 50
        y: 50
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            model: 20
            delegate: MusicDelegate {
                _index: model.index
                width: scroll.width
                height: 40
                bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
            }
        }
    }
}
