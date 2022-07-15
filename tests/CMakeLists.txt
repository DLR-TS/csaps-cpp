
add_executable(test_csaps csaps.cpp)
target_include_directories(test_csaps PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../src ${CMAKE_CURRENT_SOURCE_DIR}/../thirdparty)
target_link_libraries(test_csaps csaps)
