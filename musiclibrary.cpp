#include "musiclibrary.h"
#include <QFileInfo>

MusicLibrary::MusicLibrary(DataBase* db, QObject* parent) :
    QObject(parent), m_db(db) {

}

MusicLibrary::~MusicLibrary() {}

void MusicLibrary::setUser(QString value) {
    m_user = value;
    qDebug() << "set " + value + " user in library class";
}

QString MusicLibrary::currentPath(QString path) {
    QString _path = "";

    for (int i = OS == 1 ? 8 : 7; i < path.length(); ++i)
            _path.push_back(path[i]);
    return _path;
}

void MusicLibrary::setFileInfo(QString filePath) {
    (void)filePath;
}

void MusicLibrary::pushFile(QVariantList data) {
    data.push_front(m_db->getRowsCount(m_user + "Library") + 1);
    m_db->insertIntoTable(m_user + "Library", data);
}

void MusicLibrary::readFile(QString filePath) {
    QVariantList data;
    qDebug() << filePath;
//    QFileInfo info(currentPath(filePath));

//    data.append(info.fileName());
//    data.append(info.filePath());
//    // set Tags
//    data.append("title");
//    data.append("artist");
//    data.append("album");
//    data.append("year");
//    data.append("genre");
//    /*data.append(tags);
//     *
//     */
//    data.append(3); // SET DURATION
//    data.append(0); // SET LIKE
//    data.append(0); // SET PLAYED 0 1
//    data.append(0); // SET PLAYED TIMES
//    data.append(QDate::currentDate()); //SET CURRENT DATE
}

void MusicLibrary::readFolder(QString folderPath) {
    qDebug() << folderPath;
}
