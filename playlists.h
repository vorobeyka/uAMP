#ifndef PLAYLISTS_H
#define PLAYLISTS_H

//#include <QObject>

#include "database.h"

class Playlists : public QObject {
    Q_OBJECT
public:
    Playlists(DataBase* db, QObject* parent = nullptr) : QObject(parent) { m_db = db; }
    ~Playlists() {}

public slots:
    bool setUser(QString user);
    bool addToPlaylist(QString plName, int trackId);
    bool removeFromPlaylist(QString plName, int trackId);
    bool createPlaylist(QString plName);
    bool removePlaylist(QString plName);
    bool play(QString plName);
    bool addToQueue(QString plName);
    bool exportPlaylist(QString plName);
    bool importPlaylist(QString path);

signals:
    void createGUIPlaylist(QString);
    void setTrackInPlaylist(QVariantList);
    void clearTracks();
    void clearPlaylists();

private:
    DataBase* m_db;

    QString m_user;
    QString m_playlistsTable;
    QString m_queueTable;
    QString m_libraryTable;

    void init();

};


#endif // PLAYLISTS_H
