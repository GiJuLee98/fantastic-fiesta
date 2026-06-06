# 006-screenshot: tasks

1. 스크립트 파일 및 기본 파라미터 구현 (des:1-1, 1-2, 2-1, 2-2, 2-3) [1]
    - `scripts/take_screenshots.ps1` 파일을 생성하고 UTF-8 인코딩으로 저장한다. [1-1]
    - `$FileName`을 필수(Mandatory) 파라미터로, `$DirectoryPath`를 선택 파라미터(기본값 `.`)로 정의하는 `param()` 블록을 선언한다. [1-2]
    - `$DirectoryPath` 경로가 존재하는지 검사하고, 존재하지 않는 경우 `New-Item -ItemType Directory`를 사용하여 디렉토리를 생성한다. [1-3]

2. 다중 모니터 조회 및 개별 캡처 로직 구현 (des:3-1, 3-2, 3-3, 3-4, 3-5, 3-6) [2]
    - Windows Forms 및 Drawing 어셈블리를 로드하는 구문을 추가한다. [2-1]
    - `[System.Windows.Forms.Screen]::AllScreens` 컬렉션을 순회하며 각 스크린의 `Bounds` 정보(X, Y, Width, Height)와 `DeviceName`을 획득한다. [2-2]
    - 각 모니터 화면 크기에 맞춰 `System.Drawing.Bitmap`을 생성하고 Graphics 객체로 `CopyFromScreen`을 실행하여 캡처를 수행한다. [2-3]
    - 캡처된 화면을 `$DirectoryPath\$FileName_$index.png` 형태로 조합하고 PNG 파일 포맷으로 저장 및 리소스 해제(Dispose) 처리를 구현한다. [2-4]

3. 출력 및 에러 처리 구현 (des:4-1, 4-2, 4-2-1, 4-3) [3]
    - 전체 과정을 `try-catch` 블록으로 감싸서 예외를 처리한다. [3-1]
    - 캡처가 전부 성공하면 `Result: Success`를 콘솔에 출력하고, 이어서 `절대경로 : 모니터명` 포맷으로 성공한 모니터들의 목록을 출력한다. [3-2]
    - 캡처 중 에러가 발생할 경우 `Result: Failure`를 콘솔에 출력하고, 에러 메시지를 출력한 뒤 종료 코드 1로 스크립트를 종료한다. [3-3]
