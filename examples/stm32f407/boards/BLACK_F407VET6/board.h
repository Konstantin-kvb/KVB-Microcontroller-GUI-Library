/**
  * @file    board.h
  * @brief   Board configuration: Black STM32F407VET6.
  *
  * The only board-specific part of the STM32F407 example. Pin assignment
  * matches KVB_LCD_16bit_Black_STM32F407VET6.ioc and doc/pinout/BLACK_F407VET6.md.
  */
#ifndef KVB_BOARD_H
#define KVB_BOARD_H

/* Backlight output */
#define BL_PWM_Pin GPIO_PIN_1
#define BL_PWM_GPIO_Port GPIOB

/* FSMC bank wired to the LCD chip select */
#define KVB_BOARD_FSMC_BANK FSMC_NORSRAM_BANK1

/* LCD RS (data/command) line: PD13 FSMC_A18 */
#define KVB_BOARD_FSMC_RS_GPIO_Port GPIOD
#define KVB_BOARD_FSMC_RS_Pin GPIO_PIN_13

/* LCD CS line: PD7 FSMC_NE1 */
#define KVB_BOARD_FSMC_NE_GPIO_Port GPIOD
#define KVB_BOARD_FSMC_NE_Pin GPIO_PIN_7

/* GPIO ports used by the board, in the order CubeMX enables them */
#define KVB_BOARD_GPIO_CLK_ENABLE() \
  do { \
    __HAL_RCC_GPIOH_CLK_ENABLE(); \
    __HAL_RCC_GPIOB_CLK_ENABLE(); \
    __HAL_RCC_GPIOE_CLK_ENABLE(); \
    __HAL_RCC_GPIOD_CLK_ENABLE(); \
    __HAL_RCC_GPIOA_CLK_ENABLE(); \
  } while (0)

#endif /* KVB_BOARD_H */
