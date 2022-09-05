# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\qtimer_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\qtimer_autogen.dir\\ParseCache.txt"
  "qtimer_autogen"
  )
endif()
