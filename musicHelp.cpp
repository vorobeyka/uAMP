#include "musiclibrary.h"

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

bool MusicLibrary::checkSfx(QString str) {
    return str == "mp4" || str == "mp3" || str == "mp2" || str == "mp1"
           || str == ".wav" || str == ".ogg" || str == ".aiff" || str == ".aac";
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

QString MusicLibrary::currentPath(QString path) {
    QString _path = "";

    for (int i = OS == 1 ? 8 : 7; i < path.length(); ++i)
            _path.push_back(path[i]);
    return _path;
}

void MusicLibrary::deleteFromLibrary(QVariant id) {
    setIsBusy(true);
    QThread::msleep(50);
    QCoreApplication::processEvents();
    QVariantList ids = m_db->readColumnWithQueue("SELECT ID FROM " + m_queueName + " WHERE lib_id=" + id.toString() + ";");
    m_db->removeRecord(id.toInt(), m_libraryName);
    m_db->removeRecord("lib_id=" + id.toString(), m_queueName);
    for (auto i : ids) {
        deleteTrackFromQueue(i.toInt());
    }
    emit deleteTrackFromLibrary(id.toInt());
    setIsBusy(false);
}

void MusicLibrary::deleteFromQueue(int id) {
    m_db->removeRecord(id, m_queueName);
    emit deleteTrackFromQueue(id);
}

void MusicLibrary::deleteAllFromLibrary() {
    QThread::msleep(50);
    QCoreApplication::processEvents();

    emit clearLibrary();
    emit clearFavourite();

    for (int i = 1; i <= m_db->getRowsCount(m_libraryName); ++i)
        m_db->removeRecord(i, m_libraryName);
    deleteAllFromQueue();
    setIsBusy(false);
}

void MusicLibrary::deleteAllFromQueue() {
    QThread::msleep(50);
    QCoreApplication::processEvents();
    emit clearQueue();
    for (int i = 1; i <= m_db->getRowsCount(m_queueName); ++i)
        m_db->removeRecord(i, m_queueName);
}
