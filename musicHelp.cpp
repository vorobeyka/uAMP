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
