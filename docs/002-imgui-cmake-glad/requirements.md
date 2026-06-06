# 002-imgui-cmake-glad: requirements

## 1. 프로젝트 목표 및 범위 [1]
- 사용자가 Windows OS 환경에서 CMake 프로젝트 구축을 시작하기 전, 필수 개발 도구(Visual Studio 2022, CMake)를 설치하고 필요한 외부 소스 라이브러리(GLFW, GLAD, Dear ImGui)를 획득하여 프로젝트 내 `external` 폴더에 올바르게 배치할 수 있도록 돕는 Action Plan 문서를 작성한다. [1-1]
- 이번 계획 문서의 범위는 시스템 필수 도구 설치 가이드, 라이브러리 파일 다운로드 경로 확인, 버전 선정, 그리고 프로젝트 내부 `external` 디렉토리 내의 파일 배치 계획 수립 및 가이드라인 작성으로 한정한다. [1-2]
- CMakeLists.txt나 CMakePresets.json 등의 실제 빌드 스크립트 작성 및 컴파일 테스트는 본 Action Plan 범위에서 제외하고 향후 단계로 분리한다. [1-3]

## 2. 개발 환경 및 기술 스택 요구사항 [2]
- 가이드 대상 환경은 Windows 10/11 64비트를 기준으로 삼는다. [2-1]
- 사용될 외부 의존성 목록은 GLFW(3.3 이상), GLAD(OpenGL 3.3 Core Profile 호환), Dear ImGui(docking 브랜치)로 선정한다. [2-2]
- 배치할 폴더의 최종 트리 구조는 프로젝트 루트 내의 `external` 디렉토리를 기준으로 설계한다. [2-3]
- 개발 툴체인은 MSVC 2022 컴파일러가 포함된 Visual Studio 2022 워크로드와 빌드 제어를 위한 CMake 3.20 이상 버전으로 강제한다. [2-4]

## 3. 기능 사양 요구사항 (문서화 대상 사양) [3]
- Visual Studio 2022 설치 시 C++ 데스크톱 개발 워크로드 구성 요소 설치 가이드를 포함한다. [3-1]
- CMake 공식 다운로드 및 설치 시 시스템 PATH 환경변수 등록 옵션에 대한 설정 방법을 기술한다. [3-2]
- GLFW 라이브러리의 다운로드 링크, 필요한 아카이브(.zip) 선정 및 `external` 내 배치 경로를 기술한다. [3-3]
- GLAD 웹 생성기(https://glad.dav1d.de/)의 설정 옵션 사양(Language: C/C++, API: gl Version 3.3, Profile: Core) 및 생성된 zip 파일의 구성(include, src) 배치 경로를 기술한다. [3-4]
- Dear ImGui의 GitHub 리포지토리 docking 브랜치에서 필요한 소스 코드 파일(주요 소스 및 GLFW, OpenGL3 백엔드 코드)의 목록과 배치 가이드를 기술한다. [3-5]
- `external` 디렉토리의 최종 파일 구조에 대한 상세 트리 다이어그램 및 도구 설치 상태를 포함한 전체 정합성 체크리스트를 포함한다. [3-6]
