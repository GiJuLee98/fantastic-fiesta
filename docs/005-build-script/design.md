# 005-build-script: design

1. 빌드 스크립트 작성 위치 및 파일명 설계 (req:2) [1]
    - 프로젝트 루트 하위에 `scripts` 폴더를 생성하고, 해당 폴더 내에 `build_all_configs.ps1` 파일을 생성한다. [1-1]

2. PowerShell 빌드 스크립트의 실행 논리 설계 (req:1, 3, 4, 5, 6) [2]
    - 빌드 시작 전, 빌드 산출물 폴더가 깨끗한 상태에서도 동작하도록 CMake Configure를 먼저 수행한다. (req:3) [2-1]
        - CMake Configure 시 `CMakePresets.json` 파일에 선언되어 있는 프리셋을 사용하도록 `cmake --preset <preset-name>` 구조의 명령을 활용한다. (req:4) [2-1-1]
    - Debug와 Release 두 환경의 구성을 순차적으로 빌드한다. (req:5) [2-2]
        - 각 설정의 빌드는 `cmake --build --preset <preset-name>` 혹은 `cmake --build`를 프리셋의 build 디렉토리를 참조하여 수행한다. [2-2-1]
    - 모든 과정(Configure 및 Debug 빌드, Release 빌드)이 성공해야만 스크립트가 성공으로 판정되도록 흐름 제어를 작성하고, 각 단계의 에러 발생 시 즉시 중단되게 한다. (req:6) [2-3]
    - 빌드 성공 시 exit code `0`을, 에러 발생 시 non-zero exit code (예: `1`)를 반환한다. (req:6) [2-4]
    - 빌드 과정 및 최종 결과(성공/실패)를 명확한 콘솔 메시지(색상 표기 등)로 출력한다. (req:6) [2-5]

3. GEMINI.md 내 빌드 규칙 업데이트 설계 (req:7) [3]
    - `GEMINI.md`에 새로운 섹션 "빌드 규칙"을 추가한다. [3-1]
    - "향후 프로젝트 빌드 시에는 `scripts/build_all_configs.ps1` 스크립트를 실행하여 빌드해야 한다"는 내용을 명시한다. [3-2]
