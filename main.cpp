#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "settings.h"
#include "appcore.h"
#include <iostream>
#include "3dparty/bass.h"

const void* getFile(std::wstring* file){
    return file->data();
}

int main(int argc, char *argv[]) {
//    std::wstring* strr = new std::wstring(L"E:/Проект Х_ - Tach me.mp3");
    HSTREAM str;
    wchar_t* sstr = L"E:/Музон/Black Sabbath - Solitude.mp3";
    BASS_Init(-1,44100, BASS_DEVICE_3D,0,NULL); //Инициализация звукового потока
    str=BASS_StreamCreateFile(FALSE, sstr, 0, 0, 0); //Создаем поток str. Расположение нашего файла MP3
    BASS_ChannelPlay(str, FALSE); //Проигрываем наш звуковой поток str
//    HSTREAM chan;
//    BASS_Init(-1,44100, BASS_DEVICE_3D,0,NULL);
////    BASS_ChannelStop(chan);
//    chan = BASS_StreamCreateFile(FALSE, "E:/Black Sabbath - Solitude.mp3", 0, 0, BASS_UNICODE | BASS_SAMPLE_LOOP);
////    chan = BASS_MusicLoad(false, "E:/Tach me.mp3", 0, 0, BASS_UNICODE | BASS_MUSIC_RAMP | BASS_SAMPLE_LOOP, 1)

//    BASS_ChannelPlay(chan, FALSE);
//    else
//    {
//        endOfMusic = false;
//        BASS_ChannelPlay(chan, true);
//        t->start(100);
//        BASS_ChannelSetSync(chan, BASS_SYNC_END, 0, &syncFunc, 0);
//        playing = true;
//    }



    AppCore appCore;
    Settings settings;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();

    context->setContextProperty("Settings", &settings);
    context->setContextProperty("appcore", &appCore);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
