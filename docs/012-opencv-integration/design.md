# 012-opencv-integration: design

1. CMakeLists.txt에 OpenCV 연동을 위한 설정 추가 [1]
    - OpenCV 라이브러리 경로가 지정되지 않은 경우를 대비하여 `C:/opencv/build` 경로를 기본값으로 지정하는 CMake 로직을 추가한다. (req:1-2) [1-1]
    - `find_package(OpenCV REQUIRED)` 호출을 통해 OpenCV 패키지를 탐색한다. (req:1-1) [1-2]
    - `FantasticFiesta` 타겟에 OpenCV include 디렉토리 및 라이브러리 링크(`target_link_libraries`)를 추가한다. (req:1-3) [1-3]

2. OpenCV 연동 확인용 새 다이얼로그 설계 및 탭 활성화 [2]
    - `BaseDialog`를 상속받는 `SubDialogOpenCV` 클래스를 정의하는 헤더 파일 `src/SubDialogOpenCV.h`를 신규 작성한다. (req:2-1) [2-1]
    - `SubDialogOpenCV::Draw()` 내에서 `opencv2/opencv.hpp`를 포함하여 OpenCV 버전 상수(`CV_VERSION`) 정보를 `ImGui::Text`로 출력한다. (req:2-2) [2-2]
    - `IntegrationDialog` 클래스에 `SubDialogOpenCV` 인스턴스 멤버 변수를 추가하고, 이를 생성자에서 초기화한다. (req:2-1) [2-3]
    - `IntegrationDialog::Draw()` 내 탭 바에서 새 다이얼로그 탭을 처음에 렌더링하고 `ImGuiTabItemFlags_SetSelected` 플래그를 사용하여 프로그램 실행 시 기본 활성화되도록 처리한다. (req:2-3) [2-4]
    - 빌드 후 프로그램을 1초 이상 실행한 뒤 `scripts/take_screenshots.ps1`을 호출하여 화면 스크린샷을 찍고 OpenCV 버전 정보 노출을 검증한다. (req:2-4) [2-5]

3. 빌드 스크립트 실행을 통한 다중 설정 빌드 검증 [3]
    - `scripts/build_all_configs.ps1` 스크립트를 실행하여 x64-debug 및 x64-release 구성에서 컴파일 에러 없이 빌드가 성공적으로 끝나는지 확인한다. (req:3-1) [3-1]
