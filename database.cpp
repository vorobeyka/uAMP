#include "database.h"

DataBase::DataBase(QString name, QObject *parent)
    : QObject(parent), m_name(name) {
    m_hostName = "host" + m_name;
}

DataBase::~DataBase() {}

/* Методы для подключения к базе данных
 * */
void DataBase::connectToDataBase() {
    /* Перед подключением к базе данных производим проверку на её существование.
     * В зависимости от результата производим открытие базы данных или её восстановление
     * */
//    if(!QFile(QCoreApplication::applicationDirPath() + DATABASE_NAME).exists()){
//        this->restoreDataBase();
//    } else {
      this->openDataBase();
//    }
}

/* Методы восстановления базы данных
 * */
bool DataBase::restoreDataBase() {
    // Если база данных открылась ...
//    if(this->openDataBase()){
        // Производим восстановление базы данных
//        return (this->createTable()) ? true : false;
//    } else {
//        qDebug() << "Не удалось восстановить базу данных";
//        return false;
//    }
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
    QString queryString = "CREATE TABLE IF NOT EXISTS " + tName + " (id INTEGER PRIMARY KEY AUTOINCREMENT, ";
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
//    QSqlQuery query;
//    if(!query.exec( "CREATE TABLE " TABLE " ("
//                            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//                            TABLE_FNAME     " VARCHAR(255)    NOT NULL,"
//                            TABLE_SNAME     " VARCHAR(255)    NOT NULL,"
//                            TABLE_NIK       " VARCHAR(255)    NOT NULL"
//                        " )"
//                    )){
//        qDebug() << "DataBase: error of create " << TABLE;
//        qDebug() << query.lastError().text();
//        return false;
//    } else {
//        return true;
//    }
//    return false;
}

/* Метод для вставки записи в базу данных
 * */
bool DataBase::insertIntoTable(QString tableName, QVariantMap data) {
    /* Запрос SQL формируется из QVariantList,
     * в который передаются данные для вставки в таблицу.
     * */
    QSqlQuery query;
    QString queryString = "INSERT INTO " + tableName + " (";
    QString queryVlues = "VALUES (";
    for (QVariantMap::iterator i = data.begin(); i != data.end(); i++) {
        queryString += i.key();
        queryVlues += ":" + i.key();
//        qDebug() << i.key() << i.value().toString();
        if (i + 1 != data.end()) {
            queryString += ", ";
            queryVlues += ", ";
        } else {
            queryString += ") ";
            queryVlues += ")";
        }
        query.bindValue(":" + i.key(), i.value());
    }
    query.prepare(queryString + queryVlues);
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
    if(!query.exec()){
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
bool DataBase::insertIntoTable(QString tableName, QStringList values) {
    QVariantMap map;
    (void)tableName;
    (void)values;

    if(insertIntoTable(tableName, map))
        return true;
    else
        return false;
}

std::vector<QVariantList> DataBase::readFromTable(QString tableName, QString value) {
    QSqlQuery query;
    std::vector<QVariantList> data;

    if (query.exec("SELECT " + value + " FROM " + tableName)) {
        while (query.next()) {
            QVariantList pack;
            qDebug() << query.value("TextColor");
            for (int i = 0; i < query.size(); ++i) {
                pack.append(query.value(i));

            }
            data.push_back(pack);
        }
        qDebug() << "Info: sucksess to read from " + tableName;
    } else qDebug() << "Error: failed to read from " + tableName << query.lastError();
    return data;
}

/* Метод для удаления записи из таблицы
 * */
bool DataBase::removeRecord(const int id) {
    // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
    QSqlQuery query;

    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " /*TABLE*/ " WHERE id= :ID ;");
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
