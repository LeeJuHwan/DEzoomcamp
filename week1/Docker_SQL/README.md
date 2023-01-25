# DEzoomcamp
Data Engineering Zoomcamp 2023

## Docker_PostgreSQL
---
- [ ] postgres 환경설정
    > postgres container set up

    - services
        - environments
        ```
        -e POSTGRES_USER="root" \
        -e POSTGRES_PASSWORD="root" \
        -e POSTGRES_DB="ny_taxi" \
        ```
            - Postgres를 사용하기 위한 환경변수 설정
                1. 사용자
                2. 패스워드
                3. 데이터베이스 이름 
        
        - volumes
            ```
            폴더 경로/ny_taxi_postgres_data:/var/lib/postgresql/data
            ```
            - volume이란?
                - 로컬 파일 시스템을 컨테이너의 파일과 매핑 시켜주는 역할을 한다.
            - 도커는 상태를 저장 하지 않기 때문에 다시 컨테이너를 불러오면 데이터를 잃게 된다.
            - 데이터 손실을 방지 하기 위해서는 위와 같은 host machine안의 폴더와 컨테이너 안의 폴더를 매핑 시켜야 하며 이러한 과정을 [`마운팅(mounting)`] 이라고 한다.

        > 마운팅 된 폴더 구조
        <img width="236" alt="image" src="https://user-images.githubusercontent.com/118493627/214562454-6ca2b7e4-2357-4ba9-8f6f-26e2ed0077f7.png">

    - 최종 코드 실행
    ```
    docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:13
    ```
    <img width="783" alt="image" src="https://user-images.githubusercontent.com/118493627/214563072-a0c3cbb0-d36e-4dfa-b208-6fbdb6fb410e.png">

#### Error를 해결한 사례
1. port number already use cases
    ```
    sudo lsof -i :5432
    sudo kill -9 [PID]
    ```
