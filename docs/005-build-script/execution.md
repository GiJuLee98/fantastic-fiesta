# 005-build-script: execution

1. PowerShell 스크립트 작성 검증 (val:1-1, 1-2, 1-3, 1-4) [1]
    - `scripts/build_all_configs.ps1` 파일 존재 확인: scripts 폴더 내에 정상적으로 파일이 존재함을 확인하였습니다. (val:1-1) [1-1]
    - CMake 캐시 및 빌드 디렉토리 삭제 후 Clean State 검증: 빌드 결과 폴더인 `out/`을 완전히 삭제한 상태에서 스크립트를 실행하여, CMake Configure(x64-debug) -> Build(Debug) -> Configure(x64-release) -> Build(Release) 순서로 의존성 라이브러리(glad, glfw, imgui) 및 FantasticFiesta 실행 파일이 처음부터 깨끗하게 빌드되는 것을 검증하였습니다. (val:1-2) [1-2]
    - 정상 빌드 시 exit code 0 반환 검증: 모든 빌드가 성공적으로 완료된 후 스크립트가 exit code `0`을 반환하며 종료되는 것을 확인하였습니다. (val:1-3) [1-3]
    - 실패 시나리오 케이스 검증 (val:1-4) [1-4]
        - [Configure 실패]: `CMakeLists.txt` 파일 내에 인위적으로 존재하지 않는 CMake 명령 `cmake_syntax_error_here()`를 기재하여 에러를 유도한 결과, 스크립트가 빌드 단계로 넘어가지 않고 즉시 중단되며 exit code `1`을 반환함을 확인하였습니다. (val:1-4-1) [1-4-1]
        - [Debug 컴파일 실패]: `src/main.cpp` 코드의 `main` 함수 초입에 선언되지 않은 식별자 `compile_error_here;`를 삽입하여 Debug 컴파일 오류를 유도한 결과, x64-debug 빌드 단계에서 즉시 중단되며 Release 빌드로 진행하지 않고 exit code `1`을 반환함을 확인하였습니다. (val:1-4-2) [1-4-2]
        - [Release 컴파일 실패]: `#ifdef NDEBUG` 매크로 조건문을 사용해 Release 빌드 시에만 컴파일 에러(`release_compile_error_here;`)가 발생하도록 설정하고 스크립트를 실행한 결과, Debug 빌드는 정상적으로 성공하고 Release 컴파일 단계에서 에러가 발생하여 즉시 중단 및 exit code `1`을 반환함을 확인하였습니다. (val:1-4-3) [1-4-3]

2. GEMINI.md 파일 업데이트 검증 (val:2-1) [2]
    - UTF-8 인코딩 방식을 지정하여 `GEMINI.md` 파일을 정상적으로 조회하였으며, `## 빌드 규칙` 아래에 `scripts/build_all_configs.ps1` 스크립트를 이용한 빌드 의무 사항 규칙이 반영되었음을 검증하였습니다. (val:2-1) [2-1]
