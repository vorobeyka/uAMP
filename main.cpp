#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "database.h"

int main(int argc, char *argv[]) {
    DataBase db;

    db.connectToDataBase();
    qDebug() << db.tables();
//    if (db.tables().isEmpty())
    // db.createTable("Tmp", QStringList() << "BGColor VARCHAR(255),"
                                        // << "Tcolor VARCHAR(255),"
                                        // << "TextColor VARCHAR(255))");
    // db.inserIntoTable

    // db.inserIntoTable("syka", "blyat", "pisya");
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
