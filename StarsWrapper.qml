import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 100
    height: 40

    Connections {
        target: library

        function onSetRating(id) {
            if (cppIndex === id) {
                setStars(rate)
            }
        }
    }

    property int _count: 0
    property int cppIndex: 0

    Row {
        width: 100
        height: 20
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            id: repeater
            model: 5
            MouseArea {
                width: 20
                height: 20

                property string imgSource: "/images/star"

                Image {
                    id: starIcon
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    source: imgSource
                    visible: false
                }

                ColorOverlay {
                    id: starColoredIcon
                    anchors.fill: starIcon
                    source: starIcon
                    color: _textColor
                    opacity: 0.8
                }
                onClicked: {
                    library.rate(cppIndex, index)
                    setStars(index)
                }
            }
        }
    }

    function setStars(to) {
        for (let i = 0; i <= to; ++i)
            repeater.itemAt(i).imgSource = "/images/stared"
        if (!to) to = -1
        for (let i = to + 1; i < repeater.count; ++i)
            repeater.itemAt(i).imgSource = "/images/star"
    }

    Component.onCompleted: {
        setStars(_count)
    }
}
