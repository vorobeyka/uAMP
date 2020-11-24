#include "musiclibrary.h"

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

QString MusicLibrary::getLyrics(QString filePath) {
    QString lyrics = "";
    MPEG::File f(filePath.toLocal8Bit().toStdString().c_str());

    if (!f.isValid()) {
        qDebug() << "blyat";
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
