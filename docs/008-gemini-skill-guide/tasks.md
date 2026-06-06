# 008-gemini-skill-guide: tasks

1. 안내서 문서 생성 및 초기 구성 [1]
    - `docs/008-gemini-skill-guide/gemini-skill-addition-guide.md` 파일을 생성한다 (des:1-1) [1-1]
    - 문서 최상단에 버전 정보(v1.0)를 명시한다 (des:1-3) [1-2]
    - 문서의 목적(Gemini Agent Skill의 확장 방법 가이드) 및 대상 독자를 서술한다 (des:1-2) [1-3]

2. 개념 및 구조도 작성 [2]
    - Gemini Agent Skill의 개념과 필요성을 비전공자/초심자도 이해하기 쉬운 비유와 설명으로 기술한다 (des:2-1) [2-1]
    - Skill을 추가할 때 생성하거나 수정해야 하는 디렉터리 구조(예: `.gemini/skills/[skill-name]/`, `SKILL.md` 등)를 텍스트 다이어그램이나 트리 구조로 설명한다 (des:2-2) [2-2]

3. 신규 Skill 추가 상세 절차 작성 [3]
    - 1단계: Skill 폴더 생성 및 명명 규칙을 상세히 설명한다 (des:3-1) [3-1]
    - 2단계: `SKILL.md` 구성 요소(Name, Description, Instructions 등)의 형식과 모범 사례를 구체적으로 기술한다 (des:3-2) [3-2]
    - 3단계: Skill의 동작에 필요한 외부 스크립트(Python, Shell, PowerShell 등)나 리소스를 통합하는 방법을 작성한다 (des:3-3) [3-3]
    - 4단계: 추가한 Skill을 에이전트 환경(예: `.gemini/config.json` 등 로드 설정)에 등록하고 실행 가능하게 만드는 방법을 설명한다 (des:3-4) [3-4]

4. 실전 예시 및 검증 가이드 작성 [4]
    - 빌드 자동화 또는 특정 작업을 수행하는 완결된 예시 Skill의 `SKILL.md` 및 폴더 파일 구조 전문을 포함한다 (des:4-1) [4-1]
    - CLI 명령이나 에이전트 인터랙션을 통해 등록된 Skill이 성공적으로 로드되고 호출되는지 검증하는 구체적인 명령 및 시나리오를 작성한다 (des:4-2) [4-2]
