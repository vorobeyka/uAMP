#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "settings.h"

int main(int argc, char *argv[]) {
//    DataBase db;
//    db.connectToDataBase();
//    db.readFromTable("Tmp", "BGColor");
//    qDebug() << db.tables();
//    db.readFromTable("Tmp", "BGColor");
//    db.insertIntoTable("Tmp", QStringList() << "syka" << "blyat" << "pizda");
//    db.inserIntoTable("Tmp", QStringList() << "syka" << "blyat" << "pisya");
//    qDebug() << db.rea
    // qDebug()
//    if (db.tables().isEmpty())
//     db.createTable("Tmp", QStringList() << "BGColor VARCHAR(255),"
//                                         << "Tcolor VARCHAR(255),"
//                                         << "TextColor VARCHAR(255))");
//     qDebug() << db.tables();

    // db.inserIntoTable

    // db.inserIntoTable("syka", "blyat", "pisya");
//    QVariantMap map;
//    map.insert("syka", QVariant(5));
//    map.insert("blyat", QVariant("pisya"));
//    for (QVariantMap::iterator i = map.begin(); i != map.end(); i++){
//        qDebug() << map["syka"].toString();
//    }
    Settings settings;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
