cmake_minimum_required(VERSION 2.8.3)
cmake_policy(SET CMP0054 NEW)
project(clang_format_macros)

export(TARGETS ClangFormatMacros NAMESPACE ClangFormatMacros:: FILE ${CMAKE_CURRENT_SOURCE_DIR}/cmake/ClangFormatMacrosClangFormatMacros.cmake)

#set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
#export(PACKAGE ClangFormatMacros)