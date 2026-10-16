# Open407V-D STM32F407VGT6: FSMC LCD header

Board header wiring for the 16-bit FSMC LCD interface (`KVB_LCD_BOARD=OPEN407_F407VGT6`).
Подключение LCD к разъёму FSMC платы Open407V-D STM32F407VGT6.

The panel side of each module is described in [PANELS.md](PANELS.md). The LCD column names the panel signal wired to the header pin.

## Open407V-D LCD

| LCD | Function | GPIO | Header | Header | GPIO | Function | LCD |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|  | 5V |  | 1 | 2 |  | GND |  |
|  | FSMC_D0 | PD14 | 3 | 4 | PD15 | FSMC_D1 |  |
|  | FSMC_D2 | PD0 | 5 | 6 | PD1 | FSMC_D3 |  |
|  | FSMC_D4 | PE7 | 7 | 8 | PE8 | FSMC_D5 |  |
|  | FSMC_D6 | PE9 | 9 | 10 | PE10 | FSMC_D7 |  |
|  | FSMC_D8 | PE11 | 11 | 12 | PE12 | FSMC_D9 |  |
|  | FSMC_D10 | PE13 | 13 | 14 | PE14 | FSMC_D11 |  |
|  | FSMC_D12 | PE15 | 15 | 16 | PD8 | FSMC_D13 |  |
|  | FSMC_D14 | PD9 | 17 | 18 | PD10 | FSMC_D15 |  |
| LCD_CS | FSMC_NE1 | PD7 | 19 | 20 | PD11 | FSMC_A16 | LCD_RS |
| LCD_WR | FSMC_NWE | PD5 | 21 | 22 | PD4 | FSMC_NOE | LCD_RD |
| LCD_RST |  | RST | 23 | 24 |  | NC |  |
|  | 3.3V |  | 25 | 26 |  | GND |  |
| LCD_BL | BL_PWM | PB0 | 27 | 28 | PC5 | LCDTP_IRQ |  |
|  | LCDTP_CS | PC4 | 29 | 30 | PB13 | LCDTP_CLK |  |
|  | LCDTP_DIN | PB15 | 31 | 32 | PB14 | LCDTP_DOUT |  |
|  | 3.3V |  | 33 | 34 |  | GND |  |
