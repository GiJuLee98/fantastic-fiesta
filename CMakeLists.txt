cmake_minimum_required(VERSION 3.20)
project(FantasticFiesta CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(MSVC)
    add_compile_options(/utf-8)
endif()


# GLFW 빌드 옵션 설정 (빌드 성능 향상)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "Build GLFW documentation" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "Build GLFW examples" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "Build GLFW tests" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "Generate GLFW install targets" FORCE)

# GLFW 추가
add_subdirectory(external/glfw)

# GLAD 라이브러리 추가
add_library(glad STATIC external/glad/src/glad.c)
target_include_directories(glad PUBLIC external/glad/include)

# ImGui 라이브러리 추가
add_library(imgui STATIC
    external/imgui/imgui.cpp
    external/imgui/imgui_demo.cpp
    external/imgui/imgui_draw.cpp
    external/imgui/imgui_tables.cpp
    external/imgui/imgui_widgets.cpp
    external/imgui/backends/imgui_impl_glfw.cpp
    external/imgui/backends/imgui_impl_opengl3.cpp
)
target_include_directories(imgui PUBLIC external/imgui external/imgui/backends)
target_link_libraries(imgui PRIVATE glfw glad)

# 실행 파일 생성
if(NOT OpenCV_DIR)
    set(OpenCV_DIR "C:/opencv/build")
endif()
find_package(OpenCV REQUIRED)

add_executable(FantasticFiesta src/main.cpp src/IntegrationDialog.cpp)

# 의존성 링크
target_include_directories(FantasticFiesta PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(FantasticFiesta PRIVATE glfw glad imgui opengl32 ${OpenCV_LIBS})
