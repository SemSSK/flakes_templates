cmake_minimum_required(VERSION 3.26.4)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
project(app LANGUAGES CXX)

file(GLOB source_files "src/*.cpp")
file(GLOB header_files "src/*.h")

add_executable(heyo ${source_files})



