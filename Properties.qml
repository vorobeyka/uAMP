import QtQuick 2.0

Item {
    id: root

    Item {
        id: header
        width: parent.width
        height: 50

        CustomText {
            text: qsTr("Settings")
            anchors.horizontalCenter: parent.horizontalCenter
            textSize: 2
        }
    }

    Column {
        id: content
        width: parent.width
        height: parent.height - 100
//        anchors.top: header.bottom
        y: header.height + 50
//        anchors.centerIn: parent
        Item {
            width: parent.width
            height: root.height / 4
            Item {
                id: bgText
                width: parent.width
                height: 20
                CustomText {
                    text: "BackGroundColor"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Column {
                width: parent.width
                anchors.centerIn: parent
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    PropertiesColoredBGButton { btnColor: "#ecf0f1"}
                    PropertiesColoredBGButton { btnColor: "#ecf0f1"}
                    PropertiesColoredBGButton { btnColor: "#ecf0f1"}
                    PropertiesColoredBGButton { btnColor: "#ecf0f1"}
                    PropertiesColoredBGButton { btnColor: "#ecf0f1"}
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    PropertiesColoredBGButton { btnColor: "#1e272e"; toolBarColor: "#485460"}
                    PropertiesColoredBGButton { btnColor: "#202020"; }
                    PropertiesColoredBGButton { btnColor: "#303030"}
                    PropertiesColoredBGButton { btnColor: "#404040"}
                    PropertiesColoredBGButton { btnColor: "#505050"}
                }
            }
        }
        Item {
            width: parent.width
            height: root.height / 4
            Item {
                id: themeText
                width: parent.width
                height: 20
                CustomText {
                    text: "ThemeColor"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Column {
                width: parent.width
                anchors.centerIn: parent
                Row {
                    anchors. horizontalCenter: parent.horizontalCenter
                    PropertiesColoredThemeButton { btnColor: "#00a8ff" }
                    PropertiesColoredThemeButton { btnColor: "#9c88ff" }
                    PropertiesColoredThemeButton { btnColor: "#fbc531" }
                    PropertiesColoredThemeButton { btnColor: "#4cd137" }
                    PropertiesColoredThemeButton { btnColor: "#487eb0" }
                    PropertiesColoredThemeButton { btnColor: "#e84118" }
                    PropertiesColoredThemeButton { btnColor: "#B53471" }
                }
                Row {
                    anchors. horizontalCenter: parent.horizontalCenter
                    PropertiesColoredThemeButton { btnColor: "#1abc9c" }
                    PropertiesColoredThemeButton { btnColor: "#2ecc71" }
                    PropertiesColoredThemeButton { btnColor: "#3498db" }
                    PropertiesColoredThemeButton { btnColor: "#9b59b6" }
                    PropertiesColoredThemeButton { btnColor: "#f1c40f" }
                    PropertiesColoredThemeButton { btnColor: "#e67e22" }
                    PropertiesColoredThemeButton { btnColor: "#e74c3c" }
                }
            }
        }
        Item {
            width: parent.width
            height: root.height / 4
            Item {
                width: parent.width
                height: 20
                CustomText {
                    text: "Timer"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Item {
        id: footer
        width: parent.width
        height: 50
    }

    AppSettings { id: settings }
}
