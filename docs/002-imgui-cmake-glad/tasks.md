# 002-imgui-cmake-glad: tasks

1. 계획서 파일 생성 및 구조 정의 [1]
    - 작업 디렉토리 `docs/002-imgui-cmake-glad/` 내에 `imgui_external_setup_plan.md` 파일을 생성한다. (des:1-1) [1-1]
    - 생성한 파일에 개요, 개발 도구 가이드, 의존성 라이브러리 가이드, external 폴더 트리, 검증 체크리스트 구조를 템플릿화한다. (des:1-2) [1-2]

2. 사전 개발 도구 설치 가이드 작성 [2]
    - Visual Studio 2022 Community 버전 설치 가이드라인 및 MSVC 빌드 툴체인("C++를 사용한 데스크톱 개발" 워크로드)을 체크하도록 명시하는 섹션을 작성한다. (des:2-1-1) [2-1]
    - CMake 공식 사이트에서 Windows x64 MSI 인스톨러를 다운로드하고, 환경 변수(PATH) 자동 등록 옵션을 설정하도록 스크린샷 경로 및 설명 섹션을 작성한다. (des:2-2-1) [2-2]

3. 외부 의존성 라이브러리 획득 및 선별 가이드 작성 [3]
    - GLFW Source package (.zip) 다운로드 주소 명시 및 빌드 설정을 위한 핵심 파일 압축 해제 위치를 정리한다. (des:3-1-1) [3-1]
    - GLAD 공식 웹페이지(https://glad.dav1d.de/)에 접속하여 설정해야 하는 속성(C/C++, OpenGL 3.3 Core Profile) 값들을 명확히 정해진 표 형태로 기입하고 생성된 압축파일 다운로드 링크 가이드를 기술한다. (des:3-2-1) [3-2]
    - Dear ImGui의 공식 GitHub 리포지토리 주소를 안내하고 `docking` 브랜치 소스코드를 획득하기 위한 Git Clone 명령어 및 필수 핵심 소스 파일군(imgui.cpp, imgui_widgets.cpp 등)과 백엔드(imgui_impl_glfw.cpp, imgui_impl_opengl3.cpp 등) 파일들의 상세 리스트를 나열한다. (des:3-3-1) [3-3]

4. `external` 디렉토리 트리 및 파일 배치 가이드 작성 [4]
    - `external` 폴더에 GLFW, GLAD, ImGui 소스코드를 어떻게 나누어 배치할지 서브 디렉토리 설계 목록을 서술한다. (des:4-1) [4-1]
    - 마크다운 텍스트 트리 다이어그램 형식으로 사용자가 본인의 `external/` 디렉토리를 완성했을 때 한눈에 파일 존재 여부를 알 수 있도록 도표형식의 트리 뷰를 작성한다. (des:4-2) [4-2]

5. 최종 셋업 정합성 체크리스트 작성 [5]
    - Visual Studio 및 CMake가 로컬 쉘에서 잘 잡혔는지 확인하기 위한 명령어 테스트(`cmake --version` 등)와 정상 동작 시의 기대 예시 결과를 체크리스트 형태로 작성한다. (des:5-1) [5-1]
    - `external/` 디렉토리 내 각 폴더별로 핵심 파일(예: glad.c, imgui.h 등)의 누락을 검증할 수 있는 체크 박스 목록을 작성한다. (des:5-2) [5-2]
