#include "musiclibrary.h"

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
        QVariantList data = getPackById(i);
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

bool MusicLibrary::isImage() const { return m_isImage; }

void MusicLibrary::setIsImage(bool value) {
    m_isImage = value;
    emit isImageChanged(value);
}

void MusicLibrary::setFavourite(QVariant id) {
    m_db->updateValue(m_libraryName, "Like", "id=" + id.toString(), 1);
    emit setFavouriteTrack(getPackById(id));
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

void MusicLibrary::addToQueue(QVariant id) {
    emit setInQueue(getPackById(id));
}

void MusicLibrary::loadTagEditor(QVariant id) {
    setIsBusy(true);
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

QString MusicLibrary::getLyrics(QString filePath) {
    QString lyrics = "";
    MPEG::File f(filePath.toLocal8Bit().toStdString().c_str());

    if (!f.isValid()) {
        qDebug() << "blyat";
        setIsBusy(false);
        return "";
    }

    ID3v2::FrameList frames = f.ID3v2Tag()->frameListMap()["USLT"];
    ID3v2::UnsynchronizedLyricsFrame *frame = NULL;

    if (!frames.isEmpty()) {
        frame = dynamic_cast<ID3v2::UnsynchronizedLyricsFrame *>(frames.front());
        if (frame) lyrics = frame->text().toCString(1);
        else lyrics = "";
    }
    return lyrics;
}

QImage MusicLibrary::getImage(QString filePath) {
    QImage img;
    MPEG::File f(filePath.toLocal8Bit().toStdString().c_str());
    TagLib::ID3v2::FrameList frameList = f.ID3v2Tag()->frameList("APIC");
    if (!frameList.isEmpty()) {
        TagLib::ID3v2::AttachedPictureFrame *coverImg = static_cast<TagLib::ID3v2::AttachedPictureFrame *>(frameList.front());
        QImage coverQImg;
        coverQImg.loadFromData((const uchar *) coverImg->picture().data(), coverImg->picture().size());
        img = coverQImg.scaled(140, 140, Qt::KeepAspectRatio);
        setIsImage(true);
        m_imgTrack = img;
    } else {
        img = QImage(":/images/music-note").scaled(140, 140, Qt::KeepAspectRatio);
        setIsImage(false);
    }
    return img;
}

void MusicLibrary::saveImage(QString url) {
    QString _path;

    for (int i = OS == 1 ? 8 : 7; i < url.length(); ++i)
        _path.push_back(url[i]);

    m_imgTrack.save(_path + "/downloadedImage.png");
}

void MusicLibrary::setImage(QString url) {
    QString _path;

    for (int i = OS == 1 ? 8 : 7; i < url.length(); ++i)
        _path.push_back(url[i]);
    QImage _img = QImage(_path).scaled(140, 140, Qt::KeepAspectRatio);
    if (!_img.isNull()) {
        m_newImgTrack = QImage(_img);
        m_imgData = ImageFile(_path.toLocal8Bit().toStdString().c_str()).data();
        emit setNewImage(m_newImgTrack);
    } else {
        emit errorHandle("Error:\ninvalid image: " + _path);
    }
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
         << m_db->readValue(m_libraryName, id, "id", "Duration");
    return pack;
}

void MusicLibrary::saveTags(QVariantList tags) {
    setIsBusy(true);
    QCoreApplication::processEvents();
    FileRef* file = new FileRef(tags[6].toString().toLocal8Bit().toStdString().c_str());
    if (file->isNull()) {
        qDebug() << "piska";
        return;
    }
    file->tag()->setTitle(tags[1].toString().toStdWString());
    file->tag()->setArtist(tags[2].toString().toStdWString());
    file->tag()->setYear(tags[3].toInt());
    file->tag()->setAlbum(tags[4].toString().toStdWString());
    file->tag()->setGenre(tags[5].toString().toStdWString());
    file->save();

    m_db->updateValue(m_libraryName, "Title", "id=" + tags[0].toString(), tags[1]);
    m_db->updateValue(m_libraryName, "Artist", "id=" + tags[0].toString(), tags[2]);
    m_db->updateValue(m_libraryName, "Year", "id=" + tags[0].toString(), tags[3]);
    m_db->updateValue(m_libraryName, "Album", "id=" + tags[0].toString(), tags[4]);
    m_db->updateValue(m_libraryName, "Genre", "id=" + tags[0].toString(), tags[5]);

    delete file;
    MPEG::File f(tags[6].toString().toLocal8Bit().toStdString().c_str());
    ID3v2::UnsynchronizedLyricsFrame *frame = new ID3v2::UnsynchronizedLyricsFrame();

    if (!f.ID3v2Tag()->frameListMap()["USLT"].isEmpty())
        f.ID3v2Tag()->removeFrames(f.ID3v2Tag()->frameListMap()["USLT"].front()->frameID());
    frame->setText(tags[7].toString().toStdWString());
    f.ID3v2Tag()->addFrame(frame);
    if (checkSuffix(tags[6].toString(), ".mp3") && !m_newImgTrack.isNull()) {
        if (!f.ID3v2Tag()->frameListMap()["APIC"].isEmpty())
            f.ID3v2Tag()->removeFrames(f.ID3v2Tag()->frameListMap()["APIC"].front()->frameID());
        ID3v2::AttachedPictureFrame *imgFrame = new ID3v2::AttachedPictureFrame();
        imgFrame->setMimeType("image/jpeg");
        imgFrame->setPicture(m_imgData);
        f.ID3v2Tag()->addFrame(imgFrame);
        m_newImgTrack = QImage();
    }
    f.save();
    emit updateTrack(QVariantList() << tags[0].toInt() << tags[1] << tags[2]
                                    << tags[3] << tags[4] << tags[5]);
    setIsBusy(false);
}

bool MusicLibrary::checkSuffix(QString str, QString suff) {
    short int sfx = suff.length();
    int len = str.length();

    for (int i = 1; i <= sfx; i++) {
        if (str[len - i] != suff[sfx - i]) {
            return false;
        }
    }
    return true;
}
