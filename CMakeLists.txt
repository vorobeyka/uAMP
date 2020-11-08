cmake_minimum_required(VERSION 3.14)

project(player LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check http://doc.qt.io/qt-5/deployment-android.html for more information.
# They need to be set before the find_package(Qt5 ...) call.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

#link_directories(${CMAKE_SOURCE_DIR}/3dparty)
#link_directories(${CMAKE_SOURCE_DIR}/3dparty)

link_directories(C:/Users/vorob/Documents/ucode/uamp/prog/3dparty)
link_directories(C:/Users/vorob/Documents/ucode/uamp/prog/3dparty)


find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED Sql)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED Sql)

if(ANDROID)
    add_library(player SHARED
      main.cpp
      qml.qrc
      database.cpp
      settings.cpp
      appcore.cpp
      settings.h
      database.h
      appcore.h
      3dparty/bass.h
    )
else()
    add_executable(player
      main.cpp
      qml.qrc
      database.cpp
      settings.cpp
      appcore.cpp
      settings.h
      database.h
      appcore.h
      3dparty/bass.h
    )
endif()

target_compile_definitions(player
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(player
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Sql bass)
