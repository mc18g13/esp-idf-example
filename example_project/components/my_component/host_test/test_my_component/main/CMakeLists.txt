idf_component_register(SRCS "main.cpp"
                    INCLUDE_DIRS
                    "."
                    REQUIRES my_component_dependency_mock cmock my_component)
