#include "settings.h"

#include <iostream>
using namespace std;
void Settings::initUser() {
    m_db->createTable(m_user + "Library", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                      << "FileName CHARACTER(255), " << "FilePath CHARACTER(255), "
                      << "Title CHARACTER(255), " << "Artist CHARACTER(255), "
                      << "Album CHARACTER(255), " << "Year CHARACTER(255), "
                      << "Genre CHARACTER(255), " << "Rating TINYINT, "
                      << "Like TINYINT, " << "Duration REAL, "
                      << "Played TINYINT, " << "PlayedTimes INTEGER, "
                      << "Date INTEGER)");
    T tmp = m_db->readFromTable(m_user + "Library", 14);
    for (auto i : tmp) {
        for (auto j : i) {
            cout << j.toString().toStdString() + " ";
        }
        cout << endl;
    }
}
