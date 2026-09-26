/**
  * @file    KVB_TEST.h
  * @author  Boruzdov Konstantin
  * @version V1.0
  * @date    17-05-2026
  * @brief Cross-platform graphics library for ATmega128 and STM32F407
  * 
  * Copyright (C) 2026 [Boruzdov Konstantin / KVB]. All rights reserved.
  * 
  * Licensed under the Creative Commons Attribution-NonCommercial 4.0 
  * International License (CC BY-NC 4.0).
  * 
  * YOU MAY NOT USE THIS FILE FOR COMMERCIAL PURPOSES. КОММЕРЧЕСКОЕ ИСПОЛЬЗОВАНИЕ ЗАПРЕЩЕНО.
  * For commercial licensing licensing inquiries, please contact: email kboruzdov@mail.ru tel +7 965-363-45-29
  * 
  * Полный текст лицензии: https://creativecommons.org
  */
#ifndef KVB_TEST_H_
#define KVB_TEST_H_
//###########################################################################################
//									Подключаемые файлы
//###########################################################################################
#include <math.h>
//===========================================================================================
#include "KVB_LCD.h"
#include "KVB_TEXT.h"
//###########################################################################################
#ifdef __cplusplus
extern "C" {
	#endif
//###########################################################################################
//			Функция тестирования LCD панели с разрешением 480x320 горизонтальная
//###########################################################################################
void lcd_Test480x320Landscape(void);
//###########################################################################################
//###########################################################################################
//			Функция тестирования LCD панели с разрешением 320x240 горизонтальная
//###########################################################################################
void lcd_Test320x240Landscape(void);
//###########################################################################################
#ifdef __cplusplus
}
#endif

#endif /* KVB_TEST_H_ */