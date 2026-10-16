# Creates the imported targets of the KVB_LCD library.
#
# Shared by the source tree (CMakeLists.txt) and the installed package
# (KVB_LCDConfig.cmake). The caller sets:
#   KVB_LCD_INCLUDE_DIR  directory with KVB_LCD.h
#   KVB_LCD_LIB_DIR      directory with <BOARD>/<toolchain>/ prebuilt binaries
#   KVB_LCD_BOARDS_DIR   directory with <BOARD>.cmake descriptions
#
# User settings (cache variables):
#   KVB_LCD_BOARD        BLACK_F407VET6 | BLACK_F407ZGT6 | OPEN407_F407VGT6 | ATMEGA128
#   KVB_LCD_CONTROLLER   ILI9325 | ILI9341 | ILI9481 | ILI9486 | OTM8009A
#   KVB_LCD_HAL_TARGET   optional STM32 HAL target that KVB::LCD links after
#                        the prebuilt binary (for example stm32cubemx)
#
# Targets:
#   KVB::LCD             the library for the selected board and controller
#   KVB::LCD::<CTRL>     the library for a specific controller
#   KVB::LCD::Headers    include directory and platform options only

include_guard(GLOBAL)

set(KVB_LCD_BOARDS BLACK_F407VET6 BLACK_F407ZGT6 OPEN407_F407VGT6 ATMEGA128)
set(KVB_LCD_CONTROLLERS ILI9325 ILI9341 ILI9481 ILI9486 OTM8009A)

# --- Board -------------------------------------------------------------------
set(_kvb_default_board "")
if(CMAKE_SYSTEM_PROCESSOR MATCHES "^avr" OR CMAKE_C_COMPILER MATCHES "avr-gcc")
  set(_kvb_default_board ATMEGA128)
endif()

# A plain variable set by the parent project wins. Passing it as the cache
# default keeps it even under policy CMP0126 OLD (projects older than 3.21).
if(NOT "${KVB_LCD_BOARD}" STREQUAL "")
  set(_kvb_default_board "${KVB_LCD_BOARD}")
endif()
set(KVB_LCD_BOARD "${_kvb_default_board}" CACHE STRING "KVB_LCD target board")
set_property(CACHE KVB_LCD_BOARD PROPERTY STRINGS ${KVB_LCD_BOARDS})
if(NOT KVB_LCD_BOARD IN_LIST KVB_LCD_BOARDS)
  string(REPLACE ";" ", " _kvb_list "${KVB_LCD_BOARDS}")
  message(FATAL_ERROR
    "KVB_LCD: set KVB_LCD_BOARD to one of: ${_kvb_list} (current value: '${KVB_LCD_BOARD}')")
endif()
include("${KVB_LCD_BOARDS_DIR}/${KVB_LCD_BOARD}.cmake")

# --- Controller --------------------------------------------------------------
set(_kvb_default_controller ILI9486)
if(NOT "${KVB_LCD_CONTROLLER}" STREQUAL "")
  set(_kvb_default_controller "${KVB_LCD_CONTROLLER}")
endif()
set(KVB_LCD_CONTROLLER "${_kvb_default_controller}" CACHE STRING "KVB_LCD display controller")
set_property(CACHE KVB_LCD_CONTROLLER PROPERTY STRINGS ${KVB_LCD_CONTROLLERS})
if(NOT KVB_LCD_CONTROLLER IN_LIST KVB_LCD_CONTROLLERS)
  string(REPLACE ";" ", " _kvb_list "${KVB_LCD_CONTROLLERS}")
  message(FATAL_ERROR
    "KVB_LCD: set KVB_LCD_CONTROLLER to one of: ${_kvb_list} (current value: '${KVB_LCD_CONTROLLER}')")
endif()

set(KVB_LCD_HAL_TARGET "${KVB_LCD_HAL_TARGET}" CACHE STRING
  "STM32 HAL target linked after the KVB_LCD binary (optional)")

# --- Prebuilt binary flavour ---------------------------------------------------
if(CMAKE_C_COMPILER_ID STREQUAL "ARMClang")
  if(KVB_BOARD_PLATFORM STREQUAL "AVR")
    message(FATAL_ERROR "KVB_LCD: board ${KVB_LCD_BOARD} needs avr-gcc, not ARMClang")
  endif()
  set(_kvb_flavour armclang)
  set(_kvb_prefix "")
  set(_kvb_suffix ".lib")
elseif(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  set(_kvb_flavour gcc)
  set(_kvb_prefix "lib")
  set(_kvb_suffix ".a")
else()
  message(FATAL_ERROR
    "KVB_LCD: unsupported compiler ${CMAKE_C_COMPILER_ID}. "
    "Use arm-none-eabi-gcc, avr-gcc or armclang (see cmake/toolchains).")
endif()

# --- Targets -------------------------------------------------------------------
add_library(KVB::LCD::Headers INTERFACE IMPORTED GLOBAL)
set_target_properties(KVB::LCD::Headers PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${KVB_LCD_INCLUDE_DIR}")

if(KVB_BOARD_PLATFORM STREQUAL "AVR")
  # Same ABI-relevant options as the original Atmel Studio build. Strings
  # passed to the library must be CP1251, so UTF-8 sources are converted.
  set_target_properties(KVB::LCD::Headers PROPERTIES
    INTERFACE_COMPILE_OPTIONS
      "$<$<COMPILE_LANGUAGE:C,CXX>:-funsigned-char;-funsigned-bitfields;-fpack-struct;-fshort-enums;-finput-charset=UTF-8;-fexec-charset=CP1251>"
    INTERFACE_LINK_LIBRARIES m)
else()
  if(_kvb_flavour STREQUAL "gcc")
    # The library prints floats with sprintf; newlib-nano drops that by default.
    set_target_properties(KVB::LCD::Headers PROPERTIES
      INTERFACE_LINK_OPTIONS "LINKER:-u,_printf_float")
  endif()
  if(KVB_LCD_HAL_TARGET)
    set_property(TARGET KVB::LCD::Headers APPEND PROPERTY
      INTERFACE_LINK_LIBRARIES "${KVB_LCD_HAL_TARGET}")
  endif()
endif()

foreach(_kvb_ctrl IN LISTS KVB_LCD_CONTROLLERS)
  set(_kvb_file
    "${KVB_LCD_LIB_DIR}/${KVB_LCD_BOARD}/${_kvb_flavour}/${_kvb_prefix}KVB_LCD_${_kvb_ctrl}${_kvb_suffix}")
  if(NOT EXISTS "${_kvb_file}")
    message(FATAL_ERROR "KVB_LCD: prebuilt library not found: ${_kvb_file}")
  endif()
  add_library(KVB::LCD::${_kvb_ctrl} STATIC IMPORTED GLOBAL)
  set_target_properties(KVB::LCD::${_kvb_ctrl} PROPERTIES
    IMPORTED_LOCATION "${_kvb_file}"
    IMPORTED_LINK_INTERFACE_LANGUAGES C
    INTERFACE_COMPILE_DEFINITIONS "USE_${_kvb_ctrl}"
    INTERFACE_LINK_LIBRARIES KVB::LCD::Headers)
endforeach()

add_library(KVB::LCD INTERFACE IMPORTED GLOBAL)
set_target_properties(KVB::LCD PROPERTIES
  INTERFACE_LINK_LIBRARIES "KVB::LCD::${KVB_LCD_CONTROLLER}")

message(STATUS "KVB_LCD: board ${KVB_LCD_BOARD} (${KVB_BOARD_MCU}), "
               "controller ${KVB_LCD_CONTROLLER}, ${_kvb_flavour} binaries")
