
#include "database.h"

DataBase::DataBase(QString name, QObject *parent)
    : QObject(parent), m_name(name) {
    m_hostName = "host" + m_name;
}

DataBase::~DataBase() {}

bool DataBase::isOpen() { return db.isOpen(); }

bool DataBase::insertValue(QString tableName, QString column, QVariant value) {
    qDebug() << "INSERT VALUE"  + value.toString();
    QSqlQuery query;
    query.prepare("INSERT INTO " + tableName + " (" + column + ")" +
                  "VALUES (:" + column + ")");
    query.bindValue(":" + column, value);
    if (!query.exec()) {
        qDebug() << "Error: failed to insert " + value.toString() + " in " + column;
        return false;
    }
    return true;
}

bool DataBase::updateValue(QString tableName, QString column, QString condition, QVariant value) {
    QSqlQuery query;
    QString queryString = "UPDATE " + tableName + " " +
                          "SET \"" + column + "\"=? WHERE " + condition;
    query.prepare(queryString);
    query.addBindValue(value);
    if (!query.exec()) {
        qDebug() << "Error: failed to update " + value.toString() + " in " + column;
        qDebug() << query.lastError();
        return false;
    }
    return true;
}

void DataBase::connectToDataBase() {
      this->openDataBase();
}

bool DataBase::restoreDataBase() {
    return false;
}

/* Метод для открытия базы данных
 * */
bool DataBase::openDataBase() {
    /* База данных открывается по заданному пути
     * и имени базы данных, если она существует
     * */

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(m_hostName);
    db.setDatabaseName(m_name);
    if(db.open()){
        qDebug() << "DB oppened";
        return true;
    } else {
        qDebug() << "Error: Can`t oppen db";
        qDebug() << db.lastError();
        return false;
    }
}

/* Методы закрытия базы данных
 * */
void DataBase::closeDataBase() {
    db.close();
}

/* Метод для создания таблицы в базе данных
 * */
bool DataBase::createTable(QString tName, QStringList columns) {
    /* В данном случае используется формирование сырого SQL-запроса
     * */
    QSqlQuery query;
    QString queryString = "CREATE TABLE IF NOT EXISTS " + tName + " ";
    for (auto i : columns)
        queryString += i;
    if (!query.exec(queryString)) {
        qDebug() << "DatBase: error of create " << tName;
        qDebug() << query.lastError().text();
        return false;
    } else {
        qDebug() << "Table: " + tName + " created.";
        return true;
    }
}

/* Метод для вставки записи в базу данных
 * */
bool DataBase::insertIntoTable(QString tableName, QVariantMap data) {
    /* Запрос SQL формируется из QVariantList,
     * в который передаются данные для вставки в таблицу.
     * */
    QSqlQuery query;
    QString queryString = "INSERT INTO " + tableName + " (";
    QString queryValues = "VALUES (";
    for (QVariantMap::iterator i = data.begin(); i != data.end(); i++) {
        queryString += i.key();
        queryValues += ":" + i.key();
//        qDebug() << i.key() << i.value().toString();
        if (i + 1 != data.end()) {
            queryString += ", ";
            queryValues += ", ";
        } else {
            queryString += ") ";
            queryValues += ")";
        }
        query.bindValue(":" + i.key(), i.value());
    }
    query.prepare(queryString + queryValues);
    for (QVariantMap::iterator i = data.begin(); i != data.end(); i++) {
        query.bindValue(":" + i.key(), i.value().toString());
    }
//    for (QVariantMap::iterator i = data.begin(); i != data.end(); ++i) {
//        queryString +=
//    }
    /* В начале SQL запрос формируется с ключами,
     * которые потом связываются методом bindValue
     * для подстановки данных из QVariantList
     * */
//    query.prepare("INSERT INTO " + data["TableName"].toString() + " (BGColor, "
//                                              "Tcolor, "
//                                             " TextColor) "
//                  "VALUES (:BGColor, :Tcolor, :TextColor)");
//    query.bindValue(":BGColor",       data[1].toString());
//    query.bindValue(":Tcolor",       data[2].toString());
//    query.bindValue(":TextColor",         data[3].toString());

    // После чего выполняется запросом методом exec()
    if(!query.exec()) {
        qDebug() << "error insert into " << tableName;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

/* Второй метод для вставки записи в базу данных
 * */
bool DataBase::insertIntoTable(QString tableName, QVariantList values) {
    QVariantMap map;
    QSqlQuery query;
    QString queryString = "INSERT INTO " + tableName + " VALUES(";

    for (int i = 0; i < values.length() - 1; ++i)
        queryString += "?, ";

    queryString += "?);";
    query.prepare(queryString);
    for (auto i : values) {
        query.addBindValue(i);
    }
    if (!query.exec()) {
        qDebug() << "Can't insert values into " + tableName;
        qDebug() <<query.lastError();
        return false;
    }
    return true;
}

std::vector<QVariantList> DataBase::readFromTable(QString tableName, int columns, QString value) {
    QSqlQuery query;
    std::vector<QVariantList> data;

    if (query.exec("SELECT " + value + " FROM " + tableName)) {
        while (query.next()) {
            QVariantList pack;
            for (int i = 0; i < columns; ++i)
                pack.append(query.value(i));
            data.push_back(pack);
        }
        qDebug() << "Info: sucksess to read from " + tableName;
    } else qDebug() << "Error: failed to read from " + tableName << query.lastError();
    return data;
}

QVariant DataBase::readValue(QString tableName, QVariant value, QString condColumn, QString readColumn) {
    QSqlQuery query;
    QVariant data;

    query.prepare("SELECT " + readColumn + " FROM " + tableName +
                  " WHERE \"" + condColumn + "\"=?;");
    query.addBindValue(value);
    if (!query.exec()) qDebug() << "Error: can`t read value: " << query.lastError();
    else if (query.next()) data = query.value(0);
    else qDebug() << "Info: not fund: " + value.toString() + " in " + condColumn;
    return data;
}

QVariantList DataBase::readRow(QString tableName, int columns, QVariantMap values) {
    QSqlQuery query;
    QVariantList data;
    QString queryString = "SELECT * FROM " + tableName + " WHERE ";

    for (QVariantMap::iterator i = values.begin(); i != values.end(); ++i) {
        queryString += "\"" + i.key() + "\"=?";
        if (i + 1 != values.end()) queryString += ",";
        else queryString += ";";
    }
    query.prepare(queryString);
    for (QVariantMap::iterator i = values.begin(); i != values.end(); ++i) {
        query.addBindValue(i.value());
    }
    if (!query.exec()) qDebug() << "Error: can`t read row" << query.lastError();
    else if (query.next()) {
        for (int i = 0; i < columns; ++i)
            data.push_back(query.value(i));
    }
    return data;
}

QVariantList DataBase::readSortedValues(QString tableName, QString valueToRead, QString valueToSort) {
    QVariantList rez;
    QSqlQuery query;
    if (query.exec("SELECT " + valueToRead + " FROM " + tableName + " ORDER BY " + valueToSort + " ASC;")) {
        while (query.next()) {
            rez << query.value(0);
        }
    } else {
        qDebug() << "ERROR: can't read sorted data ";
        qDebug() << query.lastError();
    }
    return rez;
}

QVariantList DataBase::readReverseSortedValues(QString tableName, QString valueToRead, QString valueToSort) {
    QVariantList rez;
    QSqlQuery query;
    if (query.exec("SELECT " + valueToRead + " FROM " + tableName + " ORDER BY " + valueToSort + " DESC;")) {
        while (query.next()) {
            rez << query.value(0);
        }
    } else {
        qDebug() << "ERROR: can't read sorted data ";
        qDebug() << query.lastError();
    }
    return rez;
}

QVariantList DataBase::readColumnWithQueue(QString queueString) {
    QVariantList rez;
    QSqlQuery query;
    query.exec(queueString);
    while (query.next()) {
        rez << query.value(0);
    }
    return rez;
}

/* Метод для удаления записи из таблицы
 * */
bool DataBase::removeRecord(const int id, QString tableName) {
    // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
    QSqlQuery query;

    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " + tableName + " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    // Выполняем удаление
    if(!query.exec()){
        qDebug() << "error delete row ";// << /*TABLE*/;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool DataBase::removeRecord(QString condition, QString tableName) {
    // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
    QSqlQuery query;

    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " + tableName + " WHERE " + condition + ";");

    // Выполняем удаление
    if(!query.exec()){
        qDebug() << "error delete row ";// << /*TABLE*/;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

int DataBase::getRowsCount(QString tableName) {
    QSqlQuery query;
    query.exec("SELECT MAX(id) FROM " + tableName + ";");
    if (query.next()) return query.value(0).toInt();
    return 0;
}
