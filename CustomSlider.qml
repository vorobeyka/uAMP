import QtQuick 2.0
import QtQuick.Controls 2.12

Slider {
    id: control
    from: 0
    to: 100
    value: 100
    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 2
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: settings.backGroundColor

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: settings.textColor
            radius: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        width: 16
        height: 16
        radius: 8
        color: control.pressed ? settings.backGroundColor : settings.textColor
    }
}
