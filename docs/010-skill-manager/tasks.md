# 010-skill-manager: tasks

1. 스킬 폴더 및 구성 파일 정의 [1]
    - `.gemini/skills/skill-manager/` 하위 디렉토리를 생성한다. (des:1-2) [1-1]
    - `.gemini/skills/skill-manager/config.json`을 정의하고 `scripts/manage.ps1` 실행 환경 권한 등을 기술한다. (des:1-2) [1-2]
    - `.gemini/skills/skill-manager/SKILL.md`를 정의하여 `get_skills_list`, `create_new_skill`, `update_existing_skill`, `delete_existing_skill` 도구의 파라미터를 등록한다. (des:2-1, des:2-2) [1-3]

2. 스킬 관리 스크립트(scripts/manage.ps1) 구현 [2]
    - 목록 조회 기능 구현: `.gemini/skills/`를 조회하여 각 폴더명과 `SKILL.md`를 수집해 JSON/텍스트 형태로 변환하는 기능을 구현한다. (des:2-1-1) [2-1]
    - 신규 스킬 생성 기능 구현: 타겟 폴더 생성, 기본 `SKILL.md`, `config.json`, `scripts/run.ps1` 생성 및 `HISTORY.md` 첫 기록(대화 요약 포함)을 생성하는 기능을 구현한다. (des:2-1-2, des:2-2-1, des:4-1) [2-2]
    - 스킬 수정 기능 구현: 지정된 파일 변경점을 수정하고 백업 파일을 임시로 생성하며 `HISTORY.md` 상단에 새 히스토리 내용을 삽입(prepend)하는 기능을 구현한다. (des:2-1-3, des:2-2-2, des:3-2-1, des:4-1) [2-3]
    - 스킬 삭제 기능 구현: 폴더 전체 삭제 및 루트 `.gemini/config.json`에서 항목 제외 기능을 구현한다. (des:2-1-4, des:2-2-3) [2-4]

3. 루트 설정 업데이트 및 스킬 활성화 [3]
    - 루트 `.gemini/config.json` 파일의 `enabled_skills` 목록에 `"skill-manager"`를 추가하여 활성화한다. (des:1-1) [3-1]



