import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

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
                source: "/images/equalizer"
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

            CustomText { text: "Equalizer"; textSize: 2 }
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

    Rectangle {
        width: parent.width * 0.8
        height: (parent.height - header.height) * 0.8
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - header.height - height
        color: _backGroundColor
        border.color: _themeColor

        Column {
            id: column
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Row {
                id: rooooow
                x: parent.width / 7
                width: parent.width - parent
//                spacing: ((parent.width + 60) - (parent.width / 7) * 2) / 7
//                Repeater {
//                    id: repeater
//                    model: ["-12","-6","0","6","12"]
//                    delegate: CustomText { text: modelData }
//                }
            }
            Repeater {
                model: ["low", "medium low", "medium", "medium high", "high"]
                delegate: Item {
                    height: 40
                    width: column.width
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: _textColor
                        text: modelData
                        font.pixelSize: Qt.application.font.pixelSize * 1.2
                    }
                    CustomSlider {
                        id: slider
                        y: 30
                        value: 0
                        from: -12
                        to: 12
                        x: rooooow.x
                        width: column.width - (rooooow.x) * 2
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            text: slider.value.toFixed(1)
                            visible: slider.pressed
                            color: _textColor
                        }
                    }
                }
            }
            Component.onCompleted: {
                combo.model.append({appendText: "defalut"})
                combo.model.append({appendText: "syka"})
                combo.model.append({appendText: "blyat"})
                combo.model.append({appendText: "zzzz"})
                combo.model.append({appendText: "kek"})
            }

            ComboBox {
                id: combo
                x: rooooow.x
                width: parent.width - (rooooow.x) * 2
                height: 30
                flat: true

                background: Rectangle {
                    anchors.fill: combo
                    color: _backGroundColor
                    border.color: _themeColor
                }
                contentItem: Text {
                    leftPadding: 10
//                    rightPadding: combo.indicator.width + combo.spacing
                    text: combo.displayText
                    font: combo.font
                    color: combo.pressed ? _hoverColor : _textColor
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                currentIndex: 0
                model: ListModel {}
                delegate: Rectangle {
                    color: _backGroundColor
                    width: combo.width
                    height: 30
                    CustomText { id: comboTex; x: 10; clip: true; text: appendText }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            combo.focus = false
                            combo.currentIndex = index
                        }
                        hoverEnabled: true
                        onEntered: parent.color = _hoverColor
                        onExited: parent.color = _backGroundColor
                    }
                }
            }
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - (rooooow.x) * 2
                height: 40
                Row {
                    anchors.fill: parent
                    spacing: 10
                    CustomTextField { id: pressetName; width: parent.width * 0.6}
                    CustomButton {
                        width: 50
                        height: 30
                        buttonText: "Save"
                        onClicked: {
                            let tmp = pressetName.text
                            if (pressetName.length > 0 && pressetName) {
                                combo.model.append({ appendText: tmp })
                            }
                        }
                    }
                }
            }
        }
    }
}
