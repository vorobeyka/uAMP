cmake_minimum_required(VERSION 3.14)

project(player LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


FIND_PACKAGE(Boost)
IF (Boost_FOUND)
    INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR})
    ADD_DEFINITIONS( "-DHAS_BOOST" )
ENDIF()

add_subdirectory(3dparty)

link_directories(${CMAKE_SOURCE_DIR}/3dparty)
link_directories(${CMAKE_SOURCE_DIR}/3dparty)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED Sql Widgets)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED Sql Widgets)

find_library(TAGLIB libtag)
set(TAGLIB_PATH "${CMAKE_SOURCE_DIR}/3dparty/taglib/taglib")

include_directories(
#    ../build-project-Desktop_Qt_5_15_0_MSVC2015_64bit-Debug/3dparty/taglib
    ../build-prog-Desktop_x86_windows_msvc2019_pe_64bit-Debug/3dparty/taglib
    ${TAGLIB_PATH}/ape
    ${TAGLIB_PATH}/asf
    ${TAGLIB_PATH}/flac
    ${TAGLIB_PATH}/it
    ${TAGLIB_PATH}/mod
    ${TAGLIB_PATH}/mp4
    ${TAGLIB_PATH}/mpc
    ${TAGLIB_PATH}/mpeg
    ${TAGLIB_PATH}/mpeg/id3v2
    ${TAGLIB_PATH}/mpeg/id3v2/frames
    ${TAGLIB_PATH}/ogg
    ${TAGLIB_PATH}/riff
    ${TAGLIB_PATH}/s3m
    ${TAGLIB_PATH}/toolkit
    ${TAGLIB_PATH}/trueaudio
    ${TAGLIB_PATH}/wavpack
    ${TAGLIB_PATH}/xm
    ${TAGLIB_PATH}
    ${CMAKE_SOURCE_DIR}/3dparty
)

add_executable(player
  main.cpp
  qml.qrc
  database.cpp
  settings.cpp
  usermusics.cpp
  musiclibrary.cpp
  liveimage.cpp
  musicHelp.cpp
  musicTags.cpp
  playlists.cpp
  settings.h
  database.h
  musiclibrary.h
  liveimage.h
  imagefile.h
  playlists.h
  3dparty/bass.h
)

target_compile_definitions(player
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(player
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Sql bass tag)
