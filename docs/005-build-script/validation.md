# 005-build-script: validation

1. PowerShell 스크립트 작성 검증 (tas:1) [1]
    - `scripts/build_all_configs.ps1` 파일이 정상적으로 생성되었는지 파일 존재 여부를 확인한다. (tas:1-1) [1-1]
    - CMake 캐시 및 빌드 디렉토리를 완전히 삭제한 깨끗한 상태(Clean State)에서 스크립트를 실행해 빌드가 처음부터 올바르게 구성 및 생성되는지 확인한다. (tas:1-2, 1-3) [1-2]
    - PowerShell을 통해 스크립트를 직접 실행하고, 빌드가 문제없이 완료된 경우 exit code(`$LASTEXITCODE` 또는 `$lastexitcode`)가 `0`을 반환하는지 검증한다. (tas:1-4) [1-3]
    - 실패 시나리오 케이스별 스크립트 비정상 종료 및 non-zero exit code 반환 검증: (tas:1-4) [1-4]
        - [Configure 실패]: 임의로 CMakeLists.txt 내 문법 오류를 만들어 Configure를 실패하게 한 뒤, 스크립트가 빌드 단계로 넘어가지 않고 즉시 중단 및 non-zero exit code를 반환하는지 확인한다. [1-4-1]
        - [Debug 컴파일 실패]: x64-debug 빌드 중 에러가 나도록 src/main.cpp 코드를 일시적으로 수정하여 Debug 컴파일이 실패했을 때, 스크립트가 Release 빌드 단계로 넘어가지 않고 즉시 중단 및 non-zero exit code를 반환하는지 확인한다. [1-4-2]
        - [Release 컴파일 실패]: Debug 빌드는 정상 완료된 상태에서 Release 빌드 시에만 컴파일 에러가 나는 형태의 수정(예: `#ifndef NDEBUG` 에러 강제 발생)을 통해 Release 컴파일 실패 시 즉시 중단 및 non-zero exit code를 반환하는지 확인한다. [1-4-3]

2. GEMINI.md 파일 업데이트 검증 (tas:2) [2]
    - `GEMINI.md`에 빌드 스크립트 실행에 관한 지침 규칙이 올바르게 반영되었는지 UTF-8 인코딩을 지정하여 읽고 변경 내용을 검증한다. (tas:2-1) [2-1]
