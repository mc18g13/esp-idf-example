set(original_component_dir $ENV{SOURCE_DIRECTORY}/components/my_component_dependency)

idf_component_mock(INCLUDE_DIRS "${original_component_dir}/include"
    REQUIRES freertos
    MOCK_HEADER_FILES ${original_component_dir}/include/my_component_dependency.h)
