# 006-screenshot: execution

1. 파라미터 검증 테스트 (val:1) [1]
    - 필수 파라미터인 `-FileName`을 누락하고 스크립트를 호출했을 때, PowerShell의 필수 파라미터 바인딩 에러가 정상적으로 발생하며 에러를 출력하는지 검증한다. (val:1-1) [1-1]
        - 결과: SUCCESS [1-1-1]
        - 출력 로그: [1-1-2]
          ```text
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\scripts\take_screenshots.ps1 : 'FileName' 매개 변수를 바인딩할 수 
          없습니다. 'FileName' 매개 변수는 필수 매개 변수이지만 지정되지 않았습니다.
              + CategoryInfo          : InvalidArgument: (:) [take_screenshots.ps1], ParentContainsErrorRecordException
              + FullyQualifiedErrorId : MissingMandatoryParameter,take_screenshots.ps1
          ```
    - `-DirectoryPath`를 생략하고 `-FileName`만 입력한 채 호출했을 때, 기본 경로(현재 디렉토리 `.`)에 정상적으로 스크린샷 파일들이 생성되고 성공 메시지가 출력되는지 검증한다. (val:1-2) [1-2]
        - 결과: SUCCESS [1-2-1]
        - 출력 로그: [1-2-2]
          ```text
          Result: Success
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_current_dir_0.png : \\.\DISPLAY1
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_current_dir_1.png : \\.\DISPLAY2
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\test_current_dir_2.png : \\.\DISPLAY3
          ```

2. 디렉토리 자동 생성 및 캡처 파일 생성 검증 (val:2) [2]
    - 존재하지 않는 신규 디렉토리 경로(예: `temp/test_screenshots`)를 파라미터로 지정하여 호출한다. (val:2-1) [2-1]
        - 결과: SUCCESS [2-1-1]
    - 지정된 경로 디렉토리가 정상적으로 생성되었는지 확인한다. (val:2-2) [2-2]
        - 결과: SUCCESS (디렉토리 생성 확인됨) [2-2-1]
    - 지정된 디렉토리 내에 `파일이름_0.png`, `파일이름_1.png` 등 모니터 개수만큼 캡처 파일이 정상 생성되었는지 확인한다. (val:2-3) [2-3]
        - 결과: SUCCESS (test_new_dir_0.png, test_new_dir_1.png, test_new_dir_2.png 정상 생성 확인됨) [2-3-1]

3. 출력 포맷 검증 (val:3) [3]
    - 스크린샷 캡처 성공 시, 콘솔 출력에 `Result: Success` 헤더가 명확하게 포함되었는지 검증한다. (val:3-1) [3-1]
        - 결과: SUCCESS [3-1-1]
    - 각 파일 경로와 이에 대응되는 모니터 정보가 `[실제파일경로] : [모니터디바이스이름]` 형태로 출력되는지 검증한다. (val:3-2) [3-2]
        - 결과: SUCCESS [3-2-1]
        - 출력 로그: [3-2-2]
          ```text
          Result: Success
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\temp\test_screenshots\test_new_dir_0.png : \\.\DISPLAY1
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\temp\test_screenshots\test_new_dir_1.png : \\.\DISPLAY2
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\temp\test_screenshots\test_new_dir_2.png : \\.\DISPLAY3
          ```

4. 예외 발생 시 실패 출력 검증 (val:4) [4]
    - 의도적으로 유효하지 않거나 권한이 없는 경로(예: 파일 시스템에 존재할 수 없는 잘못된 문자 패턴 등)를 전달하여 오류를 유도한다. (val:4-1) [4-1]
        - 결과: SUCCESS [4-1-1]
    - 에러 발생 시 콘솔 출력에 `Result: Failure` 헤더가 나타나고, 구체적인 오류 원인이 함께 출력되는지 검증한다. (val:4-2) [4-2]
        - 결과: SUCCESS [4-2-1]
        - 출력 로그: [4-2-2]
          ```text
          New-Item : Cannot find drive. A drive with the name '?' does not exist.
          At C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\scripts\take_screenshots.ps1:13 char:17
          + ...      $null = New-Item -ItemType Directory -Path $DirectoryPath -Force
          +                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              + CategoryInfo          : ObjectNotFound: (?:String) [New-Item], DriveNotFoundException
              + FullyQualifiedErrorId : DriveNotFound,Microsoft.PowerShell.Commands.NewItemCommand
           
          Resolve-Path : Cannot find drive. A drive with the name '?' does not exist.
          At C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\scripts\take_screenshots.ps1:17 char:21
          +     $resolvedDir = (Resolve-Path -Path $DirectoryPath).Path
          +                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              + CategoryInfo          : ObjectNotFound: (?:String) [Resolve-Path], DriveNotFoundException
              + FullyQualifiedErrorId : DriveNotFound,Microsoft.PowerShell.Commands.ResolvePathCommand
           
          Result: Failure
          C:\Users\LEEKIJU\Documents\0_github\fantastic-fiesta\scripts\take_screenshots.ps1 : Cannot bind argument to parameter '
          Path' because it is null.
          ```
