cmake_minimum_required(VERSION 3.18)
project(Agamemnon LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "build_type" FORCE)
endif()

set(GODOT_CPP_DIR "${CMAKE_SOURCE_DIR}/../godot-cpp")
add_subdirectory(${GODOT_CPP_DIR} godot-cpp-build)

file(GLOB_RECURSE AUCTION_KING_SOURCES
    "core/*.cpp"  
    "core/*.h"
    "utils/*.cpp" 
    "utils/*.h"
)