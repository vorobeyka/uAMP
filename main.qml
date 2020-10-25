import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

Window {
    id: root
    minimumWidth: 800
    minimumHeight: 640
    visible: true
    title: qsTr("Hello World")
    color: settings.backGroundColor

    CustomToolBar { id: mainToolBar; visible: settings.isAuthorized }

    StackView {
        id: stackView
        initialItem: "AuthorizationPage.qml"
        x: mainToolBar.width
        width: parent.width - mainToolBar.width
        height: parent.height - musicController.height
    }

    Rectangle {
        id: musicController
        anchors.bottom: parent.bottom
        width: parent.width
        height: 70
        color: settings.themeColor
//        LinearGradient {
//            width: parent.width
//            height: parent.height
//            start: Qt.point(0, 0)
//            end: Qt.point(width, 0)
//            gradient: Gradient {
//                GradientStop { position: 0.0; color: settings.backGroundColor }
//                GradientStop { position: 0.5; color: settings.themeColor }
//                GradientStop { position: 1.0; color: settings.backGroundColor }
//            }
//        }

        opacity: 0.5
    }
    AppSettings { id: settings }
}
