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


## Setup Airflow Environment with Docker Compose

<img width="737" alt="image" src="https://github.com/user-attachments/assets/94e309db-8960-4e70-b11f-420ecbc0e16d" />

### Pre-Reqs

1. 프로젝트를 진행 할 에어플로우 표준에 맞는 설정을 해야 합니다. GCP 서비스 계정 키의 이름을 `google_crendentials.json`로 변경 하고 `$HOME` 디렉터리에 저장합니다.

```shell
mkdir -p ~/.google/credentials/
cp <path/to/your/service-account-authkey>.json ~/.google/credentials/google_credentials.json
```

2. 해당 프로젝트에서 도커 컴포즈 CLI 버전을 업데이트 해야 할 수도 있습니다. 그리고 에어플로우를 도커 환경에서 사용하고 위해 최소 5GB (권장 8GB) 메모리를 설정합니다. 만약, 메모리가 부족하다면 에어플로우 웹 서버(GUI)가 계속 재시작 될 것입니다.

<img width="834" alt="image" src="https://github.com/user-attachments/assets/1b5aecdf-81d2-4fab-be39-ed4c4713edba" />


### Airflow Setup

1. 프로젝트를 진행하는 디렉터리 내에 `airflow` 라는 디렉터리를 생성 합니다.

2. 에어플로우 공식 이미지를 다운로드 받습니다.

    ```shell
    mkdir airflow && cd airflow
    curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'
    ```

3. 리눅스에서 도커 컴포즈를 활용 하여 실행 할 경우 유저 권한을 설정 해야 합니다. 유저 권한을 별도로 설정하지 않는 경우 `dag`, `log.`, `plugin` 과 같은 특정 에어플로우 디렉터리에 생성된 파일은 루트 사용자의 권한으로 생성 됩니다.

    ```shell
    mkdir -p ./dags ./logs ./plugins
    echo -e "AIRFLOW_UID=$(id -u)" > .env
    ```

    - dags : DAG 파일 보관(Airflow를 활용한 배치 스크립트 파일)

    - logs : Task 실행 시, 혹은 Scheduler의 로그 보관

    - plugins : 커스텀 Plugin 보관(Dag에서 사용할 수 있는 유틸 함수)

4. GCloud CLI 툴을 설치하는 도커 파일을 별도로 구성하여 해당 도커 파일을 활용 하여 도커 컴포즈를 구성합니다.
    - Ref: [Airflow Docs](https://airflow.apache.org/docs/docker-stack/recipes.html#google-cloud-sdk-installation)

5. 도커 환경에서 필요한 라이브러리 파일을 생성 합니다.

    ```
    apache-airflow-providers-google
    pyarrow
    ```

6. 에어플로우에서 제공 하는 도커 컴포즈 파일 내에 예시 태스크들을 표시 하지 않도록 설정합니다.
    - `AIRFLOW__CORE__LOAD_EXAMPLES: 'false'`


### Trouble Shooting

> [!CAUTION]
> "*You are running pip as root. Please use 'airflow' user to run pip!*"
> - `USER root` 로 소프트웨어를 업데이트 하고 필요한 패키지를 설치한 뒤 파이썬 라이브러리를 설치하는데 이 때 에어플로우를 설치할 때 에러가 발생한다. 그렇기 때문에 해당 라이브러리를 설치할 때만 에어플로우 유저로 접근하고 그 외 작업은 다시 루트 유저로 진행 하면 된다.
> - [Ref](https://stackoverflow.com/questions/72102582/airflowdocker-composeyou-are-running-pip-as-root-please-use-user-to-run-pip) 
> 
> "*No module named 'imp'*"
> - Google Cloud CLI 를 설치하는 과정에서 해당 모듈을 찾지 못했다. `322.0.0` 버전에서 해당 SDK를 설치할 때 사용했던 모듈이지만 파이썬 버전이 올라오면서 모듈이 제거 되었다. SDK 버전을 최신 버전으로 변경 하면 된다.
> - [Ref](https://cloud.google.com/sdk/docs/release-notes#google_cloud_cli)

