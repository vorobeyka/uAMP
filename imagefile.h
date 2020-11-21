#ifndef IMAGEFILE_H
#define IMAGEFILE_H

#include <tag.h>
#include <id3v2frame.h>
#include <frames/attachedpictureframe.h>
#include <id3v2tag.h>
#include <unsynchronizedlyricsframe.h>
#include <mpegfile.h>
#include <attachedpictureframe.h>
#include <fileref.h>

//#if defined(Q_OS_WIN)
//    #define OS 1
//#elif defined(Q_OS_MAC)
//    #define OS 2
//#elif defined(Q_OS_LINUX)
//    #define OS 3
//#endif

class ImageFile : public TagLib::File {
public:
//#if OS != 1
//    #define ImageFile(const wchar_t *file) : TagLib::File(FileName(file)) { }
//#endif
    ImageFile(const char *file) : TagLib::File(file) { }

    TagLib::ByteVector data() {
        return readBlock(length());
    }
private:
    virtual TagLib::Tag *tag() const { return 0; }
    virtual TagLib::AudioProperties *audioProperties() const { return 0; }
    virtual bool save() { return false; }
};

#endif // IMAGEFILE_H
