#include <QThread>
#include <QCoreApplication>
#include "settings.h"

Settings::Settings(QObject* parent) : QObject(parent){
    m_db = new DataBase("Settings.db", this);
    m_db->connectToDataBase();

    if (createTable()) {
        if (!readTable()) {
            insertDefaultValues();
            readTable();
        }
    }
}

Settings::~Settings() {
    m_db->closeDataBase();
    delete m_db;
}

bool Settings::createTable() {
    if (!m_db->createTable("Settings", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                      << "BGColor CHARACTER(20), " << "HoverColor CHARACTER(20), "
                      << "TBBColor CHARACTER(20), " << "TextColor CHARACTER(20), "
                      << "ThemeColor CHARACTER(20), " << "User CHARACTER(20)) ")) {
        return false;
    }
    if (!m_db->createTable("Users", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                           << "login VARCHAR(255),"
                           << "password VARCHAR(255))")) {
        return false;
    }
    return true;
}

bool Settings::readTable() {
    m_settings = m_db->readFromTable("Settings", 7);
    if (m_settings.empty()) return false;
    else {
        m_bgColor = m_settings.begin()->at(1).toString();
        m_hoverColor = m_settings.begin()->at(2).toString();
        m_tbbColor = m_settings.begin()->at(3).toString();
        m_textColor = m_settings.begin()->at(4).toString();
        m_themeColor = m_settings.begin()->at(5).toString();
        if (m_settings.begin()->at(6).toString().size() != 0) {
            m_user = m_settings.begin()->at(6).toString();
            initUser();
        }
        return true;
    }
}

bool Settings::insertDefaultValues() {
    QVariantMap data;

    data.insert(BACKGROUND_COLOR, "#303030");
    data.insert(TOOLBAR_COLOR, "#404040");
    data.insert(THEME_COLOR, "#12CBC4");
    data.insert(TEXT_COLOR, "#E0E0E0");
    data.insert(HOVER_COLOR, "#BEC3C6");
    data.insert(USER, "");
    return m_db->insertIntoTable("Settings", data);
}

bool Settings::insertValue() { return false; }

QString Settings::backGroundColor() const { return m_bgColor; }

void Settings::setBackGroundColor(QString color) {
    m_bgColor = color;
    m_db->updateValue("Settings", BACKGROUND_COLOR, "id = 1", color);
    emit backGroundColorChanged(color);
}

QString Settings::toolBarColor() const { return m_tbbColor; }

void Settings::setToolBarColor(QString color) {
    m_tbbColor = color;
    m_db->updateValue("Settings", TOOLBAR_COLOR, "id = 1", color);
    emit toolBarColorChanged(color);
}

QString Settings::themeColor() const { return m_themeColor; }

void Settings::setThemeColor(QString color) {
    m_themeColor = color;
    m_db->updateValue("Settings", THEME_COLOR, "id=1", color);
    emit themeColorChanged(color);
}

QString Settings::textColor() const { return m_textColor; }

void Settings::setTextColor(QString color) {
    m_textColor = color;
    m_db->updateValue("Settings", TEXT_COLOR, "id = 1", color);
    emit textColorChanged(color);
}

QString Settings::hoverColor() const { return m_hoverColor; }

void Settings::setHoverColor(QString color) {
    m_hoverColor = color;
    m_db->updateValue("Settings", HOVER_COLOR, "id = 1", color);
    emit hoverColorChanged(color);
}

QString Settings::userName() const { return m_user; }

void Settings::setUserName(QString user) {
    m_user = user;
    m_db->updateValue("Settings", USER, "id = 1", user);
    emit userNameChanged(user);
}

bool Settings::authorized() const { return !m_user.isNull(); }

void Settings::setAuthorized(bool value) { emit authorizedChanged(value); }

bool Settings::isBusy() const { return m_isBusy; }

DataBase* Settings::db() const { return m_db; }

void Settings::setIsBusy(bool value) {
    m_isBusy = value;
    emit isBusyChanged(value);
    if (m_isBusy) {
        QThread::msleep(50);
        QCoreApplication::processEvents();
    }
}

bool Settings::checkUser(QString user, QString password) {
    QVariantMap tmp;
    tmp.insert("login", user);
    QVariantList data = m_db->readRow(USERS_TABLE_NAME, 3, tmp);
    if (!data.isEmpty()) {
        if (data.at(1) == user && data.at(2) == password) {
            setUserName(user);
            setAuthorized(true);
            initUser();
            return true;
        }
    }
    return false;
}

bool Settings::createUser(QString login, QString password) {
    if (!m_db->readValue(USERS_TABLE_NAME, login, "login", "login").isNull())
        return false;
    QVariantMap data;
    data.insert("login", login);
    data.insert("password", password);
    m_db->insertIntoTable(USERS_TABLE_NAME, data);
    setUserName(login);
    setAuthorized(true);
    initUser();
    return true;
}
