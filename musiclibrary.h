#ifndef MUSICLIBRARY_H
#define MUSICLIBRARY_H

#include "database.h"
#include <QObject>

#if defined(Q_OS_WIN)
    #define OS 1
#elif defined(Q_OS_MAC)
    #define OS 2
#elif defined(Q_OS_LINUX)
    #define OS 3
#endif

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

    void pushFile(QVariantList);

};

#endif // MUSICLIBRARY_H
