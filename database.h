#ifndef DATABASE_H
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
    QStringList tables() {
        return db.tables();
    }

public slots:
        // Добавление записей в таблицу
    bool insertIntoTable(QString tableName, QVariantMap data);
    bool insertIntoTable(QString tableName, QStringList values);
    bool insertValue(QString tableName, QString column, QVariant value);
    bool updateValue(QString tableName, QString column, QString condition, QVariant value);
//    bool updateString(QString tableName, QString column, QString)
    std::vector<QVariantList> readFromTable(QString tableName, int columns, QString value = "*");
    QVariant readValue(QString tableName, QVariant value, QString columns = "*");
    QVariantList readRow(QString tableName, int columns, QVariantMap values);
//    QString readString(QString tableName, QString value);
//    QString readInt(QString tableName, QString value);
    bool removeRecord(const int id); // Удаление записи из таблицы по её id
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
