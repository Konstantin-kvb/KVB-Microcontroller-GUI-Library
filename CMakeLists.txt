cmake_minimum_required(VERSION 3.21)

project(KVB_LCD
  VERSION 1.0.0
  DESCRIPTION "KVB graphics library for 16-bit parallel LCD panels on STM32F407 and ATmega128"
  HOMEPAGE_URL "https://github.com/Konstantin-kvb/KVB-Microcontroller-GUI-Library"
  LANGUAGES C)

option(KVB_LCD_BUILD_EXAMPLES "Build the demo firmware for the selected board" ${PROJECT_IS_TOP_LEVEL})
option(KVB_LCD_BUILD_TESTS "Build the graphics test module and register CTest checks" ${PROJECT_IS_TOP_LEVEL})
option(KVB_LCD_INSTALL "Generate install rules and the find_package configuration" ${PROJECT_IS_TOP_LEVEL})

set(KVB_LCD_INCLUDE_DIR "${PROJECT_SOURCE_DIR}/include")
set(KVB_LCD_LIB_DIR "${PROJECT_SOURCE_DIR}/lib")
set(KVB_LCD_BOARDS_DIR "${PROJECT_SOURCE_DIR}/cmake/boards")
include(cmake/KVB_LCDTargets.cmake)

# --- Examples and tests ----------------------------------------------------------
if(KVB_LCD_BUILD_EXAMPLES OR KVB_LCD_BUILD_TESTS)
  if(CMAKE_C_COMPILER_ID STREQUAL "ARMClang")
    message(WARNING "KVB_LCD: examples and tests support GCC toolchains only, skipping them")
  else()
    if(KVB_BOARD_PLATFORM STREQUAL "STM32F407")
      # Startup code is assembly. Enabled here because the firmware targets
      # are created both in examples/ and in tests/.
      enable_language(ASM)
    endif()
    if(KVB_LCD_BUILD_TESTS)
      enable_testing()
    endif()
    # examples/ defines kvb_lcd_add_firmware(), tests/ defines KVB::LCD::Test.
    add_subdirectory(examples)
    add_subdirectory(tests)
  endif()
endif()

# --- Install and package configuration ---------------------------------------------
if(KVB_LCD_INSTALL)
  include(GNUInstallDirs)
  include(CMakePackageConfigHelpers)

  set(KVB_LCD_INSTALL_LIBDIR "${CMAKE_INSTALL_LIBDIR}/KVB_LCD")
  set(_kvb_cmake_dir "${CMAKE_INSTALL_LIBDIR}/cmake/KVB_LCD")

  install(FILES include/KVB_LCD.h DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
  install(DIRECTORY lib/ DESTINATION "${KVB_LCD_INSTALL_LIBDIR}")
  install(DIRECTORY cmake/boards DESTINATION "${_kvb_cmake_dir}")
  install(FILES cmake/KVB_LCDTargets.cmake DESTINATION "${_kvb_cmake_dir}")
  install(FILES LICENSE.txt DESTINATION "${CMAKE_INSTALL_DOCDIR}")

  configure_package_config_file(cmake/KVB_LCDConfig.cmake.in
    "${PROJECT_BINARY_DIR}/KVB_LCDConfig.cmake"
    INSTALL_DESTINATION "${_kvb_cmake_dir}"
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR KVB_LCD_INSTALL_LIBDIR)
  # The package holds binaries for 8-bit AVR and 32-bit ARM, so the version
  # check must not compare pointer sizes.
  write_basic_package_version_file("${PROJECT_BINARY_DIR}/KVB_LCDConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
    ARCH_INDEPENDENT)
  install(FILES
    "${PROJECT_BINARY_DIR}/KVB_LCDConfig.cmake"
    "${PROJECT_BINARY_DIR}/KVB_LCDConfigVersion.cmake"
    DESTINATION "${_kvb_cmake_dir}")
endif()
