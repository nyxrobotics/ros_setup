cmake_minimum_required(VERSION 2.8.3)
cmake_policy(SET CMP0054 NEW)
option(DUMP_CONFIG "Enable to Show Current Config" ON)

macro(enable_clang_build)
  #message("[CMake] ENABLE_CLANG_BUILD")
  set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
  find_program(CLANG_C_COMPILER_BIN clang-8)
  find_program(CLANG_CXX_COMPILER_BIN clang++-8)
  set(CMAKE_C_COMPILER ${CLANG_C_COMPILER_BIN} CACHE STRING "clang compiler" FORCE)
  set(CMAKE_CXX_COMPILER ${CLANG_CXX_COMPILER_BIN} CACHE STRING "clang++ compiler" FORCE)
  set(CMAKE_C_STANDARD 11)
  set(CMAKE_CXX_STANDARD 11)
  set(CMAKE_C_EXTENSIONS OFF)
  set(CMAKE_CXX_EXTENSIONS OFF)

  file(GLOB_RECURSE MY_SOURCES_C "src/*.c")
  file(GLOB_RECURSE MY_SOURCES_CPP "src/*.cpp")
  set(MY_SOURCES ${MY_SOURCES_C} ${MY_SOURCES_CPP})
  file(GLOB_RECURSE MY_HEADERS_H "include/*.h")
  file(GLOB_RECURSE MY_HEADERS_HPP "include/*.hpp")
  set(MY_HEADERS ${MY_HEADERS_H} ${MY_HEADERS_HPP})
endmacro()

macro(clang_format_fix)
  #message("[CMake] ENABLE_CLANG_FORMAT_FIX")
  find_program(CLANG_FORMAT_BIN clang-format-8)
  set(FILES_TO_FORMAT ${MY_SOURCES} ${MY_HEADERS})
  if(DUMP_CONFIG)
    message("[CLANG_FORMAT]Formatting Files \n >>> \n ${FILES_TO_FORMAT} \n <<< \n")
    execute_process(
      COMMAND
        ${CLANG_FORMAT_BIN}
        -style=file
        -i
        -dump-config
        ${FILES_TO_FORMAT}
      ENV
        OUTPUT_VARIABLE output
    )
    message("[CLANG_FORMAT]Dump Config \n >>> \n ${output} \n <<< \n")
  endif()
  add_custom_target(call_clang_format
    ALL
    COMMAND
      ${CLANG_FORMAT_BIN}
      -style=file
      -i
      ${FILES_TO_FORMAT}
  )

endmacro()

macro(clang_tidy_fix)
  #message("[CMake] ENABLE_CLANG_TIDY_FIX")
  find_program(CLANG_TIDY_BIN clang-tidy-8)

  if(DUMP_CONFIG)
    set(
      CMAKE_CXX_CLANG_TIDY
      ${CLANG_TIDY_BIN}
      -header-filter=${CMAKE_SOURCE_DIR}/include
      -extra-arg=-std=c++11
      -warnings-as-errors=*
      -fix
      -fix-errors
      -enable-check-profile
      -format-style=file
      -dump-config
      ${MY_SOURCES}
    )
  else()
    set(
      CMAKE_CXX_CLANG_TIDY
      ${CLANG_TIDY_BIN}
      -header-filter=${CMAKE_SOURCE_DIR}/include
      -extra-arg=-std=c++11
      -warnings-as-errors=*
      -fix
      -fix-errors
      -enable-check-profile
      -format-style=file
      ${MY_SOURCES}
    )
  endif()
endmacro()