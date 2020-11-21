import QtQuick 2.0
import QtQuick.Controls 2.12

TextField {
    id: control
    width: parent.width
    font.pixelSize: Qt.application.font.pixelSize * 1.2
    color: _textColor
    text: txt

    property string txt: ""

    background: Rectangle {
        anchors.fill: parent
        color: _backGroundColor
        border.color: control.activeFocus ? _themeColor : _textColor
    }
}
