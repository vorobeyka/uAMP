import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.14

Window {
    property int _windowWidth: root.width
    property int _windowHeight: root.height
    property string _userName: Settings.userName
    property string _userPassword: ""
    property string _initialItem: ""
    property bool _isAuthorized: Settings.authorized
    property string _backGroundColor: Settings.backGroundColor//""//"#303030"
    property string _toolBarBackGroundColor: Settings.toolBarColor//""//"#404040"
    property string _themeColor: Settings.themeColor//""//"#12CBC4"
    property string _textColor: Settings.textColor//""//"white"
    property string _hoverColor: Settings.hoverColor//""//"#BEC3C6"
    property int _toolButtonHeight: 50
    property double _opacityMusicCotnroll: 0.8
    property double _opacityGradient: 0.5
    property StackView mainStack: stackView
    property Drawer _tagEditor: tagEditor

    id: root
    minimumWidth: 450
    minimumHeight: 570
    width: 800
    height: 680
    visible: true
    title: qsTr("Hello World")
    color: _backGroundColor



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

    Drawer {
        id: tagEditor
        width: root.width
        height: root.height - musicController.height
        background: Rectangle {
            anchors.fill: parent
            color: _backGroundColor
        }

        ListModel {
            id: modelId
            ListElement {
                name: "sss"
            }
        }

        GridView {
            id: grid
            width: parent.width -30
            height: parent.height
            cellWidth: 300
            cellHeight: 40

            model: Rectangle {}
            delegate: Rectangle {
                width: parent.cellWidth * 0.9
                height: parent.cellHeight * 0.9
                color: _themeColor
                border.color: _themeColor
//                CustomText { text: mNumber }
            }
        }
        Component.onCompleted: {
            for (let i = 0; i < 10; ++i)
                grid.model.append(Rectangle)
        }

        Button {
            width: 30
            height: parent.height
            anchors.right: parent.right
            background: Rectangle {
                anchors.fill: parent
                color: _themeColor
            }
            CustomText { text: "\u25C0"; textSize: 2; anchors.centerIn: parent }
            onClicked: tagEditor.close()
        }
    }
}
