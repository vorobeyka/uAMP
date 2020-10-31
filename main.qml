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
    property StackView mainStack: stackView
    property bool _isAuthorized: Settings.authorized
    property string _backGroundColor: Settings.backGroundColor//""//"#303030"
    property string _toolBarBackGroundColor: Settings.toolBarColor//""//"#404040"
    property string _themeColor: Settings.themeColor//""//"#12CBC4"
    property string _textColor: Settings.textColor//""//"white"
    property string _hoverColor: Settings.hoverColor//""//"#BEC3C6"
    property int _toolButtonHeight: 50
    property double _opacityMusicCotnroll: 0.8
    property double _opacityGradient: 0.5

    id: root
    minimumWidth: 480
    minimumHeight: 610
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
}
