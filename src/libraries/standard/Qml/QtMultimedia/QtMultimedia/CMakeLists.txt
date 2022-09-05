cmake_minimum_required(VERSION 3.18)

project(qt_multimedia)

set(CMAKE_CXX_STANDARD 17)

# Settings for Qt5
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall -O2")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -O2")

# Qt default installation directory
set(QT_VERSION 5.12.6)

if (WIN32)
    set(QT_PATH "C:/Qt/Qt${QT_VERSION}")
    set(QT_COMPILE_VERSION mingw73_64)
    set(QT_TOOL_VERSION mingw730_64)
else ()
    set(QT_PATH "/opt/Qt")
    set(QT_COMPILE_VERSION "gcc_64")
    set(QT_TOOL_VERSION "gcc_64")
endif ()

set(CMAKE_PREFIX_PATH "${QT_PATH}/${QT_VERSION}/${QT_COMPILE_VERSION}")

message(STATUS "CMAKE_PREFIX_PATH: " ${CMAKE_PREFIX_PATH})

# Set environment variables
if (WIN32)
    set(ENV{PATH} "${CMAKE_PREFIX_PATH}/bin\;${QT_PATH}/Tools/${QT_TOOL_VERSION}/bin\;%PATH%")
    message(STATUS "PATH: " $ENV{PATH})
endif ()

set(ENV{QML2_IMPORT_PATH} "${CMAKE_PREFIX_PATH}/qml")

message(STATUS "QML2_IMPORT_PATH: " $ENV{QML2_IMPORT_PATH})

set(ENV{QT_ASSUME_STDERR_HAS_CONSOLE} 1)

message(STATUS "On Clion, you should set QT_ASSUME_STDERR_HAS_CONSOLE=1;QT_DEBUG_PLUGINS=0;PATH=${CMAKE_PREFIX_PATH}/bin\;${QT_PATH}/Tools/${QT_TOOL_VERSION}/bin;QML2_IMPORT_PATH=${CMAKE_PREFIX_PATH}/qml")

find_package(
        Qt5 COMPONENTS
        Core
        Gui
        Widgets
        Qml
        Quick
        Concurrent
        Multimedia
        Network
        WebSockets
        REQUIRED
)

add_executable(
        qt_multimedia
        main.cpp
        core.cpp
        core.h
        qml.qrc
)

target_link_libraries(
        qt_multimedia
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::Qml
        Qt5::Quick
        Qt5::Concurrent
        Qt5::Multimedia
        Qt5::Network
        Qt5::WebSockets
)

if (WIN32)
    set_target_properties(
            ${PROJECT_NAME}
            PROPERTIES LINK_FLAGS_RELEASE "-mwindows"
    )
endif ()
