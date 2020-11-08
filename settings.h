#ifndef SETTINGS_H
#define SETTINGS_H

#include <vector>
#include "database.h"

#define BACKGROUND_COLOR    "BGColor"
#define TOOLBAR_COLOR       "TBBColor"
#define THEME_COLOR         "ThemeColor"
#define TEXT_COLOR          "TextColor"
#define HOVER_COLOR         "HoverColor"
#define USER                "User"
#define USERS_TABLE_NAME    "Users"

class Settings : public QObject {
    Q_OBJECT

public:
    Q_PROPERTY(QString backGroundColor READ backGroundColor WRITE setBackGroundColor NOTIFY backGroundColorChanged)
    Q_PROPERTY(QString toolBarColor READ toolBarColor WRITE setToolBarColor NOTIFY toolBarColorChanged)
    Q_PROPERTY(QString themeColor READ themeColor WRITE setThemeColor NOTIFY themeColorChanged)
    Q_PROPERTY(QString textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QString hoverColor READ hoverColor WRITE setHoverColor NOTIFY hoverColorChanged)
    Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(bool authorized READ authorized WRITE setAuthorized NOTIFY authorizedChanged)
    Q_PROPERTY(bool isBusy READ isBusy WRITE setIsBusy NOTIFY isBusyChanged)

    Settings(QObject* parent = nullptr);
    ~Settings();

    DataBase* db() const;

    QString backGroundColor() const;
    void setBackGroundColor(QString);
    QString toolBarColor() const;
    void setToolBarColor(QString);
    QString themeColor() const;
    void setThemeColor(QString);
    QString textColor() const;
    void setTextColor(QString);
    QString hoverColor() const;
    void setHoverColor(QString);
    QString userName() const;
    void setUserName(QString);
    bool authorized() const;
    void setAuthorized(bool);
    bool isBusy() const;
    void setIsBusy(bool);

public slots:
    bool checkUser(QString login, QString password);
    bool createUser(QString login, QString password);

signals:
    void backGroundColorChanged(QString value);
    void toolBarColorChanged(QString value);
    void themeColorChanged(QString value);
    void textColorChanged(QString value);
    void hoverColorChanged(QString value);
    void userNameChanged(QString value);
    void authorizedChanged(bool value);
    void isBusyChanged(bool value);

private:
    using T = std::vector<QVariantList>;
    DataBase* m_db;
    bool m_isBusy = true;
    T m_settings;
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

    void initUser();

};

#endif // SETTINGS_H
