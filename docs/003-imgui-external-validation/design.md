# 003-imgui-external-validation: design

1. `external` 디렉토리 아래의 각 모듈별 정밀 존재 여부 체크 설계 (req:1) [1]
    - GLAD 점검 설계: `external/glad/include/glad/glad.h`, `external/glad/include/KHR/khrplatform.h`, `external/glad/src/glad.c` 파일이 지정된 위치에 실제로 존재하고, 0바이트 크기가 아닌 정상 파일인지 확인한다. (req:1-1) [1-1]
    - GLFW 점검 설계: `external/glfw/include/GLFW/glfw3.h`, `external/glfw/include/GLFW/glfw3native.h`, `external/glfw/CMakeLists.txt` 파일의 존재 여부 및 `external/glfw/src/` 내부 소스 파일들이 배치되어 있는지 확인한다. (req:1-2) [1-2]
    - ImGui 점검 설계: `external/imgui/` 디렉토리에 주요 ImGui core 소스 코드 및 루트 또는 `backends` 폴더 등 하위 폴더에 `imgui_impl_glfw.h/cpp`, `imgui_impl_opengl3.h/cpp/loader.h`가 배치되어 있는지 점검한다. (req:1-3) [1-3]

2. 불필요한/잔여 파일 스캔 설계 (req:2) [2]
    - external 폴더 및 각 하위 폴더(`glad`, `glfw`, `imgui`) 내부에서 가이드라인(`docs/002-imgui-cmake-glad/imgui_external_setup_plan.md`)에 포함되지 않은 파일들이 있는지 리스트업하여 스캔을 구성한다. 특히 압축 파일(`.zip`, `.tar.gz`, `.rar`, `.7z`) 등 잔여 찌꺼기 파일이 있는지 확인한다. (req:2-1) [2-1]

3. CMake 환경 검증 설계 (req:3) [3]
    - CLI 툴 실행 설계: PowerShell 환경에서 `cmake --version` 명령어를 비동기/동기로 수행하고 반환 코드가 0인지 확인하며 버전을 획득하는 스크립트 실행 방식을 채택한다. (req:3-1) [3-1]

4. 최종 리포트 출력 설계 (req:4) [4]
    - 모든 점검 대상 파일들의 존재 유무, 불필요한 잔여 파일 목록, 그리고 CMake 상태를 종합한 테이블 형식의 결과를 작성하고, 누락되거나 맞지 않는 파일이 있다면 경고 메시지와 가이드라인을 함께 출력하도록 설계한다. (req:4-1) [4-1]
