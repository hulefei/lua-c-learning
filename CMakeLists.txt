cmake_minimum_required(VERSION 3.17)
project(Lua)

#set(CMAKE_C_STANDARD 99)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 添加子目录
add_subdirectory(lualib)

add_executable(Lua main.c)

target_link_libraries(Lua lualib)