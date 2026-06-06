# 004-cmake-project: tasks

1. CMakeLists.txt 생성 및 설정 (des:1) [1]
    - 프로젝트 루트 디렉토리에 `CMakeLists.txt` 파일을 생성한다. (des:1-1) [1-1]
    - `cmake_minimum_required(VERSION 3.20)`을 선언하고 C++17 컴파일러 옵션을 활성화한다. (des:1-1) [1-2]
    - GLFW 빌드 성능 향상을 위해 문서, 예제, 테스트 빌드를 비활성화(`set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)` 등)한 후 `add_subdirectory(external/glfw)`를 선언한다. (des:1-2) [1-3]
    - `glad` 타겟을 `add_library(glad STATIC)`로 선언하고 `external/glad/src/glad.c`를 추가하며, include 경로를 설정한다. (des:1-3) [1-4]
    - `imgui` 타겟을 `add_library(imgui STATIC)`로 선언하고 core 소스 및 GLFW, OpenGL3 백엔드 소스 파일을 추가하고 include 경로를 매핑한다. (des:1-4) [1-5]
    - 실행 파일 타겟 `FantasticFiesta`를 `add_executable`로 선언하고 `src/main.cpp`를 연결하며, `glfw`, `glad`, `imgui`, `opengl32` 라이브러리를 링크한다. (des:1-5) [1-6]

2. CMakePresets.json 생성 및 툴체인 매핑 (des:2) [2]
    - 프로젝트 루트 디렉토리에 `CMakePresets.json` 파일을 생성한다. (des:2-1) [2-1]
    - Visual Studio 2022 제너레이터와 MSVC v143 툴체인을 활용하도록 `x64-debug` 및 `x64-release` 설정 프리셋을 작성한다. (des:2-1) [2-2]
    - 빌드 캐시 디렉토리가 `${sourceDir}/out/build/${presetName}`에 생성되도록 빌드 경로를 격리하여 관리한다. (des:2-2) [2-3]

3. src/main.cpp 파일 작성 및 연동 구현 (des:3) [3]
    - `src/` 디렉토리를 생성하고 `src/main.cpp` 파일을 생성한다. (des:3-1) [3-1]
    - GLFW 윈도우 생성 및 OpenGL 3.3 Core Profile 컨텍스트 설정을 정의한다. (des:3-1) [3-2]
    - GLAD 로딩(`gladLoadGLLoader`) 코드를 작성하고 예외 처리를 수행한다. (des:3-2) [3-3]
    - ImGui 초기화 컨텍스트 생성 및 GLFW/OpenGL3 백엔드를 초기화하되 다중 뷰포트 플래그를 설정하지 않고 일반 뷰포트로 지정한다. (des:3-3) [3-4]
    - 메인 이벤트 루프 내에서 버퍼 클리어, ImGui 프레임 생성, ImGui 데모 창 호출, 렌더링 파이프라인 구성 및 화면 버퍼 스왑을 수행한다. (des:3-4) [3-5]
    - 메인 루프 종료 시 ImGui 및 GLFW 관련 자원을 메모리 해제하고 완전하게 종료한다. (des:3-5) [3-6]
