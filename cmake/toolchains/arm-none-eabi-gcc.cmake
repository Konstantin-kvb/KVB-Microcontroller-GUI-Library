# Toolchain file for STM32F407 (Cortex-M4F) with the GNU Arm Embedded toolchain.
#
#   cmake -B build -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/arm-none-eabi-gcc.cmake ...
#
# The prebuilt KVB_LCD libraries use the hard-float ABI, so every object in the
# firmware must be built with the same CPU and FPU flags.

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(KVB_TOOLCHAIN_PREFIX "arm-none-eabi-" CACHE STRING "Prefix of the GNU Arm toolchain executables")

set(CMAKE_C_COMPILER   ${KVB_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${KVB_TOOLCHAIN_PREFIX}g++)
set(CMAKE_ASM_COMPILER ${KVB_TOOLCHAIN_PREFIX}gcc)

# Cross compiler cannot link a hosted test program.
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(_kvb_cpu_flags "-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")
set(CMAKE_C_FLAGS_INIT   "${_kvb_cpu_flags}")
set(CMAKE_CXX_FLAGS_INIT "${_kvb_cpu_flags}")
set(CMAKE_ASM_FLAGS_INIT "${_kvb_cpu_flags} -x assembler-with-cpp")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${_kvb_cpu_flags}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
