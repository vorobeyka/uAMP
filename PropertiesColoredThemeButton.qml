import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root
    anchors.fill: bg
    width: 40
    height: 40
    color: btnColor
    opacity: 0.8

    property string btnColor: ""

    MouseArea {
        id: bg
        anchors.fill: parent

        onClicked: {
            Settings.themeColor = btnColor
        }
    }
}
