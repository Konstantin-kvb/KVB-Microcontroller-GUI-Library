# Toolchain file for STM32F407 (Cortex-M4F) with Arm Compiler 6 (armclang).
#
#   cmake -B build -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/armclang.cmake ...
#
# With this compiler the KVB::LCD target links the .lib archives built by
# Arm Compiler 6. The examples and tests of this repository support GCC only.
# This file is not covered by the repository's own build checks.

set(CMAKE_SYSTEM_NAME Generic)
# CMake passes CMAKE_SYSTEM_PROCESSOR to armclang as -mcpu.
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)

set(CMAKE_C_COMPILER   armclang)
set(CMAKE_CXX_COMPILER armclang)
set(CMAKE_ASM_COMPILER armclang)

set(CMAKE_C_COMPILER_TARGET   arm-arm-none-eabi)
set(CMAKE_CXX_COMPILER_TARGET arm-arm-none-eabi)
set(CMAKE_ASM_COMPILER_TARGET arm-arm-none-eabi)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(_kvb_fpu_flags "-mfpu=fpv4-sp-d16 -mfloat-abi=hard")
set(CMAKE_C_FLAGS_INIT   "${_kvb_fpu_flags}")
set(CMAKE_CXX_FLAGS_INIT "${_kvb_fpu_flags}")
set(CMAKE_ASM_FLAGS_INIT "${_kvb_fpu_flags}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
