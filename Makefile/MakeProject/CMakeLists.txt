cmake_minimum_required(VERSION 3.10)
project (APP)

include_directories (util)

add_library(util util/util.hpp util/util.cpp)
set(myadd myadd.hpp myadd.cpp)

add_executable(app app.cpp ${myadd})
target_link_libraries(app util)


