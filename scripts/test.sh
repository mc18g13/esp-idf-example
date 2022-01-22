cd ${SOURCE_DIRECTORY}/components/my_component/host_test/test_my_component

rm -r build
idf.py build

./build/test_my_component.elf