import QtQuick 2.0

MouseArea {
    id: root
    width: parent.width
    height: 30

    property string bgColor: _backGroundColor
    property int _ingdex: 0

    Rectangle {
        id: backGround
        anchors.fill: parent
        color: bgColor
    }

    Row {
        anchors.fill: parent
    }

    onClicked: console.log("syka")
}
