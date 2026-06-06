# 007-screenshot-dpi-fix: design

1. 프로세스 DPI 인지(DPI Awareness) 설정 (req:1-1, 2-2) [1]
    - Windows API (`user32.dll`의 `SetProcessDPIAware` 함수)를 P/Invoke를 통해 PowerShell 세션에서 호출할 수 있도록 C# 코드를 로드한다. [1-1]
    - 캡처 로직을 수행하기 전에 `SetProcessDPIAware()`를 호출하여 스크립트 프로세스가 DPI를 인지하도록 만든다. [1-2]

2. C# 타입 중복 로드 예외 방지 설계 (req:2-3) [2]
    - PowerShell 세션 내에서 스크립트가 중복 실행되는 것을 고려하여, `WinAPI.DpiUtil` 타입이 현재 세션에 이미 로드되어 있는지 정적 확인 메서드(`[Type]::GetType("WinAPI.DpiUtil")`)를 사용하여 판별한다. [2-1]
    - 타입이 존재하지 않는 경우에만 `Add-Type` 명령어로 C# 코드를 컴파일하고, 이미 존재하는 경우 타입 로드 과정을 생략하고 바로 API를 호출하도록 설계한다. [2-2]

3. 모니터 크기 및 좌표 획득 (req:1-1, 1-2, 2-1) [3]
    - DPI 인지가 활성화된 상태에서 `[System.Windows.Forms.Screen]::AllScreens`를 호출하여 각 모니터의 실제 물리 해상도와 올바른 Bounds(X, Y, Width, Height)를 획득한다. [3-1]

4. 화면 캡처 및 이미지 저장 (req:1-1, 1-2, 2-1) [4]
    - 획득한 올바른 물리 Bounds 정보를 바탕으로 `System.Drawing.Graphics.CopyFromScreen`을 호출하여 화면 전체 영역을 캡처한다. [4-1]
    - 파일 저장 형식 및 매핑 결과 출력 포맷은 기존 스펙과 동일하게 유지한다. [4-2]
