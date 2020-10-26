import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

Window {
    id: root
    minimumWidth: 480
    minimumHeight: 680
    width: 800
    visible: true
    title: qsTr("Hello World")
    color: settings.backGroundColor

    property StackView mainStack: stackView
    property bool isToolBarVisible: false

    CustomToolBar { id: mainToolBar }

    StackView {
        id: stackView
        initialItem: "AuthorizationPage.qml"
        x: mainToolBar.width
        width: parent.width - mainToolBar.width
        height: parent.height - musicController.height
        clip: true
    }

    MusicController { id: musicController }
    AppSettings { id: settings; windowWidth: root.width; windowHeight: root.height }
}
