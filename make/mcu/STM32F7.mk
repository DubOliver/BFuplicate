#
# F7 Make file include
#

ifeq ($(DEBUG_HARDFAULTS),F7)
CFLAGS               += -DDEBUG_HARDFAULTS
endif

#CMSIS
CMSIS_DIR      := $(ROOT)/lib/main/CMSIS

#STDPERIPH
STDPERIPH_DIR   = $(ROOT)/lib/main/STM32F7/Drivers/STM32F7xx_HAL_Driver
STDPERIPH_SRC   = $(notdir $(wildcard $(STDPERIPH_DIR)/Src/*.c))
EXCLUDES        = stm32f7xx_hal_can.c \
                  stm32f7xx_hal_cec.c \
                  stm32f7xx_hal_crc.c \
                  stm32f7xx_hal_crc_ex.c \
                  stm32f7xx_hal_cryp.c \
                  stm32f7xx_hal_cryp_ex.c \
                  stm32f7xx_hal_dcmi.c \
                  stm32f7xx_hal_dcmi_ex.c \
                  stm32f7xx_hal_dfsdm.c \
                  stm32f7xx_hal_dma2d.c \
                  stm32f7xx_hal_dsi.c \
                  stm32f7xx_hal_eth.c \
                  stm32f7xx_hal_hash.c \
                  stm32f7xx_hal_hash_ex.c \
                  stm32f7xx_hal_hcd.c \
                  stm32f7xx_hal_i2s.c \
                  stm32f7xx_hal_irda.c \
                  stm32f7xx_hal_iwdg.c \
                  stm32f7xx_hal_jpeg.c \
                  stm32f7xx_hal_lptim.c \
                  stm32f7xx_hal_ltdc.c \
                  stm32f7xx_hal_ltdc_ex.c \
                  stm32f7xx_hal_mdios.c \
                  stm32f7xx_hal_mmc.c \
                  stm32f7xx_hal_msp_template.c \
                  stm32f7xx_hal_nand.c \
                  stm32f7xx_hal_nor.c \
                  stm32f7xx_hal_qspi.c \
                  stm32f7xx_hal_rng.c \
                  stm32f7xx_hal_sai.c \
                  stm32f7xx_hal_sai_ex.c \
                  stm32f7xx_hal_sd.c \
                  stm32f7xx_hal_sdram.c \
                  stm32f7xx_hal_smartcard.c \
                  stm32f7xx_hal_smartcard_ex.c \
                  stm32f7xx_hal_smbus.c \
                  stm32f7xx_hal_spdifrx.c \
                  stm32f7xx_hal_sram.c \
                  stm32f7xx_hal_timebase_rtc_alarm_template.c \
                  stm32f7xx_hal_timebase_rtc_wakeup_template.c \
                  stm32f7xx_hal_timebase_tim_template.c \
                  stm32f7xx_hal_wwdg.c \
                  stm32f7xx_ll_adc.c \
                  stm32f7xx_ll_crc.c \
                  stm32f7xx_ll_dac.c \
                  stm32f7xx_ll_exti.c \
                  stm32f7xx_ll_fmc.c \
                  stm32f7xx_ll_i2c.c \
                  stm32f7xx_ll_lptim.c \
                  stm32f7xx_ll_pwr.c \
                  stm32f7xx_ll_rng.c \
                  stm32f7xx_ll_rtc.c \
                  stm32f7xx_ll_sdmmc.c \
                  stm32f7xx_ll_usart.c

STDPERIPH_SRC   := $(filter-out ${EXCLUDES}, $(STDPERIPH_SRC))

#USB
USBCORE_DIR = $(ROOT)/lib/main/STM32F7/Middlewares/ST/STM32_USB_Device_Library/Core
USBCORE_SRC = $(notdir $(wildcard $(USBCORE_DIR)/Src/*.c))
EXCLUDES    = usbd_conf_template.c
USBCORE_SRC := $(filter-out ${EXCLUDES}, $(USBCORE_SRC))

USBCDC_DIR = $(ROOT)/lib/main/STM32F7/Middlewares/ST/STM32_USB_Device_Library/Class/CDC
USBCDC_SRC = $(notdir $(wildcard $(USBCDC_DIR)/Src/*.c))
EXCLUDES   = usbd_cdc_if_template.c
USBCDC_SRC := $(filter-out ${EXCLUDES}, $(USBCDC_SRC))

USBHID_DIR = $(ROOT)/lib/main/STM32F7/Middlewares/ST/STM32_USB_Device_Library/Class/HID
USBHID_SRC = $(notdir $(wildcard $(USBHID_DIR)/Src/*.c))

USBMSC_DIR = $(ROOT)/lib/main/STM32F7/Middlewares/ST/STM32_USB_Device_Library/Class/MSC
USBMSC_SRC = $(notdir $(wildcard $(USBMSC_DIR)/Src/*.c))
EXCLUDES   = usbd_msc_storage_template.c
USBMSC_SRC := $(filter-out ${EXCLUDES}, $(USBMSC_SRC))

VPATH := $(VPATH):$(USBCDC_DIR)/Src:$(USBCORE_DIR)/Src:$(USBHID_DIR)/Src:$(USBMSC_DIR)/Src

DEVICE_STDPERIPH_SRC := $(STDPERIPH_SRC) \
                        $(USBCORE_SRC) \
                        $(USBCDC_SRC) \
                        $(USBHID_SRC) \
                        $(USBMSC_SRC)

#CMSIS
VPATH           := $(VPATH):$(CMSIS_DIR)/Include:$(CMSIS_DIR)/Device/ST/STM32F7xx
VPATH           := $(VPATH):$(STDPERIPH_DIR)/Src
CMSIS_SRC       :=
INCLUDE_DIRS    := $(INCLUDE_DIRS) \
                   $(STDPERIPH_DIR)/Inc \
                   $(USBCORE_DIR)/Inc \
                   $(USBCDC_DIR)/Inc \
                   $(USBHID_DIR)/Inc \
                   $(USBMSC_DIR)/Inc \
                   $(CMSIS_DIR)/Core/Include \
                   $(ROOT)/lib/main/STM32F7/Drivers/CMSIS/Device/ST/STM32F7xx/Include \
                   $(ROOT)/src/main/drivers/stm32/vcp_hal

#Flags
ARCH_FLAGS      = -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -fsingle-precision-constant

# Flags that are used in the STM32 libraries
DEVICE_FLAGS    = -DUSE_HAL_DRIVER -DUSE_FULL_LL_DRIVER

ifeq ($(TARGET_MCU),STM32F765xx)
DEVICE_FLAGS   += -DSTM32F765xx
LD_SCRIPT       = $(LINKER_DIR)/stm32_flash_f765.ld
STARTUP_SRC     = startup_stm32f765xx.s
MCU_FLASH_SIZE	:= 2048
else ifeq ($(TARGET_MCU),STM32F745xx)
DEVICE_FLAGS   += -DSTM32F745xx
LD_SCRIPT       = $(LINKER_DIR)/stm32_flash_f74x.ld
STARTUP_SRC     = startup_stm32f745xx.s
MCU_FLASH_SIZE  := 1024
else ifeq ($(TARGET_MCU),STM32F746xx)
DEVICE_FLAGS   += -DSTM32F746xx
LD_SCRIPT       = $(LINKER_DIR)/stm32_flash_f74x.ld
STARTUP_SRC     = startup_stm32f746xx.s
MCU_FLASH_SIZE  := 1024
else ifeq ($(TARGET_MCU),STM32F722xx)
DEVICE_FLAGS   += -DSTM32F722xx
ifndef LD_SCRIPT
LD_SCRIPT       = $(LINKER_DIR)/stm32_flash_f722.ld
endif
STARTUP_SRC     = startup_stm32f722xx.s
MCU_FLASH_SIZE  := 512
# Override the OPTIMISE_SPEED compiler setting to save flash space on these 512KB targets.
# Performance is only slightly affected but around 50 kB of flash are saved.
OPTIMISE_SPEED = -O2
else
$(error Unknown MCU for F7 target)
endif
DEVICE_FLAGS    += -DHSE_VALUE=$(HSE_VALUE) -DSTM32

VCP_SRC = \
            drivers/stm32/vcp_hal/usbd_desc.c \
            drivers/stm32/vcp_hal/usbd_conf_stm32f7xx.c \
            drivers/stm32/vcp_hal/usbd_cdc_hid.c \
            drivers/stm32/vcp_hal/usbd_cdc_interface.c \
            drivers/stm32/serial_usb_vcp.c \
            drivers/usb_io.c

MCU_COMMON_SRC = \
            drivers/accgyro/accgyro_mpu.c \
            drivers/bus_i2c_timing.c \
            drivers/dshot_bitbang_decode.c \
            drivers/pwm_output_dshot_shared.c \
            drivers/stm32/adc_stm32f7xx.c \
            drivers/stm32/audio_stm32f7xx.c \
            drivers/stm32/bus_i2c_hal_init.c \
            drivers/stm32/bus_i2c_hal.c \
            drivers/stm32/bus_spi_ll.c \
            drivers/stm32/debug.c \
            drivers/stm32/dma_stm32f7xx.c \
            drivers/stm32/dshot_bitbang_ll.c \
            drivers/stm32/dshot_bitbang.c \
            drivers/stm32/exti.c \
            drivers/stm32/io_stm32.c \
            drivers/stm32/light_ws2811strip_hal.c \
            drivers/stm32/persistent.c \
            drivers/stm32/pwm_output.c \
            drivers/stm32/pwm_output_dshot_hal.c \
            drivers/stm32/rcc_stm32.c \
            drivers/stm32/sdio_f7xx.c \
            drivers/stm32/serial_uart_hal.c \
            drivers/stm32/serial_uart_stm32f7xx.c \
            drivers/stm32/system_stm32f7xx.c \
            drivers/stm32/timer_hal.c \
            drivers/stm32/timer_stm32f7xx.c \
            drivers/stm32/transponder_ir_io_hal.c \
            startup/system_stm32f7xx.c

MCU_EXCLUDES = \
            drivers/bus_i2c.c

MSC_SRC = \
            drivers/usb_msc_common.c \
            drivers/stm32/usb_msc_f7xx.c \
            msc/usbd_storage.c \
            msc/usbd_storage_emfat.c \
            msc/emfat.c \
            msc/emfat_file.c \
            msc/usbd_storage_sdio.c \
            msc/usbd_storage_sd_spi.c

DSP_LIB := $(ROOT)/lib/main/CMSIS/DSP
DEVICE_FLAGS += -DARM_MATH_MATRIX_CHECK -DARM_MATH_ROUNDING -D__FPU_PRESENT=1 -DUNALIGNED_SUPPORT_DISABLE -DARM_MATH_CM7
