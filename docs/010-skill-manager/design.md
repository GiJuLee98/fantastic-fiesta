# 010-skill-manager: design

1. 스킬 개요 및 폴더 구조 [1]
    - 이 스킬의 고유 식별자는 `skill-manager`로 결정한다. (req:1-1, req:3-1) [1-1]
    - 폴더 및 파일 구조는 다음과 같이 설계한다. (req:1-3, req:2-2) [1-2]
        ```text
        .gemini/
        └── skills/
            └── skill-manager/
                ├── SKILL.md            # 스킬 설명 및 도구 명세 정의 문서
                ├── config.json         # 스킬 설정 정의
                ├── scripts/
                │   └── manage.ps1      # CRUD 동작을 수행하는 PowerShell 스크립트
                └── HISTORY.md          # skill-manager 자체의 변경 이력 누적 관리
        ```

2. SKILL.md 세부 도구 및 매개변수 설계 [2]
    - 에이전트가 호출할 수 있는 도구 목록을 다음과 같이 정의한다. (req:2-1, req:2-2, req:2-3, req:2-4) [2-1]
        - `get_skills_list`: 등록된 모든 스킬 폴더 목록 및 각 스킬의 `SKILL.md` 개요를 읽어 반환하는 도구 (req:2-1-1) [2-1-1]
        - `create_new_skill`: 신규 스킬 폴더 생성 및 뼈대 파일(`SKILL.md`, `config.json`, `scripts/run.ps1`, `HISTORY.md`)을 생성하고 `.gemini/config.json`에 활성화하는 도구 (req:2-2-3, req:2-2-4, req:2-2-5) [2-1-2]
        - `update_existing_skill`: 지정된 스킬의 파일을 업데이트하고 `HISTORY.md`를 갱신하는 도구 (req:2-3-2, req:2-3-4) [2-1-3]
        - `delete_existing_skill`: 지정된 스킬의 설정을 제거하고 폴더를 삭제하는 도구 (req:2-4-3) [2-1-4]
    - 도구 매개변수 및 반환값 설계 (req:3-3) [2-2]
        - `create_new_skill` 매개변수: `skill_id` (필수, string), `skill_name` (필수, string), `description` (필수, string), `tools_json` (선택, string), `dialog_summary` (필수, string - HISTORY.md 기록용 대화 요약) [2-2-1]
        - `update_existing_skill` 매개변수: `skill_id` (필수, string), `update_targets` (필수, string - 수정할 파일 목록 및 변경 내용 설명), `file_contents` (선택, string - 파일 직접 덮어쓰기용 JSON 구조), `dialog_summary` (필수, string - HISTORY.md 누적 기록용) [2-2-2]
        - `delete_existing_skill` 매개변수: `skill_id` (필수, string) [2-2-3]

3. 인터랙티브 대화 가이드 및 예외 처리 (Instructions) [3]
    - 에이전트가 새로운 스킬 등록/수정 시 거치는 대화 절차를 설계한다. (req:1-2) [3-1]
        - 질문 단계화: 한 번에 모든 정보를 물어보지 않고 `스킬 ID/이름` -> `설명` -> `도구(Tools)` 순으로 단계별로 물어본다. (req:2-2-1, req:2-3-1) [3-1-1]
        - 예시 제공: 도구 매개변수를 질문할 때, 타 스킬의 JSON 형식 예제나 다이어그램 예시를 챗봇 답변에 포함하여 사용자의 작성을 유도한다. (req:2-2-2) [3-1-2]
        - 되묻기 및 피드백: 사용자가 제공한 스킬 ID가 영문 소문자/하이픈 규칙을 어겼을 경우(예: `Test_Skill`), "올바른 형식(예: `test-skill`)으로 다시 입력해 주세요."와 같이 피드백을 주며 재입력을 요구한다. (req:3-1) [3-1-3]
    - 수정 시 안전장치 설계 (req:2-3-3, req:3-2) [3-2]
        - 수정 수행 전 변경 전후 `SKILL.md`나 `config.json` 파일의 임시 백업을 생성하여 에러 발생 시 롤백할 수 있게 한다. [3-2-1]
        - 최종 적용 전에 사용자에게 예상 Diff나 변경 요약을 챗봇을 통해 한 번 더 확인받는다. (req:2-3-3) [3-2-2]

4. HISTORY.md 누적 포맷 설계 [4]
    - 각 스킬 폴더 아래 생성될 `HISTORY.md`는 아래의 마크다운 형식을 따르며, 새로운 로그가 추가될 때 항상 파일 상단(제목 바로 아래)에 삽입되어 최신 정보가 가장 위에 위치하도록 설계한다. (req:2-2-5, req:2-3-4, req:3-4) [4-1]
        ```markdown
        # [Skill Name] History

        ## [YYYY-MM-DD HH:mm:ss] - [생성 또는 수정 목적]
        - **작업 내용**: [예: 신규 스킬 추가 / 도구 업데이트]
        - **사용자 요구사항**: [사용자가 요청한 대화 요약 내용]
        - **변경 사항 요약**: 
          - [추가된 도구/매개변수 정보]
          - [스크립트 변경 사항]
        ```


