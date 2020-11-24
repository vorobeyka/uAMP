#include "musiclibrary.h"

MusicLibrary::MusicLibrary(DataBase* db, QObject* parent) :
    QObject(parent), m_db(db) {}

MusicLibrary::~MusicLibrary() {}

void MusicLibrary::setUser(QString value) {
    m_user = value;
    qDebug() << "set " + value + " user in library class";
    m_libraryName = m_user + "Library";
    m_queueName = m_user + "Queue";
    if (value.isEmpty()) clearData();
    else loadData();
}

void MusicLibrary::pushFile(QVariantList data) {
    data.push_front(m_db->getRowsCount(m_libraryName) + 1);
    m_db->insertIntoTable(m_libraryName, data);
}

void MusicLibrary::loadLibrary() {
    QVariantList ids = m_db->readSortedValues(m_libraryName, "id", "id");
    for (auto i : ids) {
        QVariantList data = getPackById(i);
        emit setTrackProperties(data);
        if (data[7].toBool()) emit setFavouriteTrack(data);
    }
}

void MusicLibrary::loadSortedQueue() {
    QCoreApplication::processEvents();
    QVariantList sortedIds = m_reverseSort ? m_db->readReverseSortedValues(m_queueName, "lib_id", getSortedString(m_librarySort.toInt()))
              : m_db->readSortedValues(m_queueName, "lib_id", getSortedString(m_librarySort.toInt()));
    QVariantList ids = m_reverseSort ? m_db->readReverseSortedValues(m_queueName, "id", getSortedString(m_librarySort.toInt()))
              : m_db->readSortedValues(m_queueName, "id", getSortedString(m_librarySort.toInt()));
//    for (auto i : sortedIds) {
//        QVariantList data = getPackById(i);
//        emit setInQueue(data);
//    }
    for (int i = 0; i < sortedIds.count(); ++i) {
        QVariantList data = getPackById(sortedIds[i]);
        data << ids[i];
        emit setInQueue(data);
    }
}

void MusicLibrary::loadFavourite() {

}

void MusicLibrary::loadPlaylists() {

}

void MusicLibrary::loadQueue() {
    QCoreApplication::processEvents();
    QVariantList sortedIds = m_db->readSortedValues(m_queueName, "lib_id", "id");
    QVariantList ids = m_db->readSortedValues(m_queueName, "id", "id");
//    for (auto i : ids) {
//        QVariantList data = getPackById(i);
//        emit setInQueue(data);
//    }
    for (int i = 0; i < sortedIds.count(); ++i) {
        QVariantList data = getPackById(sortedIds[i]);
        data << ids[i];
        emit setInQueue(data);
    }
}

void MusicLibrary::loadEqualizer() {

}
void MusicLibrary::loadRadio() {

}

QString MusicLibrary::getSortedString(int value) {
    switch (value) {
    case E_TITLE:       return "Title";
    case E_ARTIST:      return "Artist";
    case E_ALBUM:       return "Album";
    case E_RATING:      return "Rating";
    case E_MOST_PLAYED: return "PlayedTimes";
    case E_NEWEST:      return "Date";
    case E_YEAR:        return "Year";
    default:            return "id";
    }
}

void MusicLibrary::loadData() {
    setIsBusy(true);

    QCoreApplication::processEvents();

    loadLibrary();
    loadFavourite();
    loadPlaylists();
    loadQueue();
    loadEqualizer();
    loadRadio();

    setIsBusy(false);
}

void MusicLibrary::clearData() {
    m_librarySort = 0;
    m_reverseSort = false;
    qDebug() << "cleared Data";
}

void MusicLibrary::readFile(QString filePath, bool pathFlag) {
//    setIsBusy(true);
    QCoreApplication::processEvents();
    QString _filePath = pathFlag ? currentPath(filePath) : filePath;
    if (!m_db->readValue(m_libraryName, _filePath, "FilePath", "FilePath").isNull()) {
        emit errorHandle("Error: this track alredy exists\n" + _filePath);
        setIsBusy(false);
        return;
    }
    if (!checkSfx(_filePath.split(".").last())) {
        qDebug() << "che blyat";
        emit errorHandle("Error: can't open file\nChoose .mp4 .mp3 .mp2 .mp1 .wav .ogg .aiff .aac");
        setIsBusy(false);
        return;
    }
    FileRef file(_filePath.toLocal8Bit().toStdString().c_str());
    if (file.isNull()) {
        errorHandle("Error: can't read tags from file\n" + _filePath);
        setIsBusy(false);
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
    emit setSortedLibraryTracks(QVariantList() << m_db->getRowsCount(m_libraryName) + 1 << (!data[2].toString().isEmpty() ? data[2].toString() : data[0].toString())
                                               << data[3] << data[4] << data[5].toString() << data[6] << data[7] << data[8].toBool() << data[9]);
    pushFile(data);
//    setIsBusy(false);
}

void MusicLibrary::readFolder(QString folderPath) {
    QDir dir(currentPath(folderPath));
    dir.setNameFilters(QStringList() << "*.mp4" << "*.mp3" << "*.mp2"
                       << "*.mp1" << "*.wav" << "*.ogg" << "*.aiff" << "*.aac");
    for (auto i : dir.entryList()) {
        readFile(dir.absolutePath() + "/" + i, 0);
    }
}

QVariant MusicLibrary::librarySort() const { return m_librarySort; }

void MusicLibrary::setLibrarySort(QVariant value) {
    setIsBusy(true);
    QThread::msleep(50);
    QCoreApplication::processEvents();
    if (value.toInt() == m_librarySort.toInt()) m_reverseSort = !m_reverseSort;
    else m_reverseSort = false;

    QCoreApplication::processEvents();
    m_librarySort = value;
    emit clearQueue();
    emit librarySortChanged(m_librarySort);

    loadSortedQueue();
    setIsBusy(false);
}

void MusicLibrary::addToQueue(QVariant id) {
    QCoreApplication::processEvents();
    QVariantList data = getPackById(id);
    emit setInQueue(QVariantList() << data << m_db->getRowsCount(m_queueName) + 1);
    data.push_front(m_db->getRowsCount(m_queueName) + 1);
    m_db->insertIntoTable(m_queueName, data);
}

void MusicLibrary::loadTagEditor(QVariant id) {
    setIsBusy(true);
    QThread::msleep(50);
    QCoreApplication::processEvents();
    QVariantList pack;
    QString filePath = m_db->readValue(m_libraryName, id, "id", "FilePath").toString();

    pack << id << m_db->readValue(m_libraryName, id, "id", "Title")
         << m_db->readValue(m_libraryName, id, "id", "Artist")
         << m_db->readValue(m_libraryName, id, "id", "Year")
         << m_db->readValue(m_libraryName, id, "id", "Album")
         << m_db->readValue(m_libraryName, id, "id", "Genre")
         << filePath << getLyrics(filePath) << getImage(filePath);

    emit loadTags(pack);
    setIsBusy(false);
}

QVariantList MusicLibrary::getPackById(QVariant id) {
    QVariantList pack;
    QVariant title = m_db->readValue(m_libraryName, id, "id", "Title");
    if (title.toString().isEmpty()) title = m_db->readValue(m_libraryName, id, "id", "FileName");
    pack << id << title << m_db->readValue(m_libraryName, id, "id", "Artist")
         << m_db->readValue(m_libraryName, id, "id", "Album")
         << m_db->readValue(m_libraryName, id, "id", "Year")
         << m_db->readValue(m_libraryName, id, "id", "Genre")
         << m_db->readValue(m_libraryName, id, "id", "Rating")
         << m_db->readValue(m_libraryName, id, "id", "Like").toBool()
         << m_db->readValue(m_libraryName, id, "id", "Duration")
         << m_db->readValue(m_libraryName, id, "id", "PlayedTimes")
         << m_db->readValue(m_libraryName, id, "id", "Date");
    return pack;
}

QVariantList MusicLibrary::getPackQueue(int id) {
    QVariantList pack;
    QVariant title = m_db->readValue(m_queueName, id, "id", "Title");
    if (title.toString().isEmpty()) title = m_db->readValue(m_queueName, id, "id", "FileName");
    pack << id << title << m_db->readValue(m_queueName, id, "id", "Artist")
         << m_db->readValue(m_queueName, id, "id", "Album")
         << m_db->readValue(m_queueName, id, "id", "Year")
         << m_db->readValue(m_queueName, id, "id", "Genre")
         << m_db->readValue(m_queueName, id, "id", "Rating")
         << m_db->readValue(m_queueName, id, "id", "Like").toBool()
         << m_db->readValue(m_queueName, id, "id", "Duration")
         << m_db->readValue(m_queueName, id, "id", "PlayedTimes")
         << m_db->readValue(m_queueName, id, "id", "Date");
    return pack;
}
