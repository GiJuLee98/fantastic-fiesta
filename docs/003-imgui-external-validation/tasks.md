# 003-imgui-external-validation: tasks

1. `external/glad` 파일 배치 정밀 점검 태스크 (des:1-1) [1]
    - `external/glad/include/glad/glad.h` 존재 확인 [1-1]
    - `external/glad/include/KHR/khrplatform.h` 존재 확인 [1-2]
    - `external/glad/src/glad.c` 존재 확인 [1-3]

2. `external/glfw` 파일 배치 정밀 점검 태스크 (des:1-2) [2]
    - `external/glfw/include/GLFW/glfw3.h` 존재 확인 [2-1]
    - `external/glfw/include/GLFW/glfw3native.h` 존재 확인 [2-2]
    - `external/glfw/CMakeLists.txt` 존재 확인 [2-3]

3. `external/imgui` 파일 배치 정밀 점검 태스크 (des:1-3) [3]
    - ImGui Core 헤더 및 소스 파일들(imgui.h, imgui.cpp 등 12개 핵심 파일) 존재 확인 [3-1]
    - ImGui GLFW 백엔드 파일(`imgui_impl_glfw.h`, `imgui_impl_glfw.cpp`)의 정확한 위치 및 존재 여부 확인 [3-2]
    - ImGui OpenGL3 백엔드 파일(`imgui_impl_opengl3.h`, `imgui_impl_opengl3.cpp`, `imgui_impl_opengl3_loader.h`)의 정확한 위치 및 존재 여부 확인 [3-3]

4. `external` 폴더 내 불필요한/잔여 파일 스캔 태스크 (des:2-1) [4]
    - `external` 디렉토리 아래에 남아 있는 압축 파일(`.zip`, `.tar.gz`, `.rar`, `.7z`) 및 셋업 가이드에 지정되지 않은 기타 파일 스캔 [4-1]

5. CMake 실행 환경 및 시스템 PATH 점검 태스크 (des:3-1) [5]
    - PowerShell 터미널에서 `cmake --version` 명령어를 실행하고 버전 문자열 분석 및 에러 발생 여부 확인 [5-1]

6. 최종 리포트 출력 및 정합성 판정 태스크 (des:4-1) [6]
    - 모든 점검 결과를 검증 결과용 테이블에 정리하고 미충족 사안 및 불필요한 파일 발견 여부에 따라 조치 사항 제시 [6-1]
