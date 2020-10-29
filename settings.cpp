#include "settings.h"


Settings::Settings(QObject* parent) : QObject(parent){
    m_db = new DataBase("Settings.db");
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
    if (!m_db->createTable("Settings", QStringList() << "BGColor CHARACTER(20), "
                      << "HoverColor CHARACTER(20), " << "TBBColor CHARACTER(20), "
                      << "TextColor CHARACTER(20), " << "ThemeColor CHARACTER(20), "
                      << "User CHARACTER(20)) ")) {
        return false;
    }
    if (!m_db->createTable("Users", QStringList() << "login VARCHAR(255),"
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
        m_user = m_settings.begin()->at(6).toString();
        return true;
    }
}

bool Settings::insertDefaultValues() {
    QVariantMap data;

    data.insert(BACKGROUND_COLOR, "#303030");
    data.insert(TOOLBAR_COLOR, "#404040");
    data.insert(THEME_COLOR, "#12CBC4");
    data.insert(TEXT_COLOR, "white");
    data.insert(HOVER_COLOR, "#BEC3C6");
    data.insert(USER, "");
    return m_db->insertIntoTable("Settings", data);
}

bool Settings::insertValue() {
    return false;
}

QString Settings::backGroundColor() const {
    return m_bgColor;
}

void Settings::setBackGroundColor(QString color) {
    m_bgColor = color;
    m_db->updateValue("Settings", BACKGROUND_COLOR, color);
    emit backGroundColorChanged(color);
}

QString Settings::toolBarColor() const {
    return m_tbbColor;
}

void Settings::setToolBarColor(QString color) {
    m_tbbColor = color;
    m_db->updateValue("Settings", TOOLBAR_COLOR, color);
    emit toolBarColorChanged(color);
}

QString Settings::themeColor() const {
    return m_themeColor;
}

void Settings::setThemeColor(QString color) {
    m_themeColor = color;
    m_db->updateValue("Settings", THEME_COLOR, color);
    emit themeColorChanged(color);
}

QString Settings::textColor() const {
    return m_textColor;
}

void Settings::setTextColor(QString color) {
    m_textColor = color;
    m_db->updateValue("Settings", TEXT_COLOR, color);
    emit textColorChanged(color);
}

QString Settings::hoverColor() const {
    return m_hoverColor;
}

void Settings::setHoverColor(QString color) {
    m_hoverColor = color;
    m_db->updateValue("Settings", HOVER_COLOR, color);
    emit hoverColorChanged(color);
}

QString Settings::userName() const {
    return m_user;
}

void Settings::setUserName(QString user) {
    m_user = user;
    m_db->updateValue("Settings", USER, user);
    emit userNameChanged(user);
}

bool Settings::authorized() const {
    return !m_user.isNull();
}

void Settings::setAuthorized(bool value) {
    emit authorizedChanged(value);
}
