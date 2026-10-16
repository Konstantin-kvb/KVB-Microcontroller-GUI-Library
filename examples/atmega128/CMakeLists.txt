# ATmega128 demo. Compiler options follow the original Atmel Studio project.

add_library(kvb_example_platform INTERFACE)
target_compile_definitions(kvb_example_platform INTERFACE F_CPU=${KVB_BOARD_F_CPU})
target_compile_options(kvb_example_platform INTERFACE -ffunction-sections -fdata-sections)

function(kvb_lcd_add_firmware target controller)
  add_executable(${target} "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/main.c")
  set_target_properties(${target} PROPERTIES SUFFIX ".elf")
  target_link_libraries(${target} PRIVATE
    KVB::LCD::Test KVB::LCD::${controller} kvb_example_platform)
  target_link_options(${target} PRIVATE
    LINKER:--gc-sections
    "LINKER:-Map=${CMAKE_CURRENT_BINARY_DIR}/${target}.map")

  string(REPLACE "objcopy" "size" _size "${CMAKE_OBJCOPY}")
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex -R .eeprom $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex
    COMMAND ${CMAKE_OBJCOPY} -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load
            --change-section-lma .eeprom=0 --no-change-warnings $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target}.eep
    COMMAND ${_size} $<TARGET_FILE:${target}>
    BYPRODUCTS
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.eep
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.map
    VERBATIM)
endfunction()
