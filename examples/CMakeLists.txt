# Demo firmware. The platform directory provides:
#   kvb_example_platform               startup, HAL and compiler options shared
#                                      by the demo and the test module
#   kvb_lcd_add_firmware(<target> <controller>)
#                                      builds a firmware image (.elf/.hex)
#                                      that runs the KVB_LCD graphics test

if(KVB_BOARD_PLATFORM STREQUAL "STM32F407")
  add_subdirectory(stm32f407)
elseif(KVB_BOARD_PLATFORM STREQUAL "AVR")
  add_subdirectory(atmega128)
else()
  message(FATAL_ERROR "KVB_LCD: no example for platform '${KVB_BOARD_PLATFORM}'")
endif()

if(KVB_LCD_BUILD_EXAMPLES)
  kvb_lcd_add_firmware(kvb_lcd_demo ${KVB_LCD_CONTROLLER})
endif()
