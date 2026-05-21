cmake_minimum_required(VERSION 3.16)

project(wxe hello)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Gui Qml Quick)

add_executable(hyprland-hello main.cpp)

target_link_libraries(hyprland-hello PRIVATE
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)
