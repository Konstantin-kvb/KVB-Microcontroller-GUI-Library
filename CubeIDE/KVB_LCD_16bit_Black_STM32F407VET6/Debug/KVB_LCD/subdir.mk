################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (14.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../KVB_LCD/KVB_TEST.c \
../KVB_LCD/KVB_TEXT.c 

OBJS += \
./KVB_LCD/KVB_TEST.o \
./KVB_LCD/KVB_TEXT.o 

C_DEPS += \
./KVB_LCD/KVB_TEST.d \
./KVB_LCD/KVB_TEXT.d 


# Each subdirectory must supply rules for building sources it contributes
KVB_LCD/%.o KVB_LCD/%.su KVB_LCD/%.cyclo: ../KVB_LCD/%.c KVB_LCD/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F407xx -c -I../Core/Inc -I"D:/KVB_LCD/Free/CubeIDE/CODE_LIB/KVB_LCD_16bit_Black_STM32F407VET6/KVB_LCD" -I../Drivers/STM32F4xx_HAL_Driver/Inc -I../Drivers/STM32F4xx_HAL_Driver/Inc/Legacy -I../Drivers/CMSIS/Device/ST/STM32F4xx/Include -I../Drivers/CMSIS/Include -O3 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-KVB_LCD

clean-KVB_LCD:
	-$(RM) ./KVB_LCD/KVB_TEST.cyclo ./KVB_LCD/KVB_TEST.d ./KVB_LCD/KVB_TEST.o ./KVB_LCD/KVB_TEST.su ./KVB_LCD/KVB_TEXT.cyclo ./KVB_LCD/KVB_TEXT.d ./KVB_LCD/KVB_TEXT.o ./KVB_LCD/KVB_TEXT.su

.PHONY: clean-KVB_LCD

