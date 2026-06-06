# 007-screenshot-dpi-fix: execution

1. 검증 결과 요약 (val:1-1, val:2-1, val:3-1, val:3-2, val:3-3, val:4-1) [1]
    - `take_screenshots.ps1` 스크립트를 실행하여 배율이 적용된 멀티 모니터 환경에서도 물리 해상도 기준의 캡처 및 작업 표시줄이 포함된 정상 영역 검증을 성공적으로 완료하였습니다. (val:1-1, val:3-1, val:3-2, val:3-3) [1-1]
    - 동일 PowerShell 세션에서 2회 연속 스크립트를 실행 시 어셈블리 재정의 오류 없이 정상적으로 실행 및 성공함을 확인하였습니다. (val:2-1) [1-2]

2. DPI 인지 함수 실행 검증 (val:1-1) [2]
    - `take_screenshots.ps1` 스크립트를 실행할 때 C# `SetProcessDPIAware` 및 `SetProcessDpiAwarenessContext` Win32 API의 동적 컴파일 및 호출 시 예외가 발생하지 않고 정상 수행되었습니다. (val:1-1) [2-1]

3. 스크립트 연속 반복 실행 검증 (val:2-1) [3]
    - 동일한 PowerShell 세션에서 `take_screenshots.ps1`을 2회 이상 연속적으로 실행했을 때, '유형이 이미 존재합니다'와 같은 어셈블리 재정의 관련 예외나 오류 없이 정상적으로 종료되며 "Result: Success" 출력을 2회 모두 성공하였습니다. (val:2-1) [3-1]

4. 스크린샷 영역 및 해상도 검증 (val:3-1, val:3-2, val:3-3) [4]
    - 배율이 적용된 환경에서 캡처된 스크린샷 이미지들의 크기와 물리 해상도를 교차 검증한 결과, 우하단 잘림 현상이 없으며 정확히 물리 해상도와 일치합니다. (val:3-1) [4-1]
        - 디스플레이 1 (`\\.\DISPLAY1`): 캡처본 1920x1080 (물리 해상도 1920x1080 일치) (val:3-1) [4-1-1]
        - 디스플레이 2 (`\\.\DISPLAY2`): 캡처본 1920x1080 (물리 해상도 1920x1080 일치) (val:3-1) [4-1-2]
        - 디스플레이 3 (`\\.\DISPLAY3`): 캡처본 1050x1680 (물리 해상도 1050x1680 일치) (val:3-1) [4-1-3]
    - 캡처된 모든 이미지 하단에 윈도우 작업 표시줄(Taskbar) 영역이 정상적으로 표시됨을 확인하였습니다. 하단 40px 영역에서 47가지 이상의 다양한 색상 분포를 확인하여 단색으로 잘린 부분이 없음을 입증했습니다. (val:3-2) [4-2]
    - 생성된 테스트 결과 이미지 파일(`test_screen_*.png`)의 가로x세로 해상도를 `System.Drawing.Image` 객체를 사용하여 교차 확인한 결과, 가로/세로 방향에 관계없이 1920*1080 또는 1680*1050 규격 중 하나에 완벽히 일치하였습니다. (val:3-3) [4-3]
        - `test_screen_0.png` 해상도: 1920x1080 (1920*1080 규격에 일치) (val:3-3) [4-3-1]
        - `test_screen_1.png` 해상도: 1920x1080 (1920*1080 규격에 일치) (val:3-3) [4-3-2]
        - `test_screen_2.png` 해상도: 1050x1680 (세로 방향의 1680*1050 규격에 일치) (val:3-3) [4-3-3]

5. 출력 포맷 검증 (val:4-1) [5]
    - 스크립트 실행 후 결과 포맷이 "Result: Success" 및 생성된 파일 절대 경로와 모니터 장치 이름의 매핑 정보 형태로 정확히 한 라인씩 출력되는 것을 검증하였습니다. (val:4-1) [5-1]
    - 검증된 실제 콘솔 출력 내용: (val:4-1) [5-2]
      ```text
      Result: Success
      C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_screen_0.png : \\.\DISPLAY1
      C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_screen_1.png : \\.\DISPLAY2
      C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_screen_2.png : \\.\DISPLAY3
      ```
