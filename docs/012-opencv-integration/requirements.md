# 012-opencv-integration: requirements

1. CMakeLists.txt에 OpenCV 라이브러리 연동 설정을 추가한다. [1]
    - OpenCV 라이브러리를 찾기 위한 CMake 설정을 추가한다. [1-1]
    - C:\opencv\build 경로를 OpenCV_DIR로 지정하거나 CMake 패키지 탐색 경로에 포함되도록 구성한다. [1-2]
    - FantasticFiesta 타겟에 OpenCV 헤더 경로 및 라이브러리 링크를 추가한다. [1-3]

2. OpenCV 연동을 검증할 수 있는 새 다이얼로그 클래스를 작성하고 기본 탭으로 설정한다. [2]
    - IntegrationDialog에 포함될 새 다이얼로그 클래스를 정의한다. [2-1]
    - 새 다이얼로그 내에 OpenCV 버전 정보를 텍스트로 표시하는 UI 코드를 구현한다. [2-2]
    - 새로 추가된 다이얼로그 탭이 프로그램 실행 시 기본 활성화 탭으로 선택되도록 구성한다. [2-3]
    - 프로그램 실행 시 OpenCV 버전 정보가 화면에 잘 노출되는지 스크린샷 캡처를 통해 최종 확인한다. [2-4]

3. 기존 프로젝트 빌드 스크립트를 사용하여 빌드가 오류 없이 통과하는지 검증한다. [3]
    - scripts/build_all_configs.ps1 스크립트를 통해 Debug 및 Release 빌드가 정상 수행되어야 한다. [3-1]
