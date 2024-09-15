cmake_minimum_required(VERSION 3.16)
project(helios VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(src)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Gui)

qt_standard_project_setup()

qt_add_executable(helios
    ${SOURCES}
    resources.qrc
)

target_link_libraries(helios PRIVATE Qt6::Core Qt6::Quick Qt6::Gui)

set_target_properties(helios PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)

# qt_finalize_executable(helios)