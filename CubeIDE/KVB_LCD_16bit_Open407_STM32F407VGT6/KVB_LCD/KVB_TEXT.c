/**
  * @file    KVB_TEXT.c
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
//###########################################################################################
//									Подключаемые файлы
//###########################################################################################
#include "KVB_TEXT.h"
//###########################################################################################
//###########################################################################################
//								Текст подключаемых строк
//###########################################################################################
const char str_KVB_en[] KVBMEM = "0123";
const char str_fio_en[] KVBMEM = "Boruzdov Konstantin Vladimirovich";
const char str_fio_ru[] KVBMEM = "Боруздов Константин Владимирович";
const char str_prezent_ru[] KVBMEM = "Представляет, графическую библиотеку KVB №1.0, написанную исключительно в целочисленной математике на языке <C> в <GCC>";
const char str_tel_ru[] KVBMEM = "Боруздов Константин\nтел. +7 965-363-45-29";
const char str_test1a_ru[] KVBMEM = "Перенос по словам";
const char str_test1b_ru[] KVBMEM = "Текст с тенью";
const char str_test1_ru[] KVBMEM = " Съешь ещё этих мягких французских булок, да выпей же чаю.";
const char str_test2_ru[] KVBMEM = " Выводим в строке вещественное число с добавлением нулей. ";
const char str_button1_ru[] KVBMEM = "ВВЕРХ";
const char str_button2_ru[] KVBMEM = "ВИДЕО";
const char str_button3_ru[] KVBMEM = "НАЗАД";
const char str_button4_ru[] KVBMEM = "СБРОС";
const char str_button5_ru[] KVBMEM = "ВНИЗ";
const char str_button6_ru[] KVBMEM = "СТАРТ";
const char str_button7_ru[] KVBMEM = "ЗВУКИ";
const char str_button8_ru[] KVBMEM = "АУДИО";
const char str_LCD_en[] KVBMEM = "KVB-16bit-LCD\nSTM32F407VGT6";
const char str_IDE_en[] KVBMEM = "Stm32CubeIDE 2";
const char str_nu1[] KVBMEM = "1";
const char str_nu2[] KVBMEM = "2";
const char str_nu3[] KVBMEM = "3";
const char str_nu4[] KVBMEM = "4";
const char str_nu5[] KVBMEM = "5";
const char str_nu6[] KVBMEM = "6";
const char str_nu7[] KVBMEM = "7";
const char str_nu8[] KVBMEM = "8";
const char str_nu9[] KVBMEM = "9";
const char str_nu0[] KVBMEM = "0";
const char str_nu10[] KVBMEM = "#";
const char str_nu11[] KVBMEM = "*";

const char str_font_sym1[] KVBMEM = " !\"#$%&'()*+,-./№0123456789";
const char str_font_sym2[] KVBMEM = ":;<=>?@ABCDEFGHIJKLMNOPQRST";
const char str_font_sym3[] KVBMEM = "UVWXYZ[\\]^_`abcdefghijklmno";
const char str_font_sym4[] KVBMEM = "pqrstuvwxyz{|}~АБВГДЕЁЖЗИЙК";
const char str_font_sym5[] KVBMEM = "ЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгде";
const char str_font_sym6[] KVBMEM = "ёжзийклмнопрстуфхцчшщъыьэюя";

const char str_font_sym[] KVBMEM = " !\"#$%&'()*+,-./№0123456789\n:;<=>?@ABCDEFGHIJKLMNOPQRST\nUVWXYZ[\\]^_`abcdefghijklmno\npqrstuvwxyz{|}~АБВГДЕЁЖЗИЙК\nЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгде\nёжзийклмнопрстуфхцчшщъыьэюя";
//const char str_font_sym[] KVBMEM = " !\"#$%&'()*+,-./№0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя";
//###########################################################################################

