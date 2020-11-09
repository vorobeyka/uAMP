#ifndef MUSICLIBRARY_H
#define MUSICLIBRARY_H

#define TAGLIB_STATIC

#include <QFileInfo>
#include <QFileInfoList>
#include <QObject>
#include <tag.h>
#include <fileref.h>

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
    MusicLibrary(DataBase* db, QObject* parent = nullptr);
    ~MusicLibrary();

public slots:
    void readFile(QString);
    void readFolder(QString);
    void setUser(QString);

private:
    DataBase* m_db;
    QString m_user;

    QString currentPath(QString);

    void setFileInfo(QString);
    void pushFile(QVariantList);

};

#endif // MUSICLIBRARY_H
