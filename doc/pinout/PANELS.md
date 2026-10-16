# LCD panel connectors

Pinout of the 16-bit parallel LCD modules supported by KVB_LCD.
Распиновка разъёмов 16-битных LCD-модулей, которые поддерживает KVB_LCD.

Board-side wiring: [Black STM32F407VET6](BLACK_F407VET6.md), [Black STM32F407ZGT6](BLACK_F407ZGT6.md), [Open407V-D STM32F407VGT6](OPEN407_F407VGT6.md).

## ILI9341

| Signal | Pin | Pin | Signal |
|:---:|:---:|:---:|:---:|
| NC | 20 | 40 | NC |
| LED_A | 19 | 39 | NC |
| NC | 18 | 38 | SD_CS |
| LCD_RST | 17 | 37 | SD_DIN |
| F_CS | 16 | 36 | SD_CLK |
| LCD_CS | 15 | 35 | SD_D0 |
| LCD_D15 | 14 | 34 | T_IRQ |
| LCD_D14 | 13 | 33 | T_D0 |
| LCD_D13 | 12 | 32 | NC |
| LCD_D12 | 11 | 31 | T_DIN |
| LCD_D11 | 10 | 30 | T_CS |
| LCD_D10 | 9 | 29 | T_CLK |
| LCD_D9 | 8 | 28 | LCD_D7 |
| LCD_D8 | 7 | 27 | LCD_D6 |
| LCD_RD | 6 | 26 | LCD_D5 |
| LCD_WR | 5 | 25 | LCD_D4 |
| LCD_RS | 4 | 24 | LCD_D3 |
| NC | 3 | 23 | LCD_D2 |
| VCC | 2 | 22 | LCD_D1 |
| GND | 1 | 21 | LCD_D0 |

## ILI9481

| Signal | Pin | Pin | Signal |
|:---:|:---:|:---:|:---:|
| 5v | 1 | 2 | 5v |
| LCD_D9 | 3 | 4 | LCD_D8 |
| LCD_D11 | 5 | 6 | LCD_D10 |
| LCD_D13 | 7 | 8 | LCD_D12 |
| LCD_D15 | 9 | 10 | LCD_D14 |
| LCD_D6 | 11 | 12 | LCD_D7 |
| LCD_D4 | 13 | 14 | LCD_D5 |
| LCD_D2 | 15 | 16 | LCD_D3 |
| LCD_D0 | 17 | 18 | LCD_D1 |
| LCD_WR | 19 | 20 | LCD_RS |
| LCD_RST | 21 | 22 | LCD_CS |
| NC | 23 | 24 | NC |
| FLASH_CS | 25 | 26 | NC |
| NC | 27 | 28 | NC |
| NC | 29 | 30 | NC |
| SPI_MOSI | 31 | 32 | SPI_MISO |
| SD_CS | 33 | 34 | SPI_CLK |
| GND | 35 | 36 | GND |

## ILI9486 / OTM8009A

| Signal | Pin | Pin | Signal |
|:---:|:---:|:---:|:---:|
| LCD_RS | 1 | 2 | LCD_CS |
| LCD_RD | 3 | 4 | LCD_WR |
| LCD_D0 | 5 | 6 | LCD_RST |
| LCD_D2 | 7 | 8 | LCD_D1 |
| LCD_D4 | 9 | 10 | LCD_D3 |
| LCD_D6 | 11 | 12 | LCD_D5 |
| LCD_D8 | 13 | 14 | LCD_D7 |
| LCD_D10 | 15 | 16 | LCD_D9 |
| LCD_D12 | 17 | 18 | LCD_D11 |
| LCD_D14 | 19 | 20 | LCD_D13 |
| SDCS | 21 | 22 | LCD_D15 |
| VDD | 23 | 24 | LCD_BL |
| GND | 25 | 26 | VDD |
| 5V | 27 | 28 | GND |
| MOSI | 29 | 30 | MISO |
| F_CS | 31 | 32 | PEN |
| CLK | 33 | 34 | T_CS |
