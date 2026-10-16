# KVB_LCD graphics test module (KVB_TEST.c, KVB_TEXT.c) and CTest checks.
#
# KVB::LCD::Test draws the demonstration screens. It only needs the library
# header, so it is compiled once and linked with any controller binary.

if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  set(_kvb_compiler_name "GCC")
else()
  set(_kvb_compiler_name "${CMAKE_C_COMPILER_ID}")
endif()
string(REGEX MATCH "^[0-9]+" _kvb_compiler_major "${CMAKE_C_COMPILER_VERSION}")

add_library(kvb_lcd_test STATIC KVB_TEST.c KVB_TEXT.c)
add_library(KVB::LCD::Test ALIAS kvb_lcd_test)
target_include_directories(kvb_lcd_test PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(kvb_lcd_test PUBLIC KVB::LCD::Headers kvb_example_platform)
# Strings shown on the demo screens.
target_compile_definitions(kvb_lcd_test PRIVATE
  "KVB_MCU_NAME=\"${KVB_BOARD_MCU}\""
  "KVB_COMPILER_NAME=\"${_kvb_compiler_name}\""
  "KVB_BUILD_NAME=\"CMake + ${_kvb_compiler_name} ${_kvb_compiler_major}\"")

if(NOT KVB_LCD_BUILD_TESTS)
  return()
endif()

# Each check builds a target from inside CTest. The lock keeps two builds
# from running in the same build tree at once.
function(_kvb_add_build_test name target)
  add_test(NAME ${name}
    COMMAND ${CMAKE_COMMAND} --build "${CMAKE_BINARY_DIR}" --target ${target} --config $<CONFIG>)
  set_tests_properties(${name} PROPERTIES RESOURCE_LOCK kvb_lcd_build_tree)
endfunction()

# Link check: every controller binary of the selected board links with the
# HAL, the startup code and the test module.
foreach(_kvb_ctrl IN LISTS KVB_LCD_CONTROLLERS)
  string(TOLOWER "${_kvb_ctrl}" _kvb_lower)
  kvb_lcd_add_firmware(kvb_lcd_link_${_kvb_lower} ${_kvb_ctrl})
  set_target_properties(kvb_lcd_link_${_kvb_lower} PROPERTIES EXCLUDE_FROM_ALL ON)
  _kvb_add_build_test(kvb_lcd.link.${_kvb_ctrl} kvb_lcd_link_${_kvb_lower})
endforeach()

# Header check: KVB_LCD.h compiles on its own in C and in C++.
add_library(kvb_lcd_header_c OBJECT EXCLUDE_FROM_ALL header_check.c)
target_link_libraries(kvb_lcd_header_c PRIVATE KVB::LCD kvb_example_platform)
target_compile_options(kvb_lcd_header_c PRIVATE -Wall -Wextra -Werror)
_kvb_add_build_test(kvb_lcd.header.c kvb_lcd_header_c)

include(CheckLanguage)
check_language(CXX)
if(CMAKE_CXX_COMPILER)
  enable_language(CXX)
  add_library(kvb_lcd_header_cxx OBJECT EXCLUDE_FROM_ALL header_check.cpp)
  target_link_libraries(kvb_lcd_header_cxx PRIVATE KVB::LCD kvb_example_platform)
  target_compile_options(kvb_lcd_header_cxx PRIVATE -Wall -Wextra -Werror)
  _kvb_add_build_test(kvb_lcd.header.cxx kvb_lcd_header_cxx)
endif()
