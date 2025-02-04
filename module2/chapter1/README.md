# DEzoomcamp
Data Engineering Zoomcamp 2025

## Introduction to Workflow Orchestration

module1 에서 작성한 파이프라인 스크립트 내부에 여러가지 일을 수행하고 있습니다.

<img width="1452" alt="image" src="https://github.com/user-attachments/assets/e3055e65-bb6a-4044-b193-0659f4aa854a" />

이 스크립트가 파이프라인으로 작성 된 안좋은 케이스이며 이 것을 파이프라인이라고 부를 수 없습니다.

그 이유는 스크립트 내부에서 여러가지 업무를 한 번에 처리 하고 있는데, 만약 인터넷에 문제가 생겨 스크립트가 도중에 실패 했다고 가정 해봅시다.

그렇다면 어디까지 수행 됐는지 파악 하는 데 시간을 들여야하며, 그 이후부터 수행 하기 위해 소스코드를 수정해야 합니다.

