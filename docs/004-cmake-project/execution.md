# 004-cmake-project: execution

1. CMakeLists.txt 파일 정합성 검증 결과 (val:1) [1]
    - 루트 경로에 `CMakeLists.txt` 파일이 정상적으로 존재하며, CMake 3.20 이상 요구 조건 및 C++17 설정(`CMAKE_CXX_STANDARD 17`)이 정상적으로 적용되어 있음을 확인하였다. (val:1-1) [1-1]
    - GLFW 빌드 옵션 중 documentation, examples, tests, install targets 빌드를 OFF로 설정하여 최적화 및 빌드 제외 옵션이 정상 선언되었음을 확인하였다. (val:1-2) [1-2]
    - GLAD(external/glad)와 ImGui(external/imgui)의 소스 파일 목록(glad.c 및 imgui 소스/백엔드 파일들)과 Include 경로 설정의 유효성을 정상적으로 점검하였다. (val:1-3) [1-3]
    - 실행 파일 타겟인 `FantasticFiesta`에 `glfw`, `glad`, `imgui`, `opengl32` 라이브러리가 적절하게 링크 구성되어 있음을 확인하였다. (val:1-4) [1-4]

2. CMakePresets.json 툴셋 프리셋 검증 결과 (val:2) [2]
    - 루트 경로에 `CMakePresets.json` 파일이 정상적으로 존재하며 JSON 문법을 준수하고 있음을 확인하였다. (val:2-1) [2-1]
    - 프리셋 구성(`x64-debug`, `x64-release`) 내 Generator가 `Visual Studio 17 2022`, Toolset이 `v143`으로 지정되어 요구사항을 충족함을 점검하였다. (val:2-2) [2-2]
    - 빌드 디렉토리(`binaryDir`) 경로가 `${sourceDir}/out/build/${presetName}`으로 구성되어 빌드 부산물이 `out/build/` 내부에 위치하여 루트가 청결하게 유지됨을 확인하였다. (val:2-3) [2-3]

3. 빌드 시스템 구성 및 프로젝트 컴파일 검증 결과 (val:3) [3]
    - `src/main.cpp`가 올바르게 존재하고 GLFW 에러 콜백, 컨텍스트 생성, GLAD 로드 및 ImGui 초기화/렌더링 루프 등 템플릿 요구사항이 정확히 반영되었음을 확인하였다. (val:3-1) [3-1]
    - CMake `/utf-8` MSVC 컴파일러 플래그 보완 이후 `cmake --preset x64-debug` 구성을 수행하여 에러 없이 프로젝트 솔루션 생성이 완료됨을 검증하였다. (val:3-2) [3-2]
    - `cmake --build out/build/x64-debug` 명령을 빌드 디렉토리를 통해 수행하여 빌드 오류 없이 최종 실행 파일(`FantasticFiesta.exe`)이 정상적으로 생성됨을 검증하였다. (val:3-3) [3-3]

4. 애플리케이션 실행 및 런타임 GUI 렌더링 검증 결과 (val:4) [4]
    - 최종 빌드된 실행 파일(`FantasticFiesta.exe`)을 백그라운드로 3초간 구동 테스트한 결과, 비정상적인 프로세스 즉시 종료(Crash)나 GLAD 로딩 에러 없이 정상적으로 루프가 작동함을 검증하였다. (val:4-1) [4-1]
    - 에러 덤프 및 표준 출력 에러 스트림을 모니터링하여 메인 이벤트 루프와 렌더링 동작이 정상적으로 수행됨을 최종 점검하였다. (val:4-2) [4-2]
