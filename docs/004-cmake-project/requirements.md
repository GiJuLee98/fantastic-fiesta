# 004-cmake-project: requirements

1. CMake 프로젝트 구축 요구사항 [1]
    - 프로젝트 루트 폴더에 `CMakeLists.txt`를 생성하여 빌드 시스템을 정의하며, CMake 3.20 이상을 요구사항으로 지정한다. [1-1]
    - `CMakePresets.json`을 구성하여 Windows 환경(MSVC v143 툴체인 및 Visual Studio 2022 generator)에서의 컴파일/빌드 구성을 프리셋으로 설정한다. [1-2]
    - `src/main.cpp`를 작성하여 GLFW, GLAD, Dear ImGui를 연동한 기본 애플리케이션 프레임을 구축하며, C++17 표준 규격을 기반으로 빌드하도록 설정한다. [1-3]

2. 외부 의존성 라이브러리 빌드 및 링크 요구사항 [2]
    - `external/glfw`를 CMake 서브디렉토리로 추가하거나 적절히 빌드하여 타겟에 링크한다. [2-1]
    - `external/glad` 소스(`glad.c`) 및 헤더를 포함하여 OpenGL 라이브러리와 함께 빌드 및 링크한다. [2-2]
    - `external/imgui` 소스 파일들과 GLFW/OpenGL3 백엔드를 빌드 타겟에 포함하고 빌드한다. [2-3]

3. 애플리케이션 동작 요구사항 [3]
    - GLFW를 통해 윈도우를 정상적으로 띄우고 OpenGL 3.3 Core 컨텍스트를 성공적으로 생성한다. [3-1]
    - Dear ImGui 초기화 시 일반 단일 뷰포트(Single viewport) 환경으로 동작하도록 구성한다. [3-2]
    - 메인 루프에서 Dear ImGui 데모 윈도우 및 UI 창들이 정상적으로 렌더링되며, 정상적으로 닫히고 작동하는지 확인한다. [3-3]
