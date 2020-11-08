#include "appcore.h"
#include <QThread>
#include <QCoreApplication>
AppCore::AppCore(QObject* parent) :
    QObject(parent) {
    dataToPush << "FileName CHARACTER(255), " << "FilePath  "
              << "Title  " << "Artist "
              << "Album  " << "Year "
              << "Genre  " << 2
              << 1 << 5.6
              << 5 << 4
              << 12345;
}

AppCore::~AppCore() {
}

bool AppCore::isBusy() const {
    return m_isBusy;
}

void AppCore::setIsBusy(bool value) {
    m_isBusy = value;
    emit isBusyChanged(value);
}

void AppCore::setUserName(QString user) {
    m_user = user;
    initCore();
}

bool AppCore::createTable() {
    if (!m_db->createTable("Music", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                           << "FileName CHARACTER(255), " << "FilePath CHARACTER(255), "
                           << "Title CHARACTER(255), " << "Artist CHARACTER(255), "
                           << "Album CHARACTER(255), " << "Year CHARACTER(255), "
                           << "Genre CHARACTER(255), " << "Rating TINYINT, "
                           << "Like TINYINT, " << "Duration REAL, "
                           << "Played TINYINT, " << "PlayedTimes INTEGER, "
                           << "Date INTEGER)")) {
        return false;
    }
    return true;
}

bool AppCore::readTable() {
//    if (m_db->readFromTable())
    return false;
}

void AppCore::initCore() {
    setIsBusy(true);
    QThread::msleep(50);
    QCoreApplication::processEvents();
    m_db = new DataBase(m_user + "DataBase.db");
    m_db->connectToDataBase();
    if (!createTable()) {
        qDebug() << "Table don`t created or existing";
    }
    if (!readTable()) {
        qDebug() << "Can't read table with music";
    }
    setIsBusy(false);
}
