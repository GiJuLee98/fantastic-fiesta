# 005-build-script: tasks

1. `scripts` 폴더 생성 및 PowerShell 스크립트 작성 (des:1, 2) [1]
    - 프로젝트 루트에 `scripts` 폴더를 생성하고, `build_all_configs.ps1` 파일을 생성한다. (des:1-1) [1-1]
    - `build_all_configs.ps1` 파일에 CMake Configure를 수행하는 로직을 작성한다. (des:2-1, 2-1-1) [1-2]
    - `build_all_configs.ps1` 파일에 Debug 및 Release 환경을 순차적으로 빌드하는 로직을 작성한다. (des:2-2, 2-2-1) [1-3]
    - 에러 핸들링 및 exit code 설정, 진행 사항에 대한 출력 메시지를 구현한다. (des:2-3, 2-4, 2-5) [1-4]

2. GEMINI.md 파일 업데이트 (des:3) [2]
    - `GEMINI.md` 파일 내에 향후 에이전트 빌드 시 `scripts/build_all_configs.ps1` 스크립트를 사용하여 빌드하도록 지시하는 규칙을 추가한다. (des:3-1, 3-2) [2-1]
