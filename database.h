﻿#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>
#include <vector>

/* Директивы имен таблицы, полей таблицы и базы данных */
//#define DATABASE_HOSTNAME   "NameDataBase"
//#define DATABASE_NAME       "Database.db"

//#define TABLE                   "NameTable"         // Название таблицы
//#define TABLE_FNAME             "FisrtName"         // Вторая колонка
//#define TABLE_SNAME             "SurName"           // Третья колонка
//#define TABLE_NIK               "Nik"               // Четвертая колонка

// Первая колонка содержит Autoincrement ID

class DataBase : public QObject {
    Q_OBJECT
public:
    explicit DataBase(QString name, QObject *parent = 0);
    ~DataBase();
    /* Методы для непосредственной работы с классом
     * Подключение к базе данных и вставка записей в таблицу
     * */
    void connectToDataBase();
    void closeDataBase();
    bool isOpen();
    QStringList tables() {
        return db.tables();
    }

    std::vector<QVariantList> readFromTable(QString tableName, int columns, QString value = "*");
    QVariant readValue(QString tableName, QVariant value, QString condColumn, QString readColumn = "*");
    QVariantList readRow(QString tableName, int columns, QVariantMap values);
    QVariantList readSortedValues(QString tableName, QString valueToRead, QString valueToSort);
    QVariantList readReverseSortedValues(QString tableName, QString valueToRead, QString valueToSort);
    QVariantList sortedValues(QString queryString);
    QVariantList reverseSortedValues(QString queryString);
    QVariantList readColumnWithQueue(QString queueString);

public slots:
        // Добавление записей в таблицу
    int getRowsCount(QString tableName);
    bool insertIntoTable(QString tableName, QVariantMap data);
    bool insertIntoTable(QString tableName, QVariantList values);
    bool insertValue(QString tableName, QString column, QVariant value);
    bool updateValue(QString tableName, QString column, QString condition, QVariant value);

    bool removeRecord(const int id, QString tableName); // Удаление записи из таблицы по её id
    bool removeRecord(QString condition, QString tableName);
    bool createTable(QString tName, QStringList columns);
    // bool readFromTable();;

private:
    // Сам объект базы данных, с которым будет производиться работа
    QSqlDatabase    db;
    const QString m_name;
    QString m_hostName;
    bool openDataBase();        // Открытие базы данных
    bool restoreDataBase();     // Восстановление базы данных

};

#endif // DATABASE_H
