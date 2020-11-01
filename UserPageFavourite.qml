import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

//Item {
//    id: root

ScrollView {
    id: scroll
//        width: parent.width
//        height: parent.height
    clip: true
    ScrollBar.vertical.interactive: false
    ScrollBar.horizontal.visible: false

    ListView {
        model: 5
        delegate: MusicDelegate {
            _index: model.index
            width: scroll.width
            height: 40
            bgColor: !(index % 2) ? _toolBarBackGroundColor : _backGroundColor
        }
    }
}
//}
