# 011-tab-dialog: validation

1. BaseDialog 추상 클래스 빌드 검증 (tas:1) [1]
    - `src/BaseDialog.h` 소스 코드를 직접 읽어서 가상 소멸자 및 순수 가상 함수 `Draw()`의 명세 구조가 규격에 맞는지 검토한다. (tas:1-1, 1-2) [1-1]
    - `powershell -ExecutionPolicy Bypass -File .\scripts\build_all_configs.ps1`을 호출하여 추상 클래스가 포함된 상태로 전체 프로젝트가 에러 없이 컴파일되는지 검증한다. (tas:1-1, 1-2) [1-2]

2. SubDialog1 클래스 추가 및 빌드 검증 (tas:2) [2]
    - `src/SubDialog1.h` 소스 코드를 직접 읽어서 `BaseDialog` 상속 및 `Draw()` 구현부가 규격에 맞게 선언 및 정의되었는지 검토한다. (tas:2-1, 2-2) [2-1]
    - 빌드 스크립트를 수행하여 신규 하위 다이얼로그 소스 코드가 결합한 상태에서 컴파일 경고나 오류 없이 정상 빌드되는지 검증한다. (tas:2-1, 2-2) [2-2]

3. SubDialog2 클래스 추가 및 빌드 검증 (tas:3) [3]
    - `src/SubDialog2.h` 소스 코드를 직접 읽어서 `BaseDialog` 상속 및 `Draw()` 내부의 식별 문자열이 잘 선언 및 구현되었는지 검토한다. (tas:3-1, 3-2) [3-1]
    - 빌드 스크립트를 수행하여 두 하위 다이얼로그 클래스가 모두 정상 컴파일 및 링크되는지 검증한다. (tas:3-1, 3-2) [3-2]

4. IntegrationDialog 클래스 및 CMake 연동 빌드 검증 (tas:4) [4]
    - `src/IntegrationDialog.h` 및 `src/IntegrationDialog.cpp` 소스 코드를 직접 읽어서 스마트 포인터를 통한 하위 다이얼로그의 정상적인 생성/관리와 `Draw()` 내의 탭바/탭아이템 그리기 흐름을 검토한다. (tas:4-1, 4-2) [4-1]
    - `CMakeLists.txt` 코드를 직접 읽어서 `IntegrationDialog.cpp` 파일이 정상 등록되었는지 검토한다. (tas:4-3) [4-2]
    - 빌드를 실행하여 새로운 통합 다이얼로그 구현체 소스가 빌드 스크립트로 올바르게 컴파일 및 링킹되는지 검증한다. (tas:4-1, 4-2, 4-3) [4-3]

5. main.cpp UI 연동 및 레이아웃 스크린샷 최종 검증 (tas:5) [5]
    - `src/main.cpp` 소스 코드를 직접 읽어서 `IntegrationDialog` 결합 구조 및 제어 패널 창 렌더링 시작 전의 `ImGui::SetNextWindowCollapsed` 코드를 검토한다. (tas:5-1, 5-2) [5-1]
    - 최종 프로젝트 빌드를 실행하여 컴파일 오류가 없는지 검증한다. (tas:5-1, 5-2) [5-2]
    - 실행 파일을 구동하여 탭 간 전환(sub_dialog_1 및 sub_dialog_2 이동)이 잘 되는지, 각 탭 내부에 지정된 문자열이 깨짐 없이 잘 그려지는지 직접 전환하며 확인한다. (tas:5-1, 5-2) [5-3]
    - 신규 생성된 "dlg_integration" 창과 탭바가 생성되었는지, 기존 제어 패널 창이 초기 시작 시 Collapsed 상태로 정상 표시되는지 실행 화면의 스크린샷을 찍어 시각적으로 최종 검증한다. (tas:5-1, 5-2) [5-4]
    - 점검에 사용된 임시 스크린샷 파일을 최종적으로 완전하게 삭제하여 레포지토리 저장 용량을 방지함을 검증한다. (tas:5-1, 5-2) [5-5]
