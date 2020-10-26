import QtQuick 2.0

Text {
    property double textSize: 1.2

    anchors.verticalCenter: parent.verticalCenter
    font.pixelSize: Qt.application.font.pixelSize * textSize
    color: settings.textColor
}
