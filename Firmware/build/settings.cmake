set (CWARN "-Wall -Wstrict-prototypes -Wextra")
set (CXXWARN "-Wall -Wextra -Werror")
set(CTUNING "-fomit-frame-pointer -ffunction-sections -fdata-sections")
set(CMCU "-mcpu=cortex-m3 -mthumb -mfloat-abi=soft")

set(RANDOM_DEFS "-DUSE_HAL_DRIVER -DSTM32F103xB")

set(CMAKE_C_FLAGS "-std=gnu11 -O2 ${CWARN} ${CTUNING} ${CMCU} ${RANDOM_DEFS}")
set(CMAKE_CXX_FLAGS "-std=gnu++1z -O2 -fno-exceptions -fno-rtti ${CXXWARN} ${CTUNING} ${CMCU} ${RANDOM_DEFS}")
set(CMAKE_CXX_STANDARD 14)

set(DEVICE STM32F103C8)