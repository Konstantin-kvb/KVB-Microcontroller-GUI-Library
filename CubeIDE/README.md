# KVB_LCD Graphics Library
«📖 [Читать описание на русском языке](README_RU.md)».
## 🌐 Connecting the Library (.a) to a Project in STM32CubeIDE
The LCD graphics library (**.a**) files are located in the **KVB_LCD** project folder, along with the **GUI** files and demonstration code (**.c** and **.h**).

## 📂 File Structure Overview
* **KVB_LCD.h** – Graphical User Interface (GUI) header.
* **KVB_TEST.h** – Header file containing two demo functions tailored for different screen resolutions.
* **KVB_TEST.c** – Source file implementing the two resolution-dependent demo functions.
* **KVB_TEXT.h** – Header file containing text variables used in the demonstration.
* **KVB_TEXT.c** – Source file containing text variables used in the demonstration.
* **libLCD_16bit_Open407_F407VGT6_9325.a** – Library file for the **ILI9325** LCD panel (**320 x 240** resolution).
* **libLCD_16bit_Open407_F407VGT6_9341.a** – Library file for the **ILI9341** LCD panel (**320 x 240** resolution).
* **libLCD_16bit_Open407_F407VGT6_9481.a** – Library file for the **ILI9481** LCD panel (**480 x 320** resolution).
* **libLCD_16bit_Open407_F407VGT6_9486.a** – Library file for the **ILI9486** LCD panel (**480 x 320** resolution).
* **libLCD_16bit_Open407_F407VGT6_8009A.a** – Library file for the **OTM8009A** LCD panel (**800 x 480** resolution).

## ⚙️ Linker and GUI Configuration Step-by-Step
1. Right-click on your project root folder -> **Properties -> C/C++ Build -> Settings ->** open the **Tool Settings** tab.
2. Scroll down to the **MCU GCC Linker** section and click on the **Libraries** sub-item.
3. You will see two panels: **Libraries (-l)** (top window) and **Library search path (-L)** (bottom window).
4. In the bottom window **(Library search path -L)**, add the path to the folder where your `libLCD_16bit_Open407_F407VGT6_9486.a` file is physically located.
5. In the top window **(Libraries -l)**, add your library name. **CRITICAL:** Enter it **WITHOUT** the **lib** prefix and **WITHOUT** the **.a** extension (e.g., type exactly: **LCD_16bit_Open407_F407VGT6_9486**). 
   * *Note: Make sure only one graphics library is linked in your project at a time.*
6. Click **Apply and Close**.

![Library Setup](lib407Cube.png)

7. Open the GUI interface file **KVB_LCD.h**, go to line **120**, and uncomment only the line corresponding to your specific **LCD** panel. This section contains the average **FSMC** bus delay settings, which depend on your panel's hardware revision, wire length, and ribbon cable configuration.
8. Finally, in your project's **main.c** file, uncomment one of the two demo functions depending on your LCD panel resolution: `lcd_Test480x320Landscape()` or `lcd_Test320x240Landscape()`.

During the build process, **STM32CubeIDE** will automatically pull the precompiled code from the selected library file.

⚠️ **IMPORTANT!!!** Due to the high-speed data transfer into the **GRAM**, if you are using a ribbon cable, you **MUST** install a **22 pF** reflection-damping capacitor at the very end of the cable, placed as close as possible to the panel connector on the Write Enable (**WE**) signal line.