cmake_minimum_required(VERSION 2.8.10)

project(CMakeWithQtFramework)

find_package(Qt4 REQUIRED)
set(QT_USE_QTWEBKIT ON)
include(${QT_USE_FILE})

add_executable(foo main.cpp)
target_link_libraries(foo ${QT_LIBRARIES})

