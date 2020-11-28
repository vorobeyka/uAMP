#include "playlists.h"

bool Playlists::setUser(QString user) {
    m_user = user;
    m_playlistsTable = m_user + "Playlists";
    m_queueTable = m_user + "Queue";
    m_libraryTable = m_user + "Library";
    return true;
}

bool Playlists::addToPlaylist(QString plName, int trackId) {
    return true;
}

bool Playlists::removeFromPlaylist(QString plName, int trackId) {
    return true;
}

void Playlists::init() {

}

bool Playlists::createPlaylist(QString plName) {
    m_db->createTable(m_playlistsTable + plName, QStringList() << "(id integer primary key autoincrement,"
                      << "lib_id integer)");
    return true;
}

bool Playlists::removePlaylist(QString plName) {
    return true;
}

bool Playlists::play(QString plName) {
    return true;
}

bool Playlists::addToQueue(QString plName) {
    return true;
}

bool Playlists::exportPlaylist(QString plName) {
    return true;
}

bool Playlists::importPlaylist(QString path) {
    return true;
}
