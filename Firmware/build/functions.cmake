function(target_generate_hex TARGET)
  set (EXEC_OBJ ${CMAKE_CURRENT_BINARY_DIR}/${TARGET})
  set (HEX_OBJ ${EXEC_OBJ}.hex)

  set_target_properties(${TARGET} PROPERTIES HEX_FILE ${HEX_OBJ})

  add_custom_command(OUTPUT ${HEX_OBJ}
      COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXEC_OBJ} ${HEX_OBJ}
      DEPENDS ${TARGET}.size
  )

  add_custom_target (${TARGET}.hex ALL DEPENDS ${HEX_OBJ})
endfunction(target_generate_hex)

function(target_memory_report TARGET)
    get_property(binary TARGET ${TARGET} PROPERTY RUNTIME_OUTPUT_NAME)

    add_custom_command(OUTPUT ${TARGET}.size
		COMMAND ${CMAKE_GCC_SIZE} -A -d $<TARGET_FILE:${TARGET}>
		COMMAND ${CMAKE_GCC_SIZE} -A -d $<TARGET_FILE:${TARGET}> > ${TARGET}.size
		COMMAND ${CMAKE_GCC_SIZE} -B -d $<TARGET_FILE:${TARGET}>
		DEPENDS ${TARGET}
        )
    set_property(TARGET ${NAME} APPEND_STRING PROPERTY LINK_FLAGS " -Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/${NAME}.map")
endfunction(target_memory_report)

function(target_asm_listing TARGET)
    get_property(binary TARGET ${TARGET} PROPERTY RUNTIME_OUTPUT_NAME)

    add_custom_target(${TARGET}.asm
        COMMAND ${CMAKE_COMMAND} -E make_directory ${REPORTS_PATH}
        COMMAND ${CMAKE_OBJDUMP} -dSC $<TARGET_FILE:${TARGET}> > ${REPORTS_PATH}/${TARGET}.lss
        DEPENDS ${TARGET}
    )
endfunction(target_asm_listing)


function(target_jlink_flash TARGET)
  set(COMMAND_FILE ${CMAKE_BINARY_DIR}/build/${TARGET}.flash.jlink)

  get_property(HEX_FILE TARGET ${TARGET} PROPERTY HEX_FILE)

  configure_file(${CMAKE_SOURCE_DIR}/build/flash.jlink.template ${COMMAND_FILE})

  unset(HEX_FILE)

  set(JLINK_ARGS 
      "-device" ${DEVICE}
      "-ExitOnError"
      "-CommanderScript" ${COMMAND_FILE}
  )

  if(NOT ${JLINK_SN} STREQUAL "")
      list(APPEND JLINK_ARGS -SelectEmuBySN ${JLINK_SN})
  endif()
  
  add_custom_target(${TARGET}.flash
    COMMAND ${JLINK} ${JLINK_ARGS}
    DEPENDS ${TARGET}.hex
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
  )

endfunction(target_jlink_flash)