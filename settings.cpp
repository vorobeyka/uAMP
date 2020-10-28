#include "settings.h"


Settings::Settings(QObject* parent) : QObject(parent){
    setDefaultValues();
    m_db = new DataBase("Settings.db");
    m_db->connectToDataBase();
    if (createTable()) {
        if (!readTable()) {
            insertDefaultValues();
            readTable();
            for (auto i : m_settings) {
                for (int j = 0; j < i.size(); j++)
                    qDebug() << i.value(j).toString();
            }
        } else {
            for (auto i : m_settings) {
                for (int j = 0; j < i.size(); j++)
                    qDebug() << i.value(j).toString();
            }
        }
    }

//    if ((settings = m_db->readFromTable("Settings")))
//    if (m_db->readFromTable("Settings.db"))
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
    m_settings = m_db->readFromTable("Settings");
    if (m_settings.empty()) return false;
    else return true;
}

bool Settings::insertDefaultValues() {
    QVariantMap data;

    data.insert("BGColor", m_bgColor);
    data.insert("TBBColor", m_tbbColor);
    data.insert("ThemeColor", m_themeColor);
    data.insert("TextColor", m_textColor);
    data.insert("HoverColor", m_hoverColor);
    data.insert("User", m_user);
    return m_db->insertIntoTable("Settings", data);
}

bool Settings::insertValue() {
    return false;
}

void Settings::setDefaultValues() {
    m_bgColor = "#303030";
    m_tbbColor = "#404040";
    m_themeColor = "#12CBC4";
    m_textColor = "white";
    m_hoverColor = "#BEC3C6";
    m_user = "";
}
