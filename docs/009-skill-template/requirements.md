# 009-skill-template: requirements

1. gemini-skill-addition-guide.md를 기반으로 신규 Skill 추가 시 결정해야 하는 사항들을 정리한 템플릿 문서를 정의한다. [1]
    - 템플릿 문서가 포함해야 하는 주요 결정 사항 항목들을 추출하여 정의한다. [1-1]
        - 폴더명 및 고유 식별자 명명 규칙에 따른 결정 사항 [1-1-1]
        - SKILL.md 필수 구성 요소(Name, Description, Instructions, Tools)에 채워질 세부 명세 결정 사항 [1-1-2]
        - 외부 실행 스크립트 배치 및 통합 방안 (스크립트 종류, 매개변수 등) 결정 사항 [1-1-3]
        - 에이전트 설정 파일(.gemini/config.json) 반영 및 활성화 방안 결정 사항 [1-1-4]
    - 개발자가 새로운 Skill을 추가할 때 작성 및 체크 리스트로 사용할 수 있는 템플릿 Markdown 문서를 생성하며, 경로는 `docs/009-skill-template/gemini-skill-template.md`로 한다. [1-2]
    - 템플릿 문서는 세부 결정 사항마다 `[1-1-1]`과 같은 명확한 고유 숫자 인덱스 번호를 포함하여, 사용자가 프롬프트에서 인덱스 번호와 입력값만 명시해서 작업을 수행할 수 있도록 구조화한다. [1-3]
    - 템플릿 문서 상단에 docs/008-gemini-skill-guide/gemini-skill-addition-guide.md를 기반으로 한 신규 Skill 추가 의사결정을 위한 템플릿이라는 배경과 주요 사용 목적을 명시한다. [1-4]
