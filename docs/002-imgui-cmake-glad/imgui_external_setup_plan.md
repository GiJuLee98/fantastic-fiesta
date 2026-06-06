# imgui_external_setup_plan

1. 개요 (tas:1) [1]
    - 본 문서는 Windows OS 환경에서 CMake 프로젝트 구축을 시작하기 전, 필수 개발 도구(Visual Studio 2022, CMake)를 설치하고 필요한 외부 소스 라이브러리(GLFW, GLAD, Dear ImGui)를 획득하여 프로젝트 내 `external` 폴더에 올바르게 배치할 수 있도록 돕는 사전 환경 구축 가이드라인이다. (tas:1-1) [1-1]
    - 제공되는 템플릿 구조는 개발 도구 가이드, 의존성 라이브러리 가이드, external 폴더 트리, 검증 체크리스트로 구성된다. (tas:1-2) [1-2]

2. 사전 개발 도구 설치 가이드 (tas:2) [2]
    - **Visual Studio 2022 설치**: Visual Studio 공식 홈페이지(https://visualstudio.microsoft.com/ko/vs/)에서 Visual Studio 2022 Community 버전을 다운로드하고, "C++를 사용한 데스크톱 개발" 워크로드를 반드시 체크하여 MSVC 빌드 툴체인을 설치한다. (tas:2-1) [2-1]
    - **CMake 설치**: CMake 공식 다운로드 페이지(https://cmake.org/download/)에서 Windows x64 Installer (.msi) 파일을 다운로드하여 설치를 진행하며, 설치 도중 "Add CMake to the system PATH for all users" 또는 "for current user" 옵션을 반드시 선택하여 환경 변수(PATH)에 자동 등록되도록 한다. (tas:2-2) [2-2]

3. 의존성 라이브러리 획득 및 선별 가이드 (tas:3) [3]
    - **GLFW 획득**: GLFW 공식 다운로드 페이지(https://www.glfw.org/download.html)에서 Source package (.zip) 버전을 다운로드하여 압축을 해제한 후, 빌드 설정 및 CMake 연동을 위해 필요한 소스 파일들을 식별한다. (tas:3-1) [3-1]
    - **GLAD 획득**: GLAD 웹 서비스 생성기(https://glad.dav1d.de/)에 접속하여 아래 표에 제시된 설정값을 지정한 후 "Generate" 버튼을 클릭하여 생성된 zip 파일을 다운로드한다. (tas:3-2) [3-2]

| 설정 항목 (GLAD Web Generator) | 설정값 |
| --- | --- |
| Language | C/C++ |
| Specification | OpenGL |
| API gl | Version 3.3 |
| Profile | Core |

    - **Dear ImGui 획득**: Dear ImGui 공식 GitHub 리포지토리(https://github.com/ocornut/imgui)에서 `docking` 브랜치 소스코드를 획득하기 위해 아래의 Git Clone 명령어를 실행한다. (tas:3-3) [3-3]
      ```bash
      git clone -b docking https://github.com/ocornut/imgui.git
      ```
      다운로드 혹은 Clone한 후, 핵심 헤더/소스 파일(imgui.cpp, imgui.h, imgui_demo.cpp, imgui_draw.cpp, imgui_internal.h, imgui_rectpack.h, imgui_tables.cpp, imgui_widgets.cpp, imconfig.h, imstb_rectpack.h, imstb_textedit.h, imstb_truetype.h)과 GLFW/OpenGL3 백엔드 코드 파일(imgui_impl_glfw.cpp, imgui_impl_glfw.h, imgui_impl_opengl3.cpp, imgui_impl_opengl3.h, imgui_impl_opengl3_loader.h)을 확보한다.

4. external 디렉토리 트리 및 파일 배치 가이드 (tas:4) [4]
    - `external` 디렉토리 하위에 GLFW, GLAD, ImGui 소스코드를 격리하여 관리하기 위해 `external/glfw`, `external/glad`, `external/imgui` 서브 디렉토리를 각각 구성한다. (tas:4-1) [4-1]
    - 최종 완성된 `external` 폴더의 물리적 배치 트리는 다음과 같이 구성되어야 하며, 각 파일이 누락 없이 존재함을 확인한다. (tas:4-2) [4-2]

```text
external/
├── glad/
│   ├── include/
│   │   ├── KHR/
│   │   │   └── khrplatform.h
│   │   └── glad/
│   │       └── glad.h
│   └── src/
│       └── glad.c
├── glfw/
│   ├── cmake/
│   ├── deps/
│   ├── docs/
│   ├── examples/
│   ├── include/
│   │   └── GLFW/
│   │       ├── glfw3.h
│   │       └── glfw3native.h
│   ├── src/
│   └── CMakeLists.txt (및 기타 glfw 소스 파일들)
└── imgui/
    ├── imconfig.h
    ├── imgui.cpp
    ├── imgui.h
    ├── imgui_demo.cpp
    ├── imgui_draw.cpp
    ├── imgui_internal.h
    ├── imgui_rectpack.h
    ├── imgui_tables.cpp
    ├── imgui_widgets.cpp
    ├── imstb_rectpack.h
    ├── imstb_textedit.h
    ├── imstb_truetype.h
    ├── imgui_impl_glfw.cpp
    ├── imgui_impl_glfw.h
    ├── imgui_impl_opengl3.cpp
    ├── imgui_impl_opengl3.h
    └── imgui_impl_opengl3_loader.h
```

5. 최종 셋업 정합성 체크리스트 (tas:5) [5]
    - **도구 설치 자가진단**: 명령 프롬프트(CMD) 또는 PowerShell 환경에서 `cmake --version` 명령어를 실행하여 CMake 버전(3.20 이상)이 정상 인식되고 출력되는지 점검한다. (tas:5-1) [5-1]
    - **의존성 라이브러리 파일 배치 자가진단**: 아래 핵심 파일들이 올바르게 제 위치에 있는지 체크한다. (tas:5-2) [5-2]
        - [x] external/glad/src/glad.c
        - [x] external/glad/include/glad/glad.h
        - [x] external/glad/include/KHR/khrplatform.h
        - [x] external/glfw/include/GLFW/glfw3.h
        - [x] external/glfw/CMakeLists.txt
        - [x] external/imgui/imgui.h
        - [x] external/imgui/imgui.cpp
        - [ ] external/imgui/imgui_impl_glfw.h -> backends 내부에 있음
        - [ ] external/imgui/imgui_impl_opengl3.h -> backends 내부에 있음
