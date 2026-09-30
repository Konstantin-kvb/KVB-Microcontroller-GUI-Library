# KVB_LCD Graphics Library
«📖 Читать описание на русском языке README_RU.md».
## 🌐 Connecting the Library (.lib) to a Project in Keil MDK 5
The LCD graphics library (**.lib**) files are located in the **KVB_LCD** project folder, along with the **GUI** files and demonstration code (**.c** and **.h**).

## 📂 File Structure Overview
* **KVB_LCD.h** – Graphical User Interface (GUI) header.
* **KVB_TEST.h** – Header file containing two demo functions tailored for different screen resolutions.
* **KVB_TEST.c** – Source file implementing the two resolution-dependent demo functions.
* **KVB_TEXT.h** – Header file containing text variables used in the demonstration.
* **KVB_TEXT.c** – Source file containing text variables used in the demonstration.
* **LCD_16bit_Open407_F407VGT6_9325.lib** – Library file for the **ILI9325** LCD panel (**320 x 240** resolution).
* **LCD_16bit_Open407_F407VGT6_9341.lib** – Library file for the **ILI9341** LCD panel (**320 x 240** resolution).
* **LCD_16bit_Open407_F407VGT6_9481.lib** – Library file for the **ILI9481** LCD panel (**480 x 320** resolution).
* **LCD_16bit_Open407_F407VGT6_9486.lib** – Library file for the **ILI9486** LCD panel (**480 x 320** resolution).
* **LCD_16bit_Open407_F407VGT6_8009A.lib** – Library file for the **OTM8009A** LCD panel (**800 x 480** resolution).

## ⚙️ Linker and GUI Configuration Step-by-Step
1. In the left panel of **Keil** (**Project Tree**), open the **KVB_LCD** folder. If a library (** .lib **) for another LCD panel is already connected, remove it by right-clicking the (** .lib **) file and selecting **Remove File 'xxxx.lib'** from the dropdown list. *Note: Make sure only one graphics library is linked in your project at a time.*
2. In the **Project Tree**, right-click the **KVB_LCD** folder and select **Add Existing Files to Group...**
3. In the file selection window, change the "**Files of type**" dropdown at the bottom to **Library file (*.lib; *.a)**.
4. Select your **LCD_16bit_Open407_F407VGT6.lib** file and click **Add**.
5. Keil now knows that this binary file must be linked with the main application code.
6. Open the GUI interface file **KVB_LCD.h**, go to line **120**, and uncomment only the line corresponding to your specific **LCD** panel. This section contains the average **FSMC** bus delay settings, which depend on your panel's hardware revision, wire length, and ribbon cable configuration.
7. Finally, in your project's **main.c** file, uncomment one of the two demo functions depending on your LCD panel resolution: `lcd_Test480x320Landscape()` or `lcd_Test320x240Landscape()`.

During the build process, **Keil MDK 5** will automatically pull the precompiled code from the selected library file.

⚠️ **IMPORTANT!!!** Due to the high-speed data transfer into the **GRAM**, if you are using a ribbon cable, you **MUST** install a **22 pF** reflection-damping capacitor at the very end of the cable, placed as close as possible to the panel connector on the Write Enable (**WE**) signal line.