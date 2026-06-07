# 011-tab-dialog: execution

1. BaseDialog 추상 클래스 빌드 검증 (val:1) [1]
    - `src/BaseDialog.h` 소스 코드를 읽어 확인한 결과, 가상 소멸자 `virtual ~BaseDialog() = default;` 및 순수 가상 함수 `virtual void Draw() = 0;`이 규격에 맞게 선언되어 있음을 확인하였습니다. (val:1-1) [1-1]
    - `powershell -ExecutionPolicy Bypass -File .\scripts\build_all_configs.ps1`을 호출하여 빌드를 수행한 결과, 에러 없이 컴파일 및 링크가 성공하였음을 확인하였습니다. (val:1-2) [1-2]

2. SubDialog1 클래스 추가 및 빌드 검증 (val:2) [2]
    - `src/SubDialog1.h` 소스 코드를 읽어 확인한 결과, `SubDialog1` 클래스가 `BaseDialog`를 public 상속하고 `Draw()` 오버라이드 내에서 `ImGui::Text("sub_dialog_1");`을 정확하게 렌더링하는 것을 확인하였습니다. (val:2-1) [2-1]
    - `powershell -ExecutionPolicy Bypass -File .\scripts\build_all_configs.ps1` 빌드 스크립트를 재호출하여 프로젝트가 경고 또는 에러 없이 정상적으로 빌드되는 것을 검증하였습니다. (val:2-2) [2-2]

3. SubDialog2 클래스 추가 및 빌드 검증 (val:3) [3]
    - `src/SubDialog2.h` 소스 코드를 읽어 확인한 결과, `SubDialog2` 클래스가 `BaseDialog`를 public 상속하고 `Draw()` 오버라이드 내에서 `ImGui::Text("sub_dialog_2");`을 정확하게 렌더링하는 것을 확인하였습니다. (val:3-1) [3-1]
    - `powershell -ExecutionPolicy Bypass -File .\scripts\build_all_configs.ps1` 빌드 스크립트를 재호출하여 프로젝트가 경고 또는 에러 없이 정상적으로 빌드되는 것을 검증하였습니다. (val:3-2) [3-2]

4. IntegrationDialog 클래스 및 CMake 연동 빌드 검증 (val:4) [4]
    - `src/IntegrationDialog.h` 및 `src/IntegrationDialog.cpp` 소스 코드를 읽어 확인한 결과, `IntegrationDialog`가 `BaseDialog`를 public 상속하고, 스마트 포인터(`std::unique_ptr`)를 통하여 `SubDialog1`과 `SubDialog2`의 라이프사이클을 안전하게 관리하며, "dlg_integration" 창 내부의 탭바 및 탭아이템에서 각 하위 다이얼로그의 `Draw()`를 정상 구동함을 확인하였습니다. (val:4-1) [4-1]
    - `CMakeLists.txt`를 확인한 결과, `src/IntegrationDialog.cpp`가 `add_executable`에 정확하게 포함되어 있음을 검증하였습니다. (val:4-2) [4-2]
    - 빌드 스크립트를 재호출하여 새로 구현된 통합 다이얼로그 클래스가 결합한 전체 소스코드가 정상적으로 컴파일 및 링킹됨을 확인하였습니다. (val:4-3) [4-3]

5. main.cpp UI 연동 및 레이아웃 스크린샷 최종 검증 (val:5) [5]
    - `src/main.cpp` 소스 코드를 직접 확인한 결과, `IntegrationDialog.h` 헤더 포함 및 인스턴스 생성, 렌더링 루프에서의 `integration_dialog.Draw()` 호출이 정상 반영되어 있으며, 제어 패널 창 렌더링 전 `ImGui::SetNextWindowCollapsed(true, ImGuiCond_FirstUseEver);` 코드가 올바르게 구현되어 있음을 확인하였습니다. (val:5-1) [5-1]
    - 프로젝트 최종 빌드를 진행하여 컴파일 오류나 경고 없이 성공적으로 컴파일 완료됨을 검증하였습니다. (val:5-2) [5-2]
    - 생성된 실행 파일을 실행하여 `dlg_integration` 창 및 `sub_dialog_1`, `sub_dialog_2` 탭바와 각 탭 내부 문자열이 정상적으로 출력 및 작동함을 검증하였습니다. (val:5-3) [5-3]
    - "dlg_integration" 창과 탭바가 렌더링되고 기존 "Fantastic Fiesta Control Panel" 창이 초기에 축소(Collapsed) 상태로 시작되는 레이아웃을 스크린샷으로 최종 점검 완료하였습니다. (val:5-4) [5-5]
    - 점검에 사용된 임시 스크린샷 파일(`screenshot.png`) 및 테스트 스크립트(`scratch_test.ps1`)를 레포지토리 내 저장 방지 및 보안을 위해 디스크 상에서 완전하게 삭제 완료하였음을 검증하였습니다. (val:5-5) [5-6]
