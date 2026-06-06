# 003-imgui-external-validation: validation

1. GLAD 의존성 파일 검증 (tas:1) [1]
    - `external/glad/include/glad/glad.h`, `external/glad/include/KHR/khrplatform.h`, `external/glad/src/glad.c` 파일이 실제로 존재하며 크기가 0바이트보다 큰지 검증한다. (tas:1-1, 1-2, 1-3) [1-1]

2. GLFW 의존성 파일 검증 (tas:2) [2]
    - `external/glfw/include/GLFW/glfw3.h`, `external/glfw/include/GLFW/glfw3native.h`, `external/glfw/CMakeLists.txt` 파일이 제 위치에 존재하는지 검증한다. (tas:2-1, 2-2, 2-3) [2-1]

3. ImGui 의존성 파일 검증 (tas:3) [3]
    - 핵심 core 헤더/소스 파일(imgui.h, imgui.cpp 등 12개 파일)과 docking 브랜치에 포함된 backends(GLFW, OpenGL3) 연동 파일이 `external/imgui` 디렉토리 아래(backends 폴더 내부 포함)에 정상적으로 존재하는지 검증한다. (tas:3-1, 3-2, 3-3) [3-1]

4. 불필요한/잔여 파일 존재 여부 검증 (tas:4) [4]
    - `external` 및 하위 폴더 내에 `.zip`, `.tar.gz`, `.rar` 같은 압축 파일이나 `imgui_external_setup_plan.md` 트리 구성 요소에 정의되지 않은 잔여 파일이 존재하지 않는지 스캔하고 검증한다. (tas:4-1) [4-1]

5. CMake 개발 도구 정상 작동 검증 (tas:5) [5]
    - PowerShell 환경에서 `cmake --version` 명령어를 성공적으로 실행하고 0 이상의 정상 코드로 반환되는지 및 출력이 정상적으로 수집되는지 검증한다. (tas:5-1) [5-1]

6. 최종 점검 결과 및 리포트 파일 기록 검증 (tas:6) [6]
    - 수집된 모든 결과를 `docs/003-imgui-external-validation/execution.md` 파일 내에 약속된 마크다운 결과 테이블 형식으로 기록하는지 검증한다. (tas:6-1) [6-1]
