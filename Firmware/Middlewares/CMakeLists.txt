set(NAME Middlewares)

file(GLOB_RECURSE SOURCES
	*.c
	*.h
	*.s
)

add_library(${NAME} ${SOURCES})

target_link_libraries(${NAME}
	Drivers
)


target_include_directories(${NAME} PUBLIC
	"${CMAKE_CURRENT_SOURCE_DIR}/ST/STM32_USB_Device_Library/Class/HID/Inc"
	"${CMAKE_CURRENT_SOURCE_DIR}/ST/STM32_USB_Device_Library/Core/Inc"
	"${CMAKE_CURRENT_SOURCE_DIR}/../Inc"
)
