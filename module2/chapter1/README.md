# DEzoomcamp
Data Engineering Zoomcamp 2025

## Introduction to Workflow Orchestration

module1 에서 작성한 파이프라인 스크립트 내부에 여러가지 일을 수행하고 있습니다.

<img width="1452" alt="image" src="https://github.com/user-attachments/assets/e3055e65-bb6a-4044-b193-0659f4aa854a" />

이 스크립트가 파이프라인으로 작성 된 안좋은 케이스이며 이 것을 파이프라인이라고 부를 수 없습니다.

그 이유는 스크립트 내부에서 여러가지 업무를 한 번에 처리 하고 있는데, 만약 인터넷에 문제가 생겨 스크립트가 도중에 실패 했다고 가정 해봅시다.

그렇다면 어디까지 수행 됐는지 파악 하는 데 시간을 들여야하며, 그 이후부터 수행 하기 위해 소스코드를 수정해야 합니다.

![image](https://github.com/user-attachments/assets/af803d55-4e6a-493c-acff-c6db0560f96b)

위 이미지 처럼 데이터 파이프라인은 각 단계가 순차적으로 진행 되며 단계마다 이전 작업에 대해 의존성을 갖을 수 있습니다. 
만약, 작업을 수행 하던 도중 실패 했다면 해당 단계에서 다시 실행할 수 있는 "Backfill" 정책을 제공합니다.

이런 데이터 워크플로우를 수행하기 편리하게 제공하는 툴들이 존재 합니다.
일반적인 스크립트 파일을 Make 컴파일러로 수행할 수 있지만 이렇게 구성할 경우 더 작은 스크립트들을 관리하기 때문에 확장하는데 불편함이 있습니다.

아래 많은 툴들이 존재 하지만 국내에서 가장 많이 사용되는 에어플로우로 워크플로를 구성합니다. 해당 모듈은 ***2022년 자료*** 를 기반으로 진행 합니다.

> [!TIP]
> - luigi
> - **Apache Airflow(DE 2022)**
> - Prefect(DE 2023)
> - Mage(DE 2024)
> - Kestra(DE 2025)
