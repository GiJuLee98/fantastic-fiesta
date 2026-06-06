# 005-build-script: requirements

1. CMake 프로젝트를 빌드하는 PowerShell 스크립트(.ps1)를 작성한다. [1]
2. 스크립트 위치는 프로젝트 루트 아래 `scripts/` 폴더 내에 배치하며, 파일명은 단순 build 보다는 구체적인 명칭(예: `build_all_configs.ps1`)으로 결정한다. [2]
3. 스크립트는 깨끗한 상태(out/build 등이 없는 상태)에서도 정상 동작하도록 빌드 전에 CMake Configure를 먼저 수행해야 한다. [3]
4. CMake Configure 시 MSVC 컴파일러 기반의 CMakePresets.json(x64-debug, x64-release 등)을 활용할 수 있도록 구성한다. [4]
5. Debug 구성과 Release 구성을 순차적으로 연속하여 빌드한다. [5]
6. 스크립트 실행 후 호출한 측(사용자 또는 agent)에서 빌드 성공 여부를 명확히 판별할 수 있도록 적절한 exit code를 반환하고, 성공/실패 여부를 콘솔에 출력해야 한다. [6]
7. `GEMINI.md` 파일을 수정하여, 향후 에이전트가 빌드를 수행할 때 해당 PowerShell 스크립트 파일을 사용하도록 빌드 규칙을 추가 및 업데이트한다. [7]
