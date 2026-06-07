# 012-opencv-integration: tasks

1. CMakeLists.txt에 OpenCV 연동을 위한 CMake 설정 수정 (des:1-1, 1-2, 1-3) [1]
    - CMakeLists.txt 파일에 OpenCV_DIR 기본 경로 설정, find_package 호출 및 FantasticFiesta 타겟에 OpenCV 관련 설정(include, link)을 반영한다. [1-1]

2. OpenCV 연동용 새 다이얼로그 파일 작성 및 기존 파일 수정 (des:2-1, 2-2, 2-3, 2-4) [2]
    - src/SubDialogOpenCV.h 파일을 생성하여 BaseDialog를 상속받고 OpenCV 버전을 출력하는 SubDialogOpenCV 클래스를 작성한다. [2-1]
    - src/IntegrationDialog.h 파일에 SubDialogOpenCV 헤더 포함 및 멤버 변수 선언을 추가한다. [2-2]
    - src/IntegrationDialog.cpp 파일에서 멤버 변수를 초기화하고, "OpenCV Test" 탭을 추가하고 기본 활성화 플래그를 붙여 화면에 그리도록 구현한다. [2-3]

3. 빌드 무결성 검증 (des:3-1) [3]
    - scripts/build_all_configs.ps1 스크립트를 사용하여 Debug와 Release 빌드를 시도하고 에러 없이 성공하는지 검증한다. [3-1]

4. 프로그램 실행 및 스크린샷 캡처를 이용한 화면 검증 (des:2-5) [4]
    - 컴파일 완료된 바이너리를 구동하고 scripts/take_screenshots.ps1 스크립트를 호출해 스크린샷을 찍은 뒤, OpenCV 버전이 명시된 기본 탭이 잘 출력되는지 검증한다. [4-1]
