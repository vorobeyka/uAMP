import QtQuick 2.14

Item {
    visible: false

    property int windowWidth: 0
    property int windowHeight: 0
    property string userName: Settings.userName
    property string userPassword: ""
    property string initialItem: ""
    property bool isAuthorized: Settings.authorized

    property string backGroundColor: Settings.backGroundColor//""//"#303030"
    property string toolBarBackGroundColor: Settings.toolBarColor//""//"#404040"
    property string themeColor: Settings.themeColor//""//"#12CBC4"
    property string textColor: Settings.textColor//""//"white"
    property string hoverColor: Settings.hoverColor//""//"#BEC3C6"
    property int toolButtonHeight: 50
    property double opacityMusicCotnroll: 0.8
    property double opacityGradient: 0.5
//    property string backGroundColor: "#ecf0f1"
//    property string toolBarBackGroundColor: "#bdc3c7"
//    property string themeColor: "#e74c3c"
//    property string textColor: "#404040"
//    property string hoverColor: "#bdc3c7"
//    property int toolButtonHeight: 50
//    property double opacityMusicCotnroll: 1
//    property double opacityGradient: 0.8
}
