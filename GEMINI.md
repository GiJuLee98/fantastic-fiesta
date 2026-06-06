# GEMINI.md

- When reading file contents (such as `.txt`, `.md`, `.cpp`, `.h`), always specify UTF-8 encoding explicitly (e.g., use `Get-Content -Encoding utf8` in PowerShell) to prevent character corruption.

- 버전 : 0.0.1

## Language
- 사용자에게는 항상 한국어로 응답한다.

## 주요 작업 흐름

- 아래의 작업 흐름을 RDTVE(Requirements->Design->Tasks->Validation->Execution) 작업이라고 부른다.

```text
requirements -> design -> tasks -> validation -> execution
```

- 최초에 사용자가 작업을 요청하면, 가장 먼저 requirements.md 파일 생성 여부를 사용자에게 묻는다.
- 사용자가 requirements.md 파일 생성을 거부하면, 별도 파일 및 폴더를 생성하지 않고 바로 해당 작업을 실시하고 사용자에게 결과를 보고한다.
- 사용자가 requirements.md 파일 생성을 수락하면, 위의 RDTVE 작업 흐름에 따라 requirements 단계를 진행한다.

### 파일 생성 규칙

RDTVE 작업으로 생성하는 각 md 파일은 다음 규칙에 맞게 작성한다.

- 제목(Title)을 제외한 모든 항목에는 문장 끝에 [인덱스] 를 붙인다.
- 인덱스는 [1], [1-1], [1-1-1] 와 같이 항목의 계층에 따라 자릿수를 구분한다.
- 이전 단계의 인덱스를 명시할때는 (단계명:인덱스) 형태로 명시한다.
    - 단계명은 req, des, tas, val 중 하나이다.

예시 (tasks.md)

```markdown
# 000-workid: tasks

1. 항목 (des:1) [1]
    - 하위 항목 (des:1-1) [1-1]
    - 하위 항목 (des:1-2) [1-2]
        - 하위 항목 (des:1-2-1) [1-2-1]

2. 항목 (des:2) [2]

3. 항목 (des:3, 4) [3]

```

### requirements

requirements 단계에서는 다음 세부 순서를 따른다.

1. 적절한 workid 를 선정한다.
2. docs/000-workid/ 폴더를 생성한다.
3. docs/000-workid 폴더 안에 requirements.md, design.md, tasks.md, validation.md, execution.md 파일을 모두 빈 상태로 생성한다.
4. requirements.md 파일에 사용자 요구사항을 작성한다.

### design

design 단계에서는 requirements.md 파일을 기반으로 design.md 파일에 구현 설계 내용을 작성한다.

각 design 항목은 requirements.md 항목의 어떤 인덱스에 기반한 내용인지 명시한다.

완료 후 모든 requirements.md 항목이 다뤄졌는지 검토한다.

### tasks

tasks 단계에서는 design.md 파일을 기반으로 tasks.md 파일에 구현 상세 내용을 작성한다.

각 task 항목은 design.md 항목의 어떤 인덱스에 기반한 내용인지 명시한다.

완료 후 모든 design.md 항목이 다뤄졌는지 검토한다.

### validation

validation 단계에서는 tasks.md 파일을 기반으로 validation.md 파일에 상세 검증 계획을 작성한다.

각 validation 항목은 tasks.md 항목의 어떤 인덱스에 기반한 내용인지 명시한다.

완료 후 모든 tasks.md 항목이 다뤄졌는지 검토한다.

### execution

execution 단계에서는 다음 루프를 진행한다.

```text
0. main agent는 새로운 두 subagent(A, B)를 생성한다.
    - subagent(A): tasks.md 의 각 항목을 실행하는 subagent.
    - subagent(B): (A)가 실행한 내용을 validation.md의 검증 계획에 맞게 검증하고 execution.md 파일에 검증결과를 작성하는 subagent.
1. main agent는 아직 실행되지 않은 다음 검증할 항목(들)을 validation.md 에서 선정한다.
2. subagent(A)에게 validation.md 의 선정된 항목에 대응되는 tasks.md 의 항목을 실행하도록 지시한다.
3. subagent(A)의 실행이 완료되면, subagent(B)에게 validation.md 의 현재 차례의 항목에 대한 validation을 실행하고 execution.md 파일에 검증결과를 작성하도록 지시한다. (각 항목에는 validation.md의 인덱스를 명시한다)
    - 실패한 경우 2번으로 돌아가서, subagent(A)에게 (B)의 피드백을 전달하고 subagent(A)에게 실행 내용을 수정/보완하도록 지시한다.
    - 총 실패 횟수가 3회를 초과하면 진행을 중단하고 사용자에게 실패 항목과 관련 내용을 보고한다.
4. 모든 항목에 대해 1~3번을 반복한다.
5. 모든 실행 및 검증이 완료되면 main agent는 두 subagent를 종료한다.
```

생성하는 각 subagent는 Gemini 3.5 Flash (Low) 모델을 사용한다.

subagent 생성에 실패한 경우 진행을 중단하고 사용자에게 보고한다.

### 사용자 피드백

다음 시점에 사용자에게 다음 내용을 보고하고 다음 응답을 기다린다.

- requirements 단계 완료 직후
    - requirements.md 파일 검토 및 승인 여부
- design 단계 완료 직후
    - design.md 파일 검토 및 승인 여부
- tasks 단계 완료 직후
    - tasks.md 파일 검토 및 승인 여부
- validation 단계 완료 직후
    - validation.md 파일 검토 및 승인 여부
- execution 단계 완료 직후
    - execution.md 파일 검토 및 최종 승인 여부
    - subagent의 검증 실패 항목 및 요약

사용자가 최초에 requirements.md 파일 생성을 거부한 경우에는 현재 진행한 작업을 상세하게 보고한다.

## 빌드 규칙

- 향후 에이전트가 이 프로젝트를 빌드할 때는 `scripts/build_all_configs.ps1` 스크립트를 사용하여 빌드해야 합니다.
