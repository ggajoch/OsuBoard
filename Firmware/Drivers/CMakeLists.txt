set(NAME Drivers)

file(GLOB_RECURSE SOURCES
	*.c
	*.h
	*.s
)

add_library(${NAME} ${SOURCES})


target_include_directories(${NAME} PUBLIC
	"${CMAKE_CURRENT_SOURCE_DIR}/STM32F1xx_HAL_Driver/Inc"
	"${CMAKE_CURRENT_SOURCE_DIR}/CMSIS/Device/ST/STM32F1xx/Include"
	"${CMAKE_CURRENT_SOURCE_DIR}/CMSIS/Include"
	"${CMAKE_CURRENT_SOURCE_DIR}/../Inc"
)
