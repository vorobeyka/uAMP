#ifndef MUSICLIBRARY_H
#define MUSICLIBRARY_H

#define TAGLIB_STATIC

#include <QFileInfo>
#include <QFileInfoList>
#include <QObject>
#include <tag.h>
#include <fileref.h>
#include <bass.h>

#include "database.h"

#if defined(Q_OS_WIN)
    #define OS 1
#elif defined(Q_OS_MAC)
    #define OS 2
#elif defined(Q_OS_LINUX)
    #define OS 3
#endif

using namespace TagLib;

class MusicLibrary : public QObject {
    Q_OBJECT
public:
    Q_PROPERTY(bool isBusy READ isBusy WRITE setIsBusy NOTIFY isBusyChanged)

    MusicLibrary(DataBase* db, QObject* parent = nullptr);
    ~MusicLibrary();

    bool isBusy() const;
    void setIsBusy(bool value);

public slots:
    void readFile(QString, bool);
    void readFolder(QString);
    void setUser(QString);
    void setFavourite(QVariant);
    void unsetFavourite(QVariant);
    void rate(QVariant, QVariant);

signals:
    void setTrackProperties(QVariantList pack);
    void isBusyChanged(bool value);
    void setFavouriteTrack(QVariantList pack);
    void unsetFavouriteTrack(int id);
    void likeTrack(int id);
    void setRating(int id, int rate);

private:
    DataBase* m_db;
    QString m_user;
    QString m_libraryName = "";

    QString currentPath(QString);

    QString getDuration(int time);
    bool m_isBusy = false;

    void pushFile(QVariantList);
    void loadData();
    void loadLibrary();
    void loadFavourite();
    void loadPlaylists();
    void loadQueue();
    void loadEqualizer();
    void loadRadio();
    void clearData();

};

#endif // MUSICLIBRARY_H
