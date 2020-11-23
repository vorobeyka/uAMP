#include "settings.h"

#include <iostream>

using namespace std;

void Settings::initUser() {
    m_db->createTable(m_user + "Library", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                      << "FileName CHARACTER(255), " << "FilePath CHARACTER(255), "
                      << "Title CHARACTER(255), " << "Artist CHARACTER(255), "
                      << "Album CHARACTER(255), " << "Year CHARACTER(255), "
                      << "Genre CHARACTER(255), " << "Rating TINYINT, "
                      << "Like TINYINT, " << "Duration CHARACTER(255), "
                      << "Played TINYINT, " << "PlayedTimes INTEGER, "
                      << "Date TEXT)");
    m_db->createTable(m_user + "Queue", QStringList() << "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
                      << "lib_id INTEGER," << "Title CHARACTER(255), " << "Artist CHARACTER(255), "
                      << "Album CHARACTER(255), " << "Year CHARACTER(255), "
                      << "Genre CHARACTER(255), " << "Rating TINYINT, "
                      << "Like TINYINT, " << "Duration CHARACTER(255), "
                      << "PlayedTimes INTEGER, " << "Date TEXT)");
}
