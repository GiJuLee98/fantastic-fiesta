# 003-imgui-external-validation: requirements

1. 사용자가 구성한 `external` 디렉토리 아래의 파일 구조를 분석하여 `docs/002-imgui-cmake-glad/imgui_external_setup_plan.md`에서 제시한 파일 배치 기준에 부합하는지 정합성을 확인한다. [1]
    - `external/glad` 디렉토리의 glad.h, glad.c, khrplatform.h 파일 배치 여부 및 경로 정합성을 점검한다. [1-1]
    - `external/glfw` 디렉토리의 CMakeLists.txt 및 glfw3.h, glfw3native.h 등 헤더 파일 배치 여부를 점검한다. [1-2]
    - `external/imgui` 디렉토리의 핵심 소스/헤더 파일 및 docking 브랜치의 backends(GLFW, OpenGL3) 연동 파일 배치 여부를 점검한다. [1-3]

2. `docs/002-imgui-cmake-glad/imgui_external_setup_plan.md` 기준에 명시되지 않은, `external` 폴더 내부의 불필요한 파일이나 잔여 파일이 존재하는지 검사한다. [2]
    - 예시로, 임시 다운로드 아카이브 압축 파일(.zip, .tar.gz 등)이나 셋업 가이드라인에 정의되지 않은 잔여 파일이 남아있는지 스캔하고 보고한다. [2-1]

3. CMake 도구의 설치 상태 및 시스템 PATH 인식 여부를 점검한다. [3]
    - CLI 환경에서 `cmake --version`을 실행하여 정상적인 버전이 출력되는지 점검한다. [3-1]

4. 모든 점검 항목에 대한 정합성 검증 결과를 사용자에게 보고한다. [4]
