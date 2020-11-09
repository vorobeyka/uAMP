import QtQuick 2.12
import QtQuick.Dialogs 1.0

FileDialog {
    id: fileDialog
    title: "Please choose a files"
//    folder: shortcuts.home
    selectMultiple: true
    nameFilters: [ "Audio files (*.mp4 *.mp3 *.mp2 *.mp1 *.wav *.ogg *.aiff *.aac)", "Playlists (*.m3u)" ]
    onRejected: {
        Qt.quit()
    }
//    Component.onCompleted: visible = true
}
