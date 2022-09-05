# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\qstring_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\qstring_autogen.dir\\ParseCache.txt"
  "qstring_autogen"
  )
endif()
