# 002-imgui-cmake-glad: design

## 1. 계획서 문서 기본 구조 설계 (req:1-1, 1-2, 1-3) [1]
- 최종 산출물 문서의 명칭을 `imgui_external_setup_plan.md`로 정의하고, 작업 ID `002-imgui-cmake-glad` 폴더 아래에 생성하도록 설계한다. [1-1]
- 문서는 다음의 대목차 구조를 가지도록 설계한다: 1. 개요, 2. 사전 개발 도구 설치 가이드, 3. 의존성 라이브러리 획득 가이드, 4. external 디렉토리 배치 구조, 5. 최종 셋업 정합성 체크리스트. [1-2]

## 2. 사전 개발 도구 설치 상세 가이드라인 설계 (req:2-4, 3-1, 3-2) [2]
- **Visual Studio 2022 설치 설계**: [2-1]
    - Community/Professional/Enterprise 다운로드 경로 정보를 제공하고, "C++를 사용한 데스크톱 개발" 워크로드 체크의 필수성을 강조하도록 가이드를 수립한다. [2-1-1]
- **CMake 설치 설계**: [2-2]
    - CMake 공식 사이트의 Windows x64 Installer 다운로드 링크 및 설치 중 "Add CMake to the system PATH for all users/current user" 옵션을 무조건 설정하도록 주의 사항을 설계한다. [2-2-1]

## 3. 외부 의존성(Libraries) 획득 상세 가이드라인 설계 [3]
- **GLFW 획득 설계 (req:2-2, 3-3)**: [3-1]
    - 공식 다운로드 페이지 링크 정보 제공 및 C++ CMake 빌드를 지원하는 Source package(.zip) 다운로드 가이드를 수립한다. [3-1-1]
- **GLAD 획득 설계 (req:2-2, 3-4)**: [3-2]
    - glad 생성 서비스 웹페이지 설정값 명시: Language는 C/C++, API는 gl Version 3.3, Profile은 Core로 고정하고 Generate하여 zip 형태로 받도록 상세히 설계한다. [3-2-1]
- **Dear ImGui 획득 설계 (req:2-2, 3-5)**: [3-3]
    - GitHub 리포지토리의 docking 브랜치 체크아웃 정보 및 소스 구성에 필수적인 핵심 헤더/소스 파일과 GLFW/OpenGL3 백엔드 코드의 정확한 물리적 파일 리스트를 설계한다. [3-3-1]

## 4. external 디렉토리 트리 및 파일 배치 설계 (req:2-3, 3-6) [4]
- `external` 디렉토리 하위에 라이브러리별로 폴더를 구분하여 격리하도록 설계한다: `external/glfw`, `external/glad`, `external/imgui`. [4-1]
- 사용자가 직관적으로 확인하고 배치할 수 있도록 최종 생성되어야 하는 디렉토리 트리 뷰(Tree view) 예시를 다이어그램 형태로 제공하도록 설계한다. [4-2]

## 5. 최종 셋업 정합성 체크리스트 설계 (req:3-6) [5]
- **도구 설치 체크리스트**: `cmake --version` 등 CMD/PowerShell 터미널 명령어를 통해 CMake 및 MSVC 컴파일러가 인식되는지 점검하는 항목을 설계한다. [5-1]
- **외부 소스 배치 체크리스트**: 각 라이브러리 폴더 아래에 필수 핵심 파일들이 누락 없이 존재해야 함을 확인하는 파일 단위 체크리스트 항목을 설계한다. [5-2]
