# 004-cmake-project: validation

1. CMakeLists.txt 파일 정합성 검증 (tas:1) [1]
    - 루트 경로에 `CMakeLists.txt` 파일이 정상적으로 존재하고 CMake 버전 정보(3.20 이상) 및 C++17 설정 여부를 스캔하여 확인한다. (tas:1-1, 1-2) [1-1]
    - GLFW 빌드 제외 옵션들(examples, tests 등 OFF)이 선언되었는지 확인한다. (tas:1-3) [1-2]
    - `glad` 및 `imgui` 라이브러리 타겟에 포함된 소스 파일 목록(glad.c, imgui 핵심 파일들) 및 include 경로 정보의 유효성을 점검한다. (tas:1-4, 1-5) [1-3]
    - 실행 파일 타겟(`FantasticFiesta`)에 라이브러리들(`glfw`, `glad`, `imgui`, `opengl32`)의 정상 연결 구성을 확인한다. (tas:1-6) [1-4]

2. CMakePresets.json 툴셋 프리셋 검증 (tas:2) [2]
    - 루트 경로에 `CMakePresets.json` 파일이 정상적으로 존재하며 파일 구조 및 JSON 문법 규칙을 준수하는지 점검한다. (tas:2-1) [2-1]
    - 구성 프리셋의 generator 정보가 `Visual Studio 17 2022`로 지정되어 있고 컴파일러 툴셋이 `v143`으로 명시되어 있는지 점검한다. (tas:2-2) [2-2]
    - 빌드 캐시 경로가 `out/build/` 내부에 위치하여 루트가 청결하게 관리되는지 확인한다. (tas:2-3) [2-3]

3. 빌드 시스템 구성 및 프로젝트 컴파일 검증 (tas:3) [3]
    - `src/main.cpp`가 생성되었고 GLFW/GLAD/ImGui 기본 템플릿이 작성되었는지 확인한다. (tas:3-1, 3-2, 3-3, 3-4, 3-5, 3-6) [3-1]
    - CLI 환경에서 `cmake --preset x64-debug` 구성을 수행하여 오류 없이 Make/Solution 프로젝트가 생성되는지 검증한다. (tas:1-6, 2-2) [3-2]
    - `cmake --build --preset x64-debug` 빌드 명령을 실행하여 빌드 오류 없이 최종 실행 파일(`FantasticFiesta.exe`)이 생성되는지 검증한다. (tas:1-6, 2-2) [3-3]

4. 애플리케이션 실행 및 런타임 GUI 렌더링 검증 (tas:3) [4]
    - 최종 생성된 실행 파일을 실행했을 때 윈도우 생성 및 GLAD 로딩 에러 없이 정상적으로 프로세스가 시작되는지 확인한다. (tas:3-2, 3-3) [4-1]
    - 메인 루프가 원활하게 돌며 Dear ImGui 데모 윈도우가 화면상에 정상 렌더링되는지 런타임 동작을 최종 점검한다. (tas:3-4, 3-5, 3-6) [4-2]
