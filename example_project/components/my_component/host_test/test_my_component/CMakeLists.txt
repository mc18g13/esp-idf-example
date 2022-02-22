cmake_minimum_required(VERSION 3.5)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
set(COMPONENTS main)

idf_build_set_property(COMPILE_DEFINITIONS "-DNO_DEBUG_STORAGE" APPEND)

list(APPEND EXTRA_COMPONENT_DIRS "$ENV{SOURCE_DIRECTORY}/components/my_component")
list(APPEND EXTRA_COMPONENT_DIRS "$ENV{SOURCE_DIRECTORY}/components/my_component_dependency")
list(APPEND EXTRA_COMPONENT_DIRS "$ENV{SOURCE_DIRECTORY}/components/esp-google-iot")

list(APPEND EXTRA_COMPONENT_DIRS "$ENV{SOURCE_DIRECTORY}/mocks/my_component_dependency_mock")
list(APPEND EXTRA_COMPONENT_DIRS "$ENV{IDF_PATH}/tools/mocks/freertos")

project(test_my_component)
