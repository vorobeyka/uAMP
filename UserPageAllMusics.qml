import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root

    ScrollView {
        id: scroll
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.interactive: false
        ScrollBar.horizontal.visible: false

        ListView {
            model: 20
            delegate: MusicDelegate { bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor }
        }
    }
}
