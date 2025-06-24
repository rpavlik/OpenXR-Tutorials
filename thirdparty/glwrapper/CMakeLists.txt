# Copyright 2023-2025, The Khronos Group Inc.
#
# SPDX-License-Identifier: Apache-2.0

# Built from OpenXR to provide OpenGL (ES) support

if(NOT TARGET tutorial_glwrapper)
    if(ANDROID)
        find_package(OpenGLES REQUIRED COMPONENTS V31)
        find_package(EGL REQUIRED)
    else()
        find_package(OpenGL)
    endif()

    if(OpenGL_FOUND OR OpenGLES_FOUND)

        add_subdirectory(glad2)
        add_library(tutorial_glwrapper STATIC gfxwrapper_opengl.c)
        target_include_directories(tutorial_glwrapper PUBLIC .)
        target_link_libraries(tutorial_glwrapper PUBLIC openxr-glad-loader)
        target_compile_definitions(
            tutorial_glwrapper PUBLIC XRDEPENDENCIES_USE_GLAD
        )
        # if(ANDROID)
        #     target_link_libraries(tutorial_glwrapper PUBLIC openxr-glad-loader)
        #     target_link_libraries(
        #         tutorial_glwrapper PUBLIC ${OpenGLES_V3_LIBRARY} EGL::EGL
        #     )
        # else()

        # endif()
    endif()

    # Determine the presentation backend for Linux systems.
    # Use an include because the code is pretty big.
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        include(presentation)
    endif()

endif()
