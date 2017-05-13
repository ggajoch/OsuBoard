cmake_minimum_required(VERSION 3.1)

set(NAME OsuBoard)

include(build/functions.cmake)
include(build/toolchain.cmake)
project(${NAME} C CXX ASM)
include(build/settings.cmake)

message(STATUS "Using ${CC} compiler from ${CMAKE_C_COMPILER}")

add_subdirectory(Drivers)
add_subdirectory(Middlewares)

file(GLOB_RECURSE SOURCES
	Src/*.c
	Src/*.h
	startup/*.s
)

include_directories(
	"Inc"
)

add_executable(${NAME} ${SOURCES})

set_target_properties(${NAME} PROPERTIES LINK_FLAGS "-T${CMAKE_CURRENT_LIST_DIR}/STM32F103C8Tx_FLASH.ld -Wl,--gc-sections --specs=nosys.specs -lc -lnosys")

target_link_libraries(${NAME}
	Drivers
	Middlewares
)

target_generate_hex(${NAME})
target_jlink_flash(${NAME})

target_memory_report(${NAME})
target_asm_listing(${NAME})
