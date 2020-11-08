import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: root

    property string btnText: ""
    property string headerText: ""

    Item {
        id: header
        width: authText.width
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20

        CustomText { id: authText; text: headerText; textSize: 2}
    }

    Column {
        id: logInButtons
        width: 200
        anchors.centerIn: parent
        spacing: 10

        Label {
            height: 50
            width: parent.width
            CustomText {
                text: qsTr("login")
            }
        }

        CustomTextField { id: login}

        Label {
            height: 50
            width: parent.width
            CustomText {
                text: qsTr("password")
            }
        }

        CustomTextField { id: password; echoMode: TextField.Password }

        Row {
            CustomButton {
                width: 100
                buttonText: btnText
                onClicked: {
                    if (getLoginLenght() && getPasswordLenght()) {
                        if (checkUser()) {
                            Settings.authorized = true
                            Settings.userName = login.text
                            root.visible = false
                            errorWrapper.visible = false
                            password.clear()
                            login.clear()
                            library.setUserName(_userName)
                        } else {
                            errorWrapper.visible = true
                        }
                    } else {
                        if (!getLoginLenght()) errorText.text = "Error: \nLogin must be longer then 2 characters\nand not longer then 20 characters."
                        else errorText.text = "Error:\nPassword must be longer then 5 characters\nand not longer then 20 characters."
                        errorWrapper.visible = true
                    }
                }
            }
            CustomButton {
                id: btnBack
                width: 100
                buttonText: "Back"
                onClicked: { root.visible = false; authVisible = true; login.text = ""; password.text = "" }
            }
        }
    }

    Item {
        id: errorWrapper
        width: 200
        height: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logInButtons.bottom
        visible: false

        CustomText { id: errorText }
    }

    function getPasswordLenght() { return password.text.length > 5 && password.text.length < 21; }
    function getLoginLenght() { return login.text.length > 2 && login.text.length < 21; }
    function checkUser() {
        if (btnText === "Create") {
            if (Settings.createUser(login.text, password.text)) return true
            errorText.text = "This user exists";
            return false
        } else if (Settings.checkUser(login.text, password.text)) return true
        errorText.text = "Error:\nIncorrect login or password"
        return false
    }
}
