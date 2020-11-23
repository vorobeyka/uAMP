#ifndef MUSICLIBRARY_H
#define MUSICLIBRARY_H

#define TAGLIB_STATIC

#include <QFileInfo>
#include <QFileInfoList>
#include <QObject>
#include <tag.h>
#include <fileref.h>
#include <bass.h>
#include <QImage>
#include <QFileInfo>
#include <QTime>
#include <QCoreApplication>
#include <QDir>
#include <QBuffer>
#include <id3v2frame.h>
#include <frames/attachedpictureframe.h>
#include <id3v2tag.h>
#include <unsynchronizedlyricsframe.h>
#include <mpegfile.h>
#include <attachedpictureframe.h>
#include <QThread>

#include "imagefile.h"
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
    Q_PROPERTY(bool isImage READ isImage WRITE setIsImage NOTIFY isImageChanged)
    Q_PROPERTY(QVariant libSortedValue READ librarySort WRITE setLibrarySort NOTIFY librarySortChanged)

    MusicLibrary(DataBase* db, QObject* parent = nullptr);
    ~MusicLibrary();

    bool isBusy() const;
    void setIsBusy(bool value);
    bool isImage() const;
    void setIsImage(bool value);
    QVariant librarySort() const;
    void setLibrarySort(QVariant value);

public slots:
    void readFile(QString, bool);
    void readFolder(QString);
    void setUser(QString);
    void setFavourite(QVariant);
    void unsetFavourite(QVariant);
    void rate(QVariant, QVariant);
    void addToQueue(QVariant);
    void loadTagEditor(QVariant);
    void saveImage(QString);
    void setImage(QString);
    void saveTags(QVariantList);
    void deleteFromQueue(int id);
    void deleteFromLibrary(QVariant id);
    void deleteAllFromQueue();
    void deleteAllFromLibrary();

signals:
    void setTrackProperties(QVariantList pack);
    void setSortedLibraryTracks(QVariantList pack);
    void isBusyChanged(bool value);
    void isImageChanged(bool value);
    void setFavouriteTrack(QVariantList pack);
    void unsetFavouriteTrack(int id);
    void likeTrack(int id);
    void setRating(int id, int rate);
    void setInQueue(QVariantList pack);
    void loadTags(QVariantList pack);
    void setNewImage(QImage img);
    void errorHandle(QString);
    void updateTrack(QVariantList);
    void librarySortChanged(QVariant);

    void deleteTrackFromLibrary(int);
    void deleteTrackFromQueue(int);

    // clear lists
    void clearSortedLibrary();
    void clearQueue();
    void clearLibrary();
    void clearFavourite();
    void clearRadio();
    void clearEqualizer();
    // end clear lists

private:
    DataBase* m_db;
    QString m_user;
    QString m_libraryName = "";
    QString m_queueName = "";
    QImage m_imgTrack;
    QImage m_newImgTrack;
    ByteVector m_imgData;
    QVariant m_librarySort;
    bool m_reverseSort = false;
    bool m_isImage = false;
    bool m_isBusy { false };

    enum SortTypes {
        E_UNSORTED,
        E_TITLE,
        E_ARTIST,
        E_ALBUM,
        E_RATING,
        E_MOST_PLAYED,
        E_NEWEST,
        E_YEAR
    };

    QVariantList getPackById(QVariant);
    QVariantList getPackQueue(int);
    QString currentPath(QString);
    QString getDuration(int time);
    QString getLyrics(QString);
    QString getSortedString(int);
    QImage getImage(QString);
    bool checkSuffix(QString, QString);
    bool checkSfx(QString);

    void pushFile(QVariantList);
    void loadData();
    void loadLibrary();
    void loadSortedQueue();
    void loadFavourite();
    void loadPlaylists();
    void loadQueue();
    void loadEqualizer();
    void loadRadio();
    void clearData();

};

#endif // MUSICLIBRARY_H
