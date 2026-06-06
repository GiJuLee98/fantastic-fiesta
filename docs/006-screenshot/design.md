# 006-screenshot: design

1. 스크립트 기본 정의 (req:1) [1]
    - 스크립트 파일명은 `scripts/take_screenshots.ps1`로 한다. [1-1]
    - PowerShell 5.1 이상 및 PowerShell Core 환경에서 동작이 가능해야 하며 UTF-8 인코딩으로 작성한다. [1-2]

2. 입력 파라미터 설계 (req:2) [2]
    - `[string]$DirectoryPath`: 스크린샷이 저장될 디렉토리 경로이다. 입력되지 않을 경우 기본값으로 현재 디렉토리(`.`)를 사용한다. [2-1]
    - `[string]$FileName`: 스크린샷 파일들의 공통 이름 부분이며, 필수(Mandatory) 입력 파라미터이다. [2-2]
    - 입력받거나 결정된 디렉토리 경로가 존재하지 않는 경우 자동으로 생성한다. [2-3]

3. 다중 모니터 캡처 및 저장 설계 (req:3) [3]
    - .NET의 `System.Windows.Forms` 및 `System.Drawing` 어셈블리를 로드한다. [3-1]
    - `[System.Windows.Forms.Screen]::AllScreens`를 조회하여 현재 연결된 모든 모니터의 목록을 획득한다. [3-2]
    - 각 모니터에 대해 0부터 시작하는 순차적인 인덱스를 배정한다. [3-3]
    - 각 모니터의 Bounds(X, Y, Width, Height) 영역만큼의 크기로 비트맵 객체 `System.Drawing.Bitmap`을 생성한다. [3-4]
    - `System.Drawing.Graphics` 객체의 `CopyFromScreen` 메서드를 사용하여 해당 모니터 영역을 캡처한다. [3-5]
    - 캡처된 이미지를 `$DirectoryPath/$FileName_$index.png` 경로에 `System.Drawing.Imaging.ImageFormat::Png` 형식으로 저장한다. [3-6]

4. 출력 포맷 설계 (req:4) [4]
    - 스크립트 실행 시작 시 캡처 정보를 추적할 구조를 정의한다. [4-1]
    - 스크립트 실행이 성공적으로 끝난 경우, `Result: Success` 문자열을 먼저 출력하고, 이어서 매핑 정보들을 출력한다. [4-2]
        - 매핑 정보 출력 포맷: `[실제파일경로] : [모니터디바이스이름]` [4-2-1]
    - 스크립트 실행 중 에러가 발생한 경우, `Result: Failure` 문자열과 에러 정보를 출력하고 적절한 종료 코드(예: exit 1)로 종료한다. [4-3]
