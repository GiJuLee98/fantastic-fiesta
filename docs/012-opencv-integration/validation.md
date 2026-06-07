# 012-opencv-integration: validation

1. CMakeLists.txt에 OpenCV 연동 설정 검증 (tas:1-1) [1]
    - cmake presets을 활용하여 CMake Configure 과정이 정상적으로 수행되고 오류 없이 구성이 끝나는지 확인한다. [1-1]

2. 소스 코드 수정 및 신규 다이얼로그 추가 상태 검증 (tas:2-1, 2-2, 2-3) [2]
    - src/SubDialogOpenCV.h 파일 및 IntegrationDialog 코드 수정이 누락 없이 완료되었는지 코드 상으로 교차 검증한다. [2-1]

3. 빌드 무결성 검증 (tas:3-1) [3]
    - scripts/build_all_configs.ps1을 실행하여 Debug 및 Release 모드 모두 빌드가 성공하는지 확인한다. [3-1]

4. 화면 UI 및 OpenCV 연동 런타임 상태 검증 (tas:4-1) [4]
    - 빌드된 바이너리를 구동했을 때 런타임에 DLL 링크 에러나 크래시 없이 정상 실행되는지 확인한다. [4-1]
    - scripts/take_screenshots.ps1을 구동한 후 캡처된 스크린샷에서 "OpenCV Test" 탭이 기본 활성화되어 있고 OpenCV 버전을 출력하는 텍스트가 정상 노출되는지 시각적으로 검증한다. [4-2]
