# KVB_LCD Graphics Library
«📖 [Читать описание на русском языке](README_RU.md)».
## 🌐 Connecting the Library (.a) to a Project in Atmel Studio 7.0
The LCD graphics library (**.a**) files are located in the **KVB_LCD** project folder, along with the **GUI** files and demonstration code (**.c** and **.h**).

## 📂 File Structure Overview
* **KVB_LCD.h** – Graphical User Interface (GUI) header.
* **KVB_TEST.h** – Header file containing two demo functions tailored for different screen resolutions.
* **KVB_TEST.c** – Source file implementing the two resolution-dependent demo functions.
* **KVB_TEXT.h** – Header file containing text variables used in the demonstration.
* **KVB_TEXT.c** – Source file containing text variables used in the demonstration.
* **libKVB_LCD_16bit_ATmega128_9325.a** – Library file for the **ILI9325** LCD panel (**320 x 240** resolution).
* **libKVB_LCD_16bit_ATmega128_9341.a** – Library file for the **ILI9341** LCD panel (**320 x 240** resolution).
* **libKVB_LCD_16bit_ATmega128_9481.a** – Library file for the **ILI9481** LCD panel (**480 x 320** resolution).
* **libKVB_LCD_16bit_ATmega128_9486.a** – Library file for the **ILI9486** LCD panel (**480 x 320** resolution).
* **libKVB_LCD_16bit_ATmega128_8009A.a** – Library file for the **OTM8009A** LCD panel (**800 x 480** resolution).

## ⚙️ Linker Configuration Step-by-Step
1. Open your target project's **Properties** (Press **Alt + F7**).
2. Navigate to **Toolchain -> AVR/GNU Linker -> Libraries**.
3. In the top window (**Libraries (-Wl,-l)**), click the **+** (Add Item) button. Enter the library name **without** the **lib** prefix and the **.a** extension. For example, if your file is named `libKVB_LCD_16bit_ATmega128_9481.a`, type exactly: **KVB_LCD_16bit_ATmega128_9481**. 
   * *Note: Make sure only one graphics library is linked in your project at a time.*
4. In the bottom window (**Library search path (-L)**), click the **+** button and specify the path to the folder where the `libKVB_LCD_16bit_ATmega128_9481.a` file is physically located.

![Library Setup](Lib_mega128.png)

During the build process, **Atmel Studio 7.0** will automatically pull the precompiled code from the selected library file.

5. Finally, in your project's **main.c** file, uncomment one of the two demo functions depending on your LCD panel resolution: `lcd_Test480x320Landscape()` or `lcd_Test320x240Landscape()`.