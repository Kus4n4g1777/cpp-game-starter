# Minimum version of CMake required
cmake_minimum_required(VERSION 3.10)

# Define the project name
project(MyGameStarter VERSION 0.1 LANGUAGES CXX)

# Add an executable target
# This tells CMake to create an executable named 'my_game'
# from the source file 'src/main.cpp'
add_executable(my_game src/main.cpp)

# You can add more configuration here later,
# e.g., include directories, linking libraries like SDL, SFML, etc.
