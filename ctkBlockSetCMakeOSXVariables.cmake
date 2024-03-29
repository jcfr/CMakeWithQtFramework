###########################################################################
#
#  Library:   CTK
#
#  Copyright (c) Kitware Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0.txt
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
###########################################################################

#
# ctkBlockSetCMakeOSXVariables
#

#
# Adapted from Paraview/Superbuild/CMakeLists.txt
#

# Note: Change architecture *before* any enable_language() or project()
#       calls so that it's set properly to detect 64-bit-ness...
#
if(APPLE)

  # Waiting universal binaries are supported and tested, complain if
  # multiple architectures are specified.
  if(NOT "${CMAKE_OSX_ARCHITECTURES}" STREQUAL "")
    list(LENGTH CMAKE_OSX_ARCHITECTURES arch_count)
    if(arch_count GREATER 1)
      message(FATAL_ERROR "error: Only one value (i386 or x86_64) should be associated with CMAKE_OSX_ARCHITECTURES.")
    endif()
  endif()

  # See CMake/Modules/Platform/Darwin.cmake)
  #   8.x == Mac OSX 10.4 (Tiger)
  #   9.x == Mac OSX 10.5 (Leopard)
  #  10.x == Mac OSX 10.6 (Snow Leopard)
  #  10.x == Mac OSX 10.7 (Lion)
  #  10.x == Mac OSX 10.8 (Mountain Lion)
  set(OSX_SDK_104_NAME "Tiger")
  set(OSX_SDK_105_NAME "Leopard")
  set(OSX_SDK_106_NAME "Snow Leopard")
  set(OSX_SDK_107_NAME "Lion")
  set(OSX_SDK_107_NAME "Mountain Lion")

  set(OSX_SDK_ROOTS
    /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs
    /Developer/SDKs
    )
  set(SDK_VERSIONS_TO_CHECK 10.8 10.7 10.6 10.5)
  foreach(SDK_VERSION ${SDK_VERSIONS_TO_CHECK})
    if(NOT CMAKE_OSX_DEPLOYMENT_TARGET OR "${CMAKE_OSX_DEPLOYMENT_TARGET}" STREQUAL "")
      foreach(SDK_ROOT ${OSX_SDK_ROOTS})
        set(TEST_OSX_SYSROOT "${SDK_ROOT}/MacOSX${SDK_VERSION}.sdk")
        if(EXISTS "${TEST_OSX_SYSROOT}")
          # Retrieve OSX target name
          string(REPLACE "." "" sdk_version_no_dot ${SDK_VERSION})
          set(OSX_NAME ${OSX_SDK_${sdk_version_no_dot}_NAME})
          set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE STRING "Force build for 64-bit ${OSX_NAME}." FORCE)
          set(CMAKE_OSX_DEPLOYMENT_TARGET "${SDK_VERSION}" CACHE STRING "Force build for 64-bit ${OSX_NAME}." FORCE)
          set(CMAKE_OSX_SYSROOT "${TEST_OSX_SYSROOT}" CACHE PATH "Force build for 64-bit ${OSX_NAME}." FORCE)
          message(STATUS "Setting OSX_ARCHITECTURES to '${CMAKE_OSX_ARCHITECTURES}' as none was specified.")
          message(STATUS "Setting OSX_DEPLOYMENT_TARGET to '${SDK_VERSION}' as none was specified.")
          message(STATUS "Setting OSX_SYSROOT to '${TEST_OSX_SYSROOT}' as none was specified.")
        endif()
      endforeach()
    endif()
  endforeach()

  if(NOT "${CMAKE_OSX_SYSROOT}" STREQUAL "")
    if(NOT EXISTS "${CMAKE_OSX_SYSROOT}")
      message(FATAL_ERROR "error: CMAKE_OSX_SYSROOT='${CMAKE_OSX_SYSROOT}' does not exist")
    endif()
  endif()
  mark_as_advanced( CMAKE_OSX_ARCHITECTURES )
  mark_as_advanced( CMAKE_OSX_DEPLOYMENT_TARGET )
  mark_as_advanced( CMAKE_OSX_SYSROOT )
endif()
