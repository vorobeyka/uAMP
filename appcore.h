#ifndef APPCORE_H
#define APPCORE_H

#include "database.h"

//#define TRACKS_TABL/E "Music"
//#define FILE_NAME "FileName"
//#define FILE_PATH "FilePath"
//#define TITLE "Title"
//#define ARTIST "Artist"
//#define ALBUM "Album"
//#define YEAR "Year"

class AppCore : public QObject {
    Q_OBJECT
public:
    Q_PROPERTY(bool isBusy READ isBusy WRITE setIsBusy NOTIFY isBusyChanged)
    AppCore(QObject* parent = nullptr);
    ~AppCore();

    bool isBusy() const;

public slots:
    void setUserName(QString user);
    void setIsBusy(bool value);

signals:
    void isBusyChanged(bool value);


private:
    bool m_isBusy = false;
    QString m_user;
    DataBase* m_db;

    QVariantList dataToPush;
//    struct insertionData {
//        QStringList
//    };

    void initCore();
    bool createTable();
    bool readTable();
};

#endif // APPCORE_H
