#ifndef SETTINGS_H
#define SETTINGS_H

#include <vector>

#include "database.h"

class Settings : public QObject {
    Q_OBJECT

public:
    Settings(QObject* parent = nullptr);
    ~Settings();

private:
    DataBase* m_db;
    std::vector<QVariantList> m_settings;
    QString m_bgColor;
    QString m_tbbColor;
    QString m_themeColor;
    QString m_textColor;
    QString m_hoverColor;
    QString m_user;

    bool createTable();
    bool readTable();
    bool insertValue();
    bool insertDefaultValues();
    void setDefaultValues();

};

#endif // SETTINGS_H
