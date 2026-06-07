# 011-tab-dialog: tasks

1. BaseDialog.h 추상 클래스 구현 (des:1) [1]
    - `src/BaseDialog.h`를 생성하여 추상 클래스 `BaseDialog`를 정의한다. (des:1-1) [1-1]
    - 가상 소멸자 및 순수 가상 함수 `Draw()`를 추가한다. (des:1-2, 1-3) [1-2]

2. SubDialog1.h 구현 (des:2-1) [2]
    - `src/SubDialog1.h` 파일을 생성하여 `BaseDialog`를 public 상속받는 `SubDialog1` 클래스를 작성한다. (des:2-1-1) [2-1]
    - `Draw()` 메서드를 오버라이드하여 `ImGui::Text("sub_dialog_1")`을 그리도록 처리한다. (des:2-1-2) [2-2]

3. SubDialog2.h 구현 (des:2-2) [3]
    - `src/SubDialog2.h` 파일을 생성하여 `BaseDialog`를 public 상속받는 `SubDialog2` 클래스를 작성한다. (des:2-2-1) [3-1]
    - `Draw()` 메서드를 오버라이드하여 `ImGui::Text("sub_dialog_2")`을 그리도록 처리한다. (des:2-2-2) [3-2]

4. IntegrationDialog 구현 및 CMakeLists.txt 연동 (des:3, 4-5) [4]
    - `src/IntegrationDialog.h` 및 `src/IntegrationDialog.cpp` 파일을 작성하여 `BaseDialog` 상속 구조와 생성자에서 `SubDialog1`, `SubDialog2` 동적 할당 및 관리 구조를 구현한다. (des:3-1, 3-2) [4-1]
    - `IntegrationDialog::Draw()`의 내부 탭바 및 탭 아이템 구조 렌더링 로직을 구현한다. (des:3-3) [4-2]
    - `CMakeLists.txt`에 `src/IntegrationDialog.cpp` 소스 파일을 추가한다. (des:4-5) [4-3]

5. main.cpp UI 연동 및 기존 윈도우 조절 (des:4-1, 4-2, 4-3, 4-4) [5]
    - `src/main.cpp`에 `IntegrationDialog` 헤더를 포함하고 루프 내에서 추가로 `Draw()`를 실행하도록 소스코드를 작성한다. (des:4-1, 4-2, 4-3) [5-1]
    - 기존 제어 패널 창 렌더링 바로 직전에 `ImGui::SetNextWindowCollapsed(true, ImGuiCond_FirstUseEver);`를 추가한다. (des:4-4) [5-2]
