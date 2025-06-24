# Copyright (c) 2023-2025 The Khronos Group Inc.
#
# SPDX-License-Identifier: Apache-2.0

# Build from OpenXR to provide OpenGL (ES) support
if(NOT TARGET openxr-gfxwrapper)
    if(ANDROID)
        find_package(OpenGLES REQUIRED COMPONENTS V31)
        find_package(EGL REQUIRED)
    else()
        find_package(OpenGL)
    endif()

    if((OpenGL_FOUND OR OpenGLES_FOUND)
       AND EXISTS "${openxr_SOURCE_DIR}/src/external/glad2"
    )
        add_subdirectory("${openxr_SOURCE_DIR}/src/external/glad2" glad2)
        # add_library(
        #     openxr-glad-loader STATIC
        #     ${openxr_SOURCE_DIR}/src/external/glad2/src/gl.c
        # )
        # target_include_directories(
        #     openxr-glad-loader
        #     PUBLIC ${openxr_SOURCE_DIR}/src/external/glad2/include
        # )
        # target_link_libraries(openxr-glad-loader PRIVATE ${CMAKE_DL_LIBS})

        # # cause xr_dependencies.h to include glad versions of headers instead of standard ones
        # target_compile_definitions(
        #     openxr-glad-loader PUBLIC XRDEPENDENCIES_USE_GLAD
        # )

        # if(WIN32)
        #     target_sources(
        #         openxr-glad-loader
        #         PRIVATE ${openxr_SOURCE_DIR}/src/external/glad2/src/wgl.c
        #     )
        # else()
        #     target_sources(
        #         openxr-glad-loader
        #         PRIVATE ${openxr_SOURCE_DIR}/src/external/glad2/src/egl.c
        #     )
        # endif()

        # if(WIN32 AND OPENGL_FOUND)
        #     if(TARGET OpenGL::OpenGL)
        #         target_link_libraries(openxr-glad-loader PUBLIC OpenGL::OpenGL)
        #     elseif(TARGET OpenGL::GL)
        #         target_link_libraries(openxr-glad-loader PUBLIC OpenGL::GL)
        #     else()
        #         target_link_libraries(
        #             openxr-glad-loader PUBLIC ${OPENGL_LIBRARIES}
        #         )
        #     endif()
        # endif()

        # if(ANDROID)
        #     target_compile_definitions(openxr-glad-loader PUBLIC GLAD_GLES2)
        # endif()

        # if(NOT WIN32
        #    AND NOT ANDROID
        #    AND NOT APPLE
        # )
        #     target_sources(
        #         openxr-glad-loader
        #         PRIVATE ${openxr_SOURCE_DIR}/src/external/glad2/src/glx.c
        #     )
        # endif()

        add_library(
            openxr-gfxwrapper STATIC
            ${openxr_SOURCE_DIR}/src/common/gfxwrapper_opengl.c
            ${openxr_SOURCE_DIR}/src/common/gfxwrapper_opengl.h
        )
        target_include_directories(
            openxr-gfxwrapper PUBLIC ${openxr_SOURCE_DIR}/src/common
        )
        target_link_libraries(openxr-gfxwrapper PUBLIC openxr-glad-loader)
    endif()
endif()
