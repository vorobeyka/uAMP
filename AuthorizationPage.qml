import QtQuick 2.4


Item {
    id: root

    property bool authVisible: true
    property bool userPageVisible: false

    Item {
        visible: authVisible
        anchors.fill: parent
        Item {
            id: header
            width: authText.width
            anchors.horizontalCenter: parent.horizontalCenter
            y: 20

            CustomText { id: authText; text: "Authorization"; textSize: 2}
        }

        Column {
            id: logInButtons
            width: 200
            height: 100
            anchors.centerIn: parent
            spacing: 10
            CustomButton {
                buttonText: "Sign in"
                onClicked: {
                    authVisible = false
                    signInPage.visible = true
                }
            }
            CustomButton {
                buttonText: "Create account"
                onClicked: {
                    authVisible = false
                    accountPage.visible = true
                }
            }
        }
    }

    SignInPage {
        id: signInPage
        anchors.fill: parent
        visible: false
        btnText: "Sign In"
        headerText: btnText
    }

    SignInPage {
        id: accountPage
        anchors.fill: parent
        visible: false
        btnText: "Create"
        headerText: "Create account"
    }

    UserPage {
        id: userPage
        anchors.fill: parent
        visible: userPageVisible
    }

    AppSettings { id: settings }
}
