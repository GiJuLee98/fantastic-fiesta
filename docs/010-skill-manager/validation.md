# 010-skill-manager: validation

1. 스킬 로드 및 활성화 검증 [1]
    - 루트 `.gemini/config.json`에 `skill-manager`가 올바르게 로드되어 활성화되는지 CLI 명령어 `/skills list` 등을 통해 확인한다. (tas:3-1) [1-1]

2. 도구별 기능 동작 검증 [2]
    - 목록 조회 검증: `get_skills_list` 도구를 호출했을 때, 프로젝트의 기존 스킬 폴더 목록과 그 명세 요약 정보가 JSON/텍스트 형식으로 정상 반환되는지 확인한다. (tas:2-1) [2-1]
    - 신규 스킬 생성 검증 (Create): `create_new_skill` 도구를 유효한 파라미터로 실행했을 때 폴더가 정상 생성되고, `SKILL.md`, `config.json`, `scripts/run.ps1` 및 최초의 `HISTORY.md`가 올바르게 써졌는지 파일 내용을 검사한다. (tas:1-1, tas:1-2, tas:1-3, tas:2-2) [2-2]
    - 명명 규칙 예외 검증: `create_new_skill` 호출 시 대문자나 특수문자가 포함된 잘못된 식별자 입력 시 적절한 유효성 에러를 반환하는지 테스트한다. (tas:2-2) [2-3]
    - 기존 스킬 수정 검증 (Update): `update_existing_skill` 도구를 통해 스킬 설명을 변경한 후, 기존 `SKILL.md`가 수정되고, 수정 전 파일에 대한 안전 백업이 이루어지며, `HISTORY.md` 맨 윗부분에 신규 변경 로그가 정상 삽입(prepend)되었는지 확인한다. (tas:2-3) [2-4]
    - 기존 스킬 삭제 검증 (Delete): `delete_existing_skill` 도구를 사용하여 테스트 스킬을 삭제했을 때, 스킬 폴더가 실제로 지워지고 루트 `.gemini/config.json`의 `enabled_skills` 목록에서도 삭제되는지 확인한다. (tas:2-4) [2-5]

3. Subagent 기반 인터랙티브 시나리오 검증 (E2E) [3]
    - 테스트용 subagent를 구동하여 가상 사용자 역할을 맡기고, `skill-manager` 스킬을 탑재한 에이전트와 대화를 나누게 함으로써 질문 수집, 예시 제시, 최종 생성 및 수정에 이르는 대화가 매끄럽게 수행되는지 검증한다. (tas:2-2, tas:2-3, tas:2-4) [3-1]
    - 대화의 종료 시점(성공적인 파일 생성/수정/삭제 완료 및 config.json 반영 등)까지 대화가 안정적으로 이어지는지 모니터링한다. (tas:3-1) [3-2]



