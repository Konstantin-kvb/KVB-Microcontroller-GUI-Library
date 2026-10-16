# Black STM32F407VET6: FSMC LCD header

Board header wiring for the 16-bit FSMC LCD interface (`KVB_LCD_BOARD=BLACK_F407VET6`).
Подключение LCD к разъёму FSMC платы Black STM32F407VET6.

The panel side of each module is described in [PANELS.md](PANELS.md). The LCD column names the panel signal wired to the header pin.

## STM32F407VET6 BLACK FSMC

| LCD | Function | GPIO | Header | Header | GPIO | Function | LCD |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|  |  | GND | 1 | 2 | RST |  | LCD_RST |
|  | FSMC_D15 | PD10 | 3 | 4 | PD9 | FSMC_D14 |  |
|  | FSMC_D13 | PD8 | 5 | 6 | PE15 | FSMC_D12 |  |
|  | FSMC_D11 | PE14 | 7 | 8 | PE13 | FSMC_D10 |  |
|  | FSMC_D9 | PE12 | 9 | 10 | PE11 | FSMC_D8 |  |
|  | FSMC_D7 | PE10 | 11 | 12 | PE9 | FSMC_D6 |  |
|  | FSMC_D5 | PE8 | 13 | 14 | PE7 | FSMC_D4 |  |
|  | FSMC_D3 | PD1 | 15 | 16 | PD0 | FSMC_D2 |  |
|  | FSMC_D1 | PD15 | 17 | 18 | PD14 | FSMC_D0 |  |
| LCD_RD | FSMC_NOE | PD4 | 19 | 20 | PD5 | FSMC_NWE | LCD_WR |
| LCD_RS | FSMC_A18 | PD13 | 21 | 22 | PD7 | FSMC_NE1 | LCD_CS |
|  | T_SCK | PB13 | 23 | 24 | PB12 | T_CS |  |
|  | T_MOSI | PB15 | 25 | 26 | PB14 | T_MISO |  |
| TP_IRQ | T_PEN | PC5 | 27 | 28 | PB1 | BL_PWM |  |
|  |  | NC | 29 | 30 | GND |  |  |
|  |  | 3V3 | 31 | 32 | GND |  |  |
