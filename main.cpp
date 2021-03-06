#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "settings.h"
#include "musiclibrary.h"
#include "playlists.h"
#include "liveimage.h"
#include <iostream>
#include <locale>
#include <codecvt>
#include <string>
#include <bass.h>

const void* getFile(std::wstring* file){
    return file->data();
}

int main(int argc, char *argv[]) {
//    HSTREAM str;
//    QString sstr = "D:/Dakota - Bare Hands.mp3";
//    BASS_Init(-1,44100, BASS_DEVICE_3D,0,NULL);
//    str=BASS_StreamCreateFile(FALSE, sstr.toLocal8Bit(), 0, 0, 0);
//    BASS_ChannelPlay(str, FALSE);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<LiveImage>("ImageProvider", 1, 0, "LiveImage");
    Settings settings;
    MusicLibrary library(settings.db());
    Playlists playlists(settings.db());
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();

    context->setContextProperty("Settings", &settings);
    context->setContextProperty("library", &library);
    context->setContextProperty("playlists", &playlists);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
