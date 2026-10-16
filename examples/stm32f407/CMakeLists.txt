# STM32F407 demo: CubeMX-generated startup code and HAL shared by all boards.
# Board differences live in boards/<BOARD>/board.h.

set(_kvb_drivers "${PROJECT_SOURCE_DIR}/third_party/Drivers")

add_library(kvb_stm32f4_hal STATIC
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nand.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_nor.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pccard.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_sram.c
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Src/stm32f4xx_ll_fsmc.c)
target_include_directories(kvb_stm32f4_hal PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/Core/Inc
  ${CMAKE_CURRENT_SOURCE_DIR}/boards/${KVB_LCD_BOARD}
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Inc
  ${_kvb_drivers}/STM32F4xx_HAL_Driver/Inc/Legacy
  ${_kvb_drivers}/CMSIS/Device/ST/STM32F4xx/Include
  ${_kvb_drivers}/CMSIS/Include)
target_compile_definitions(kvb_stm32f4_hal PUBLIC USE_HAL_DRIVER STM32F407xx)
target_compile_options(kvb_stm32f4_hal PUBLIC -ffunction-sections -fdata-sections)

add_library(kvb_example_platform INTERFACE)
target_link_libraries(kvb_example_platform INTERFACE kvb_stm32f4_hal)

function(kvb_lcd_add_firmware target controller)
  set(_dir "${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
  set(_ld "${CMAKE_CURRENT_BINARY_DIR}/${target}.ld")
  configure_file("${_dir}/STM32F407_FLASH.ld.in" "${_ld}" @ONLY)

  add_executable(${target}
    ${_dir}/Core/Src/main.c
    ${_dir}/Core/Src/stm32f4xx_hal_msp.c
    ${_dir}/Core/Src/stm32f4xx_it.c
    ${_dir}/Core/Src/system_stm32f4xx.c
    ${_dir}/Core/Src/syscalls.c
    ${_dir}/Core/Src/sysmem.c
    ${_dir}/startup_stm32f407xx.s)
  set_target_properties(${target} PROPERTIES SUFFIX ".elf" LINK_DEPENDS "${_ld}")
  # Order matters for static linking: the prebuilt binary calls HAL functions.
  target_link_libraries(${target} PRIVATE
    KVB::LCD::Test KVB::LCD::${controller} kvb_example_platform)
  target_link_options(${target} PRIVATE
    "-T${_ld}"
    --specs=nano.specs
    LINKER:--gc-sections
    LINKER:--no-warn-rwx-segments
    "LINKER:-Map=${CMAKE_CURRENT_BINARY_DIR}/${target}.map"
    LINKER:--print-memory-usage)

  string(REPLACE "objcopy" "size" _size "${CMAKE_OBJCOPY}")
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${target}> ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin
    COMMAND ${_size} $<TARGET_FILE:${target}>
    BYPRODUCTS
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.hex
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin
      ${CMAKE_CURRENT_BINARY_DIR}/${target}.map
    VERBATIM)
endfunction()
