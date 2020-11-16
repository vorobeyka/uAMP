#include "musiclibrary.h"
#include <QFileInfo>
#include <QTime>
#include <QCoreApplication>
#include <QDir>

MusicLibrary::MusicLibrary(DataBase* db, QObject* parent) :
    QObject(parent), m_db(db) {}

MusicLibrary::~MusicLibrary() {}

void MusicLibrary::setUser(QString value) {
    m_user = value;
    qDebug() << "set " + value + " user in library class";
    m_libraryName = m_user + "Library";
    if (value.isEmpty()) clearData();
    else loadData();
}

QString MusicLibrary::currentPath(QString path) {
    QString _path = "";

    for (int i = OS == 1 ? 8 : 7; i < path.length(); ++i)
            _path.push_back(path[i]);
    return _path;
}

void MusicLibrary::pushFile(QVariantList data) {
    data.push_front(m_db->getRowsCount(m_libraryName) + 1);
    m_db->insertIntoTable(m_libraryName, data);
}

void MusicLibrary::loadLibrary() {

}
void MusicLibrary::loadFavourite() {

}
void MusicLibrary::loadPlaylists() {

}
void MusicLibrary::loadQueue() {

}
void MusicLibrary::loadEqualizer() {

}
void MusicLibrary::loadRadio() {

}

void MusicLibrary::loadData() {
    setIsBusy(true);
    QCoreApplication::processEvents();
    QVariant title;

    loadLibrary();
    loadFavourite();
    loadPlaylists();
    loadQueue();
    loadEqualizer();
    loadRadio();
    for (int i = 1; i <= m_db->getRowsCount(m_libraryName); ++i) {
        QVariantList data;
        title = m_db->readValue(m_libraryName, i, "id", "Title").toString();
        if (title.toString().isEmpty()) title = m_db->readValue(m_libraryName, i, "id", "FileName");
        data << i << title << m_db->readValue(m_libraryName, i, "id", "Artist")
             << m_db->readValue(m_libraryName, i, "id", "Album")
             << m_db->readValue(m_libraryName, i, "id", "Year")
             << m_db->readValue(m_libraryName, i, "id", "Genre")
             << m_db->readValue(m_libraryName, i, "id", "Rating")
             << m_db->readValue(m_libraryName, i, "id", "Like").toBool()
             << m_db->readValue(m_libraryName, i, "id", "Duration");
        emit setTrackProperties(data);
        if (data[7].toBool()) emit setFavouriteTrack(data);
    }
    setIsBusy(false);
}

void MusicLibrary::clearData() {
    qDebug() << "cleared Data";
}

void MusicLibrary::readFile(QString filePath, bool pathFlag) {
    QCoreApplication::processEvents();
    QString _filePath = pathFlag ? currentPath(filePath) : filePath;
    FileRef file(_filePath.toLocal8Bit().toStdString().c_str());
    if (file.isNull()) {
        return;
    }
    QVariantList data;
    QFileInfo info(_filePath);

    data.append(info.fileName()); // 0
    data.append(info.filePath()); // 1
//  set Tags
    data.append(file.tag()->title().toCString(1));  // 2
    data.append(file.tag()->artist().toCString(1)); // 3
    data.append(file.tag()->album().toCString(1));  // 4
    if (file.tag()->year() == 0) data.append("");   // 5
    else data.append(file.tag()->year());           // 5
    data.append(file.tag()->genre().toCString(1));  // 6

    data.append(0); // SET RATING 7
    data.append(0); // SET LIKE 8
    data.append(getDuration(file.audioProperties()->length())); // SET DURATION 9
    data.append(0); // SET PLAYED 0 1  10
    data.append(0); // SET PLAYED TIMES  11
    data.append(QDate::currentDate().toString()); //SET CURRENT DATE  12
    emit setTrackProperties(QVariantList() << m_db->getRowsCount(m_libraryName) + 1 << (!data[2].toString().isEmpty() ? data[2].toString() : data[0].toString())
                                           << data[3] << data[4] << data[5].toString() << data[6] << data[7] << data[8].toBool() << data[9]);
    pushFile(data);
}

QString MusicLibrary::getDuration(int time) {
    double _time = time / 60 + (time % 60) * 0.01;
    QString rez = QString::fromStdString(std::to_string(_time));
    int i = rez.length() - 1;
    for ( ; i > 0; --i) {
        if (rez[i] == '0') continue;
        if (rez[i] == '.') {
            i--;
            break;
        }
        break;
    }
    QString tmp;
    for (int j = 0; j < i + 1; ++j)
        tmp.push_back(rez[j]);
    return tmp;
}

void MusicLibrary::readFolder(QString folderPath) {
    QDir dir(currentPath(folderPath));
    dir.setNameFilters(QStringList() << "*.mp4" << "*.mp3" << "*.mp2"
                       << "*.mp1" << "*.wav" << "*.ogg" << "*.aiff" << "*.aac");
    for (auto i : dir.entryList()) {
        readFile(dir.absolutePath() + "/" + i, 0);
    }
}

bool MusicLibrary::isBusy() const { return m_isBusy; }

void MusicLibrary::setIsBusy(bool value) {
    m_isBusy = value;
    emit isBusyChanged(value);
}

void MusicLibrary::setFavourite(QVariant id) {
    m_db->updateValue(m_libraryName, "Like", "id=" + id.toString(), 1);
    QVariantList pack;
    QVariant title = m_db->readValue(m_libraryName, id, "id", "Title");
    if (title.toString().isEmpty()) title = m_db->readValue(m_libraryName, id, "id", "FileName");
    pack << id << title << m_db->readValue(m_libraryName, id, "id", "Artist")
         << m_db->readValue(m_libraryName, id, "id", "Album")
         << m_db->readValue(m_libraryName, id, "id", "Year")
         << m_db->readValue(m_libraryName, id, "id", "Genre")
         << m_db->readValue(m_libraryName, id, "id", "Rating")
         << m_db->readValue(m_libraryName, id, "id", "Like").toBool()
         << m_db->readValue(m_libraryName, id, "id", "Duration");
    emit setFavouriteTrack(pack);
    emit likeTrack(id.toInt());
}

void MusicLibrary::unsetFavourite(QVariant cppId) {
    m_db->updateValue(m_libraryName, "Like", "id=" + cppId.toString(), 0);
    emit unsetFavouriteTrack(cppId.toInt());
}

void MusicLibrary::rate(QVariant cppId, QVariant rating) {
    m_db->updateValue(m_libraryName, "Rating", "id=" + cppId.toString(), rating.toInt());
    emit setRating(cppId.toInt(), rating.toInt());
}
