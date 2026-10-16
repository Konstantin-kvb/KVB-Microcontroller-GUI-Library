# Black STM32F407ZGT6: FSMC LCD header

Board header wiring for the 16-bit FSMC LCD interface (`KVB_LCD_BOARD=BLACK_F407ZGT6`).
Подключение LCD к разъёму FSMC платы Black STM32F407ZGT6.

The panel side of each module is described in [PANELS.md](PANELS.md). The LCD column names the panel signal wired to the header pin.

## STM32F407ZGT6 BLACK FSMC

| LCD | Function | GPIO | MCU pin | Header | Header | MCU pin | GPIO | Function | LCD |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|  |  | GND |  | 1 | 2 | 25 | RST |  | LCD_RST |
|  | FSMC_D15 | PD10 | 79 | 3 | 4 | 78 | PD9 | FSMC_D14 |  |
|  | FSMC_D13 | PD8 | 77 | 5 | 6 | 68 | PE15 | FSMC_D12 |  |
|  | FSMC_D11 | PE14 | 67 | 7 | 8 | 66 | PE13 | FSMC_D10 |  |
|  | FSMC_D9 | PE12 | 65 | 9 | 10 | 64 | PE11 | FSMC_D8 |  |
|  | FSMC_D7 | PE10 | 63 | 11 | 12 | 60 | PE9 | FSMC_D6 |  |
|  | FSMC_D5 | PE8 | 59 | 13 | 14 | 58 | PE7 | FSMC_D4 |  |
|  | FSMC_D3 | PD1 | 115 | 15 | 16 | 114 | PD0 | FSMC_D2 |  |
|  | FSMC_D1 | PD15 | 86 | 17 | 18 | 85 | PD14 | FSMC_D0 |  |
| LCD_RD | FSMC_NOE | PD4 | 118 | 19 | 20 | 119 | PD5 | FSMC_NWE | LCD_WR |
| LCD_RS | FSMC_A6 | PF12 | 50 | 21 | 22 | 127 | PG12 | FSMC_NE4 | LCD_CS |
|  | T_SCK | PB0 | 46 | 23 | 24 | 7 | PC13 | T_CS |  |
|  | T_MOSI | PF11 | 49 | 25 | 26 | 48 | PB2 | T_MISO |  |
| TP_IRQ | T_PEN | PB1 | 47 | 27 | 28 | 76 | PB15 | BL_PWM | LCD_BL |
|  | 5V | NC |  | 29 | 30 |  | GND |  |  |
|  |  | 3V3 |  | 31 | 32 |  | GND |  |  |
