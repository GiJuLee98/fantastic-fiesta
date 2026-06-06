# 004-cmake-project: design

1. CMakeLists.txt 설계 (req:1-1, 1-3, 2-1, 2-2, 2-3) [1]
    - CMake 최소 요구 버전을 3.20으로 지정하고 프로젝트 이름 및 C++17 표준 규격을 명시한다. (req:1-1, 1-3) [1-1]
    - `external/glfw` 폴더를 빌드 타겟에 추가하기 위해 `add_subdirectory`를 사용하며, GLFW 빌드 옵션(문서, 테스트, 예제 빌드 비활성화)을 설정하여 빌드 속도를 최적화한다. (req:2-1) [1-2]
    - GLAD 헤더 경로를 include 디렉토리에 등록하고, `external/glad/src/glad.c` 파일을 컴파일하는 인터페이스/스태틱 라이브러리 타겟을 정의한다. (req:2-2) [1-3]
    - Dear ImGui 코어 소스 파일 및 GLFW/OpenGL3 백엔드 파일(`imgui_impl_glfw.cpp`, `imgui_impl_opengl3.cpp`)을 하나의 라이브러리 타겟으로 묶고 필요한 include 경로를 설정한다. (req:2-3) [1-4]
    - 메인 실행 파일 타겟(`FantasticFiesta`)을 정의하고 `src/main.cpp`를 컴파일하도록 설정하며, 생성된 실행 파일에 `glfw`, `glad`, `imgui`, 그리고 Windows OpenGL 라이브러리(`opengl32.lib`)를 링크한다. (req:1-3, 2-1, 2-2, 2-3) [1-5]

2. CMakePresets.json 설계 (req:1-2) [2]
    - Windows 환경에서 Visual Studio 2022와 MSVC v143 컴파일러 도구 모음을 명시적으로 사용하도록 CMakePresets.json 파일을 설계한다. (req:1-2) [2-1]
    - 기본 빌드 및 구성(Configure) 디렉토리를 `${sourceDir}/out/build/${presetName}`으로 분리하여 프로젝트 루트 폴더를 깨끗하게 유지한다. (req:1-2) [2-2]

3. src/main.cpp 구조 설계 (req:1-3, 3-1, 3-2, 3-3) [3]
    - GLFW 초기화 및 윈도우 생성 시 OpenGL 3.3 Core Profile 설정을 적용하고 컨텍스트를 메인 스레드에 바인딩한다. (req:3-1) [3-1]
    - GLAD 라이브러리를 로드하여 OpenGL 함수 포인터를 초기화하며, 실패 시 에러 리포트 후 프로그램을 종료한다. (req:3-1) [3-2]
    - Dear ImGui 컨텍스트를 생성하고, GLFW 및 OpenGL3 백엔드 구현 바인딩을 초기화한다. (req:3-2) [3-3]
    - 메인 루프 내부에서 GLFW 이벤트를 폴링하고, ImGui 신규 프레임을 선언하여 데모 윈도우와 메인 테스트 윈도우를 구성한 뒤 OpenGL Clear Color 버퍼 상에 렌더링을 수행한다. (req:3-3) [3-4]
    - 루프 탈출 시 ImGui 컨텍스트와 백엔드를 파괴하고, GLFW 윈도우 리소스를 정리하여 메모리 누수 없이 프로그램을 종료한다. (req:3-3) [3-5]
