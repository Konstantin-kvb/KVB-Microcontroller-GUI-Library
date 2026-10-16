# Using KVB_LCD in a CMake project

«📖 [Читать на русском языке](CMAKE_RU.md)».

KVB_LCD is a CMake package. Its graphics core is precompiled: every board and display controller has its own static library. CMake picks the right file from two settings, the board and the controller. The application links a single target, `KVB::LCD`.

## Requirements

- CMake 3.21 or newer.
- A compiler for the target MCU:

| Platform | Compiler | Toolchain file in this repository |
|---|---|---|
| STM32F407 | `arm-none-eabi-gcc` | `cmake/toolchains/arm-none-eabi-gcc.cmake` |
| ATmega128 | `avr-gcc` with avr-libc | `cmake/toolchains/avr-gcc.cmake` |
| STM32F407 | `armclang` (Arm Compiler 6) | `cmake/toolchains/armclang.cmake` |

Your own toolchain file works too. For STM32 it must build with `-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard`, because the core uses the hard-float ABI. For AVR it needs `-mmcu=atmega128`.

The ARMClang build has not been tested, because armclang was not available during the CMake migration. With ARMClang, `KVB::LCD` picks the `.lib` archives. Examples and tests build with GCC only.

## Settings

| Variable | Default | Purpose |
|---|---|---|
| `KVB_LCD_BOARD` | `ATMEGA128` with avr-gcc, otherwise required | Board, see the table below |
| `KVB_LCD_CONTROLLER` | `ILI9486` | Display controller |
| `KVB_LCD_HAL_TARGET` | empty | Target holding a static STM32 HAL library. It is linked after the KVB_LCD core |
| `KVB_LCD_BUILD_EXAMPLES` | `ON` when KVB_LCD is the top-level project | Demo firmware `kvb_lcd_demo` |
| `KVB_LCD_BUILD_TESTS` | `ON` when KVB_LCD is the top-level project | Test module and CTest checks |
| `KVB_LCD_INSTALL` | `ON` when KVB_LCD is the top-level project | Install rules and the `find_package` package |

When another project includes KVB_LCD, examples, tests and install rules are off. Pass settings with `-D`, or `set()` them before adding the library.

**Boards:**

| `KVB_LCD_BOARD` | Board | MCU | Pinout |
|---|---|---|---|
| `BLACK_F407VET6` | ST STM32F4XX Black v2.0 1509 | STM32F407VET6 | [BLACK_F407VET6.md](pinout/BLACK_F407VET6.md) |
| `BLACK_F407ZGT6` | ST STM32F4XX Black v3.0 1606 | STM32F407ZGT6 | [BLACK_F407ZGT6.md](pinout/BLACK_F407ZGT6.md) |
| `OPEN407_F407VGT6` | Open407V-D | STM32F407VGT6 | [OPEN407_F407VGT6.md](pinout/OPEN407_F407VGT6.md) |
| `ATMEGA128` | ATmega128, 16 MHz, GPIO ports | ATmega128 | [README.md](../README.md#cross-platform-compatibility) |

**Controllers:** `ILI9325` and `ILI9341` (320×240), `ILI9481` and `ILI9486` (480×320), `OTM8009A` (800×480). Panel connectors are listed in [PANELS.md](pinout/PANELS.md).

**Targets:**

- `KVB::LCD` is the core for the selected board and controller. This is the target the application links.
- `KVB::LCD::<controller>`, for example `KVB::LCD::ILI9341`, is the core for a specific controller on the same board.
- `KVB::LCD::Headers` carries the `KVB_LCD.h` include path and platform flags, without the core.

`KVB::LCD` defines `USE_<controller>`. The FSMC timings in `KVB_LCD.h` depend on it.

## Option 1. Git submodule and add_subdirectory

The library lives inside your repository and is versioned with it.

```bash
git submodule add https://github.com/Konstantin-kvb/KVB-Microcontroller-GUI-Library.git external/KVB_LCD
```

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
set(KVB_LCD_CONTROLLER ILI9341)
add_subdirectory(external/KVB_LCD)

target_link_libraries(app PRIVATE KVB::LCD)
```

The same code works with a plain copy of the library folder.

## Option 2. FetchContent

CMake downloads the library during configuration.

```cmake
include(FetchContent)
FetchContent_Declare(KVB_LCD
  GIT_REPOSITORY https://github.com/Konstantin-kvb/KVB-Microcontroller-GUI-Library.git
  GIT_TAG        main   # use a tag or commit hash for reproducible builds
  GIT_SHALLOW    TRUE)

set(KVB_LCD_BOARD BLACK_F407VET6)
FetchContent_MakeAvailable(KVB_LCD)

target_link_libraries(app PRIVATE KVB::LCD)
```

To use a local checkout instead of downloading, pass its path:

```bash
cmake -B build -DFETCHCONTENT_SOURCE_DIR_KVB_LCD=/path/to/KVB-Microcontroller-GUI-Library
```

## Option 3. CPM.cmake

[CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) wraps FetchContent and caches downloads.

```cmake
include(cmake/CPM.cmake)
CPMAddPackage(
  NAME KVB_LCD
  GITHUB_REPOSITORY Konstantin-kvb/KVB-Microcontroller-GUI-Library
  GIT_TAG main
  OPTIONS "KVB_LCD_BOARD BLACK_F407VET6" "KVB_LCD_CONTROLLER ILI9486")

target_link_libraries(app PRIVATE KVB::LCD)
```

## Option 4. Install and find_package

Install the library once into a shared prefix. The installed package holds the cores for every board, so one install serves all of them.

```bash
cmake --preset black-f407vet6
cmake --install build/black-f407vet6 --prefix /opt/kvb_lcd
```

In the application:

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
find_package(KVB_LCD 1.0 REQUIRED)

target_link_libraries(app PRIVATE KVB::LCD)
```

```bash
cmake -B build -DCMAKE_PREFIX_PATH=/opt/kvb_lcd ...
```

## Option 5. A project generated by STM32CubeMX

STM32CubeMX can generate a CMake project. It builds the HAL in the `stm32cubemx` target, and its toolchain file already has the Cortex-M4F flags. Add KVB_LCD with any option above, for example `add_subdirectory`:

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
set(KVB_LCD_CONTROLLER ILI9486)
add_subdirectory(external/KVB_LCD)

target_link_libraries(${CMAKE_PROJECT_NAME} stm32cubemx KVB::LCD)
```

## What the application must provide

**STM32F407:**

- **HAL.** The core calls `HAL_Delay` and `HAL_GPIO_WritePin`, and `KVB_LCD.h` includes `stm32f4xx_hal.h`. If your HAL is a static library, name its target in `KVB_LCD_HAL_TARGET`. CMake then places the HAL after the core on the linker command line.
- **FSMC.** Configure the FSMC bus before calling `lsd_Display_Init()`. [main.c](../examples/stm32f407/Core/Src/main.c) shows the setup with the timings from `KVB_LCD.h`. The FSMC pins and bank of each board are in [board.h](../examples/stm32f407/boards/).
- **Floating-point printf.** The core prints real numbers with `sprintf`. With GCC the target adds `-u _printf_float`, so newlib-nano works too.

**ATmega128:**

- **String encoding.** The core fonts expect CP1251. The target adds `-fexec-charset=CP1251`, so sources can stay in UTF-8.
- **ABI flags.** The target adds `-funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums`, as in the original Atmel Studio project.
- **Optimization.** `<util/delay.h>` works only with optimization, so build with `MinSizeRel` or `Release`.
- **Clock.** `KVB_LCD.h` defaults `F_CPU` to 16 MHz. Set another clock with `target_compile_definitions(app PRIVATE F_CPU=8000000UL)`.

**ARMClang:**

- The `.lib` archives were built in Keil and already contain startup code and HAL object files. If the application has its own copies of these files, the linker may pick either one. This setup has not been tested.

## Building the examples and tests of this repository

Each board has a preset: `black-f407vet6`, `black-f407zgt6`, `open407-f407vgt6` and `atmega128`.

```bash
cmake --preset black-f407vet6
cmake --build --preset black-f407vet6
ctest --preset black-f407vet6
```

The firmware lands in `build/<preset>/examples/` as `kvb_lcd_demo.elf`, `.hex` and `.bin` (`.hex` and `.eep` for AVR). Change the controller at configure time:

```bash
cmake --preset black-f407vet6 -DKVB_LCD_CONTROLLER=ILI9341
```

The demo picks the test screen by panel resolution. CTest runs two kinds of checks:

- `kvb_lcd.link.<controller>` links the core of every controller of the selected board with the HAL, startup code and the test module;
- `kvb_lcd.header.c` and `kvb_lcd.header.cxx` compile `KVB_LCD.h` on its own in C and C++.

## Repository layout

| Directory | Contents |
|---|---|
| `include/` | `KVB_LCD.h`, shared by STM32 and AVR |
| `lib/<board>/gcc/`, `lib/<board>/armclang/` | Precompiled cores for GCC and Arm Compiler 6 |
| `cmake/` | Library targets, board descriptions, toolchain files |
| `examples/` | Demo firmware for STM32F407 and ATmega128 |
| `tests/` | `KVB_TEST`/`KVB_TEXT` test module and CTest checks |
| `third_party/Drivers/` | STM32 HAL and CMSIS used by the examples |
| `tools/FontEditor/` | Font editor and sample fonts |
| `doc/` | Documentation, pinout, images |
