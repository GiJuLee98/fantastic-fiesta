# 007-screenshot-dpi-fix: tasks

1. DPI 인지 Windows API 타입 로드 구현 (des:1-1) [1]
    - `Add-Type` 명령어를 사용하여 `user32.dll`의 API 함수들을 가져오는 C# 컴파일 코드를 `take_screenshots.ps1`의 Assembly 로드 섹션 이전에 작성한다. [1-1]

2. C# 타입 중복 로드 조건문 처리 구현 (des:2-1, 2-2) [2]
    - `Add-Type`을 수행하기 전 `[Type]::GetType("WinAPI.DpiUtil")` 혹은 네임스페이스 기반의 타입 체크를 거쳐, 타입이 정의되지 않은 최초 1회에만 `Add-Type`을 실행하게 로직을 감싼다. [2-1]

3. DPI 인지 함수 호출 구현 (des:1-2) [3]
    - Assembly 및 타입 존재 여부를 확정한 이후, 캡처 루프가 돌아가기 전에 `[WinAPI.DpiUtil]::SetProcessDpiAwarenessContext(-4)` 또는 `SetProcessDPIAware()`를 호출한다. [3-1]

4. 캡처 로직 및 스크립트 무결성 유지 (des:3-1, 4-1, 4-2) [4]
    - DPI 인지가 켜진 상태에서 `[System.Windows.Forms.Screen]::AllScreens`를 호출하고, 가상 영역이 아닌 전체 Bounds(물리 해상도 기반)를 정상적으로 가져와 복사 및 저장하게 한다. [4-1]
    - 기존의 디바이스 명칭 출력 매핑 형식과 반환 결과 출력의 완전성을 유지한다. [4-2]
