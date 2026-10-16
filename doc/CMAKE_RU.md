# Подключение KVB_LCD к проекту CMake

«📖 [Read in English](CMAKE.md)».

Библиотека KVB_LCD поставляется как пакет CMake. Её графическое ядро уже скомпилировано: для каждой платы и каждого контроллера дисплея есть своя статическая библиотека. CMake подбирает нужный файл по двум настройкам, плате и контроллеру. Приложение линкуется с одной целью `KVB::LCD`.

## Требования

- CMake 3.21 или новее.
- Компилятор под целевой микроконтроллер:

| Платформа | Компилятор | Toolchain-файл из репозитория |
|---|---|---|
| STM32F407 | `arm-none-eabi-gcc` | `cmake/toolchains/arm-none-eabi-gcc.cmake` |
| ATmega128 | `avr-gcc` и avr-libc | `cmake/toolchains/avr-gcc.cmake` |
| STM32F407 | `armclang` (Arm Compiler 6) | `cmake/toolchains/armclang.cmake` |

Свой toolchain-файл тоже подходит. Для STM32 он должен собирать код с флагами `-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard`, потому что ядро собрано под hard-float ABI. Для AVR нужен флаг `-mmcu=atmega128`.

Сборка под ARMClang не проверялась: при переводе на CMake компилятора armclang не было. Цель `KVB::LCD` в этом случае выбирает архивы `.lib`. Примеры и тесты собираются только GCC.

## Настройки

| Переменная | По умолчанию | Назначение |
|---|---|---|
| `KVB_LCD_BOARD` | `ATMEGA128` для avr-gcc, иначе нужно задать | Плата, см. таблицу ниже |
| `KVB_LCD_CONTROLLER` | `ILI9486` | Контроллер дисплея |
| `KVB_LCD_HAL_TARGET` | пусто | Цель со статической библиотекой STM32 HAL. Она линкуется после ядра KVB_LCD |
| `KVB_LCD_BUILD_EXAMPLES` | `ON`, если KVB_LCD — проект верхнего уровня | Демо-прошивка `kvb_lcd_demo` |
| `KVB_LCD_BUILD_TESTS` | `ON`, если KVB_LCD — проект верхнего уровня | Тестовый модуль и проверки CTest |
| `KVB_LCD_INSTALL` | `ON`, если KVB_LCD — проект верхнего уровня | Правила установки и пакет для `find_package` |

Когда KVB_LCD подключена к другому проекту, примеры, тесты и установка выключены. Настройки можно передать через `-D` или задать через `set()` до подключения библиотеки.

**Платы:**

| `KVB_LCD_BOARD` | Плата | MCU | Распиновка |
|---|---|---|---|
| `BLACK_F407VET6` | ST STM32F4XX Black v2.0 1509 | STM32F407VET6 | [BLACK_F407VET6.md](pinout/BLACK_F407VET6.md) |
| `BLACK_F407ZGT6` | ST STM32F4XX Black v3.0 1606 | STM32F407ZGT6 | [BLACK_F407ZGT6.md](pinout/BLACK_F407ZGT6.md) |
| `OPEN407_F407VGT6` | Open407V-D | STM32F407VGT6 | [OPEN407_F407VGT6.md](pinout/OPEN407_F407VGT6.md) |
| `ATMEGA128` | ATmega128, 16 МГц, порты GPIO | ATmega128 | [README_RU.md](../README_RU.md#кроссплатформенность) |

**Контроллеры:** `ILI9325` и `ILI9341` (320×240), `ILI9481` и `ILI9486` (480×320), `OTM8009A` (800×480). Распиновка панелей описана в [PANELS.md](pinout/PANELS.md).

**Цели:**

- `KVB::LCD` — ядро для выбранных платы и контроллера. Именно эту цель линкует приложение.
- `KVB::LCD::<контроллер>`, например `KVB::LCD::ILI9341`, — ядро конкретного контроллера той же платы.
- `KVB::LCD::Headers` — только путь к `KVB_LCD.h` и платформенные флаги, без ядра.

Цель `KVB::LCD` определяет макрос `USE_<контроллер>`. От него зависят тайминги FSMC в `KVB_LCD.h`.

## Способ 1. Git submodule и add_subdirectory

Библиотека лежит внутри вашего репозитория и обновляется вместе с ним.

```bash
git submodule add https://github.com/Konstantin-kvb/KVB-Microcontroller-GUI-Library.git external/KVB_LCD
```

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
set(KVB_LCD_CONTROLLER ILI9341)
add_subdirectory(external/KVB_LCD)

target_link_libraries(app PRIVATE KVB::LCD)
```

Тот же код работает, если скопировать папку библиотеки в проект без git.

## Способ 2. FetchContent

CMake сам скачивает библиотеку при конфигурации.

```cmake
include(FetchContent)
FetchContent_Declare(KVB_LCD
  GIT_REPOSITORY https://github.com/Konstantin-kvb/KVB-Microcontroller-GUI-Library.git
  GIT_TAG        main   # для воспроизводимой сборки укажите тег или хеш коммита
  GIT_SHALLOW    TRUE)

set(KVB_LCD_BOARD BLACK_F407VET6)
FetchContent_MakeAvailable(KVB_LCD)

target_link_libraries(app PRIVATE KVB::LCD)
```

Чтобы взять локальную копию вместо скачивания, передайте путь к ней:

```bash
cmake -B build -DFETCHCONTENT_SOURCE_DIR_KVB_LCD=/path/to/KVB-Microcontroller-GUI-Library
```

## Способ 3. CPM.cmake

[CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) — обёртка над FetchContent с кешем загрузок.

```cmake
include(cmake/CPM.cmake)
CPMAddPackage(
  NAME KVB_LCD
  GITHUB_REPOSITORY Konstantin-kvb/KVB-Microcontroller-GUI-Library
  GIT_TAG main
  OPTIONS "KVB_LCD_BOARD BLACK_F407VET6" "KVB_LCD_CONTROLLER ILI9486")

target_link_libraries(app PRIVATE KVB::LCD)
```

## Способ 4. Установка и find_package

Библиотека устанавливается один раз в общий каталог. Установленный пакет содержит ядра для всех плат, поэтому подходит для любой из них.

```bash
cmake --preset black-f407vet6
cmake --install build/black-f407vet6 --prefix /opt/kvb_lcd
```

В приложении:

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
find_package(KVB_LCD 1.0 REQUIRED)

target_link_libraries(app PRIVATE KVB::LCD)
```

```bash
cmake -B build -DCMAKE_PREFIX_PATH=/opt/kvb_lcd ...
```

## Способ 5. Проект, сгенерированный STM32CubeMX

STM32CubeMX умеет создавать проект CMake. HAL в нём собран в цели `stm32cubemx`, а toolchain-файл уже содержит нужные флаги Cortex-M4F. KVB_LCD подключается любым способом выше, например через `add_subdirectory`:

```cmake
set(KVB_LCD_BOARD BLACK_F407VET6)
set(KVB_LCD_CONTROLLER ILI9486)
add_subdirectory(external/KVB_LCD)

target_link_libraries(${CMAKE_PROJECT_NAME} stm32cubemx KVB::LCD)
```

## Что должно быть в приложении

**STM32F407:**

- **HAL.** Ядро вызывает `HAL_Delay` и `HAL_GPIO_WritePin`, а `KVB_LCD.h` подключает `stm32f4xx_hal.h`. Если HAL собран как статическая библиотека, укажите её цель в `KVB_LCD_HAL_TARGET`. Тогда CMake поставит HAL после ядра в командной строке компоновщика.
- **FSMC.** Шина FSMC должна быть настроена до вызова `lsd_Display_Init()`. Пример настройки с таймингами из `KVB_LCD.h` есть в [main.c](../examples/stm32f407/Core/Src/main.c). Пины и банк FSMC каждой платы перечислены в [board.h](../examples/stm32f407/boards/).
- **printf с плавающей точкой.** Ядро печатает вещественные числа через `sprintf`. Для GCC цель добавляет `-u _printf_float`, поэтому newlib-nano тоже работает.

**ATmega128:**

- **Кодировка строк.** Шрифты ядра рассчитаны на CP1251. Цель добавляет `-fexec-charset=CP1251`, поэтому исходники можно хранить в UTF-8.
- **Флаги ABI.** Цель добавляет `-funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums`, как в исходном проекте Atmel Studio.
- **Оптимизация.** Функции `<util/delay.h>` работают только с оптимизацией, поэтому собирайте с `MinSizeRel` или `Release`.
- **Частота.** `KVB_LCD.h` по умолчанию задаёт `F_CPU` равной 16 МГц. Другую частоту задайте через `target_compile_definitions(app PRIVATE F_CPU=8000000UL)`.

**ARMClang:**

- Архивы `.lib` собраны в Keil и уже содержат startup-код и объектные файлы HAL. Если в приложении есть свои копии этих файлов, компоновщик может выбрать любую из них. Этот вариант не проверялся.

## Сборка примеров и тестов этого репозитория

Для каждой платы есть пресет: `black-f407vet6`, `black-f407zgt6`, `open407-f407vgt6` и `atmega128`.

```bash
cmake --preset black-f407vet6
cmake --build --preset black-f407vet6
ctest --preset black-f407vet6
```

Прошивка появится в `build/<пресет>/examples/` в виде файлов `kvb_lcd_demo.elf`, `.hex` и `.bin` (для AVR `.hex` и `.eep`). Контроллер меняется при конфигурации:

```bash
cmake --preset black-f407vet6 -DKVB_LCD_CONTROLLER=ILI9341
```

Демо-прошивка сама выбирает тест по разрешению панели. CTest проверяет две вещи:

- `kvb_lcd.link.<контроллер>` — ядро каждого контроллера выбранной платы линкуется с HAL, startup-кодом и тестовым модулем;
- `kvb_lcd.header.c` и `kvb_lcd.header.cxx` — `KVB_LCD.h` компилируется сам по себе в C и C++.

## Структура репозитория

| Каталог | Содержимое |
|---|---|
| `include/` | `KVB_LCD.h`, общий для STM32 и AVR |
| `lib/<плата>/gcc/`, `lib/<плата>/armclang/` | Прекомпилированные ядра для GCC и Arm Compiler 6 |
| `cmake/` | Цели библиотеки, описания плат, toolchain-файлы |
| `examples/` | Демо-прошивки для STM32F407 и ATmega128 |
| `tests/` | Тестовый модуль `KVB_TEST`/`KVB_TEXT` и проверки CTest |
| `third_party/Drivers/` | STM32 HAL и CMSIS для примеров |
| `tools/FontEditor/` | Редактор шрифтов и примеры шрифтов |
| `doc/` | Документация, распиновка, изображения |
