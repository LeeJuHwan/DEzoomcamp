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

- [ ] pgcli(Postgres command line interface)
    > this is python librar.y use for postgresql connect

    ```
    1. pip instsall pgcli

    2. brew install pgcli (Mac OS)
    ```
    - brew를 통해 설치 하였다.
    <p>

    #### 포트 접속
    ```
    pgcli -h localhost -p 5432 -u root -d ny_taxi
    ```
    - postgres cli 접속

        - -h : 호스트
        - -p : 포트 번호
        - -u : 유저 이름
        - -d : 데이터 베이스 이름(도커 컨테이너 실행시 입력한 db이름)
    - <strong> services에서 설정 된 비밀번호인 [`root`]를 입력하였다.</strong>

    #### 데이터베이스 조회
    ```
    \dt
    ```
    <img width="269" alt="image" src="https://user-images.githubusercontent.com/118493627/214603417-bd04ecef-7c27-4bfa-834b-7322974bdcdb.png">

    #### 데이터 확인 및 불러오기 by Jupyter Notebook
    - [ ] 자료 준비
    - [백업 자료 레포지토리](https://github.com/DataTalksClub/nyc-tlc-data/releases/tag/yellow)

    - 데이터 불러오기
        ```
        wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz
        ```
    - 압축해제
        ```
        gzip -d yellow_tripdata_2021-01.csv.gz
        ```

    - 샘플 데이터 추출 후 확인하기
        ```
        head -n 100 yellow_tripdata_2021-01.csv > yello_head.csv
        ```

    - CLI 환경에서 CSV파일을 열지 않고 record 수 확인하기
        ```
        wc -l yellow_tripdata_2021-01.csv
        ```

    - 컬럼의 의미 파악하기
    
        <img width="710" alt="image" src="https://user-images.githubusercontent.com/118493627/214612832-b6bb82b7-6e51-4f94-857f-61fc5816db52.png">

        - VendorID는 TPEP providor를 의미한다고 한다.
            - 1은 Creative Mobile Tech 회사, 2는 VeriFone Inc. 회사.
        - tpep_pickup_datetime은 승객을 태운 시점
        - tpep_dropoff_datetime은 승객을 내려준 시점
        - Passenger_count는 탑승한 승객 수
        - Trip distance는 택시미터에 찍힌 여행 거리를 의미
        - PULocationID는 승객이 탄 곳의 위치(Taxi zone) id를 의미
        - DOLocationID는 승객이 내린 곳의 위치(Taxi zone) id를 의미
            - 이 위치 id에 해당하는 위치를 확인하기 위해서는 Taxi zone lookup table 데이터가 필요하다.
            - <u>Taxi zone lookup table</u> 데이터 불러오기
    
                ```
                wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
                ```

        - [참고 블로그 : 번역 해주셔서 감사합니다](https://velog.io/@dainlinda/Week-1-%EA%B8%B0%EC%B4%88%EC%99%80-%ED%99%98%EA%B2%BD-%EC%85%8B%ED%8C%85)
    - [ ] 데이터 다루기
    - 데이터프레임이 갖고 있는 필드의 스키마 가져오기
        ```
        pd.io.sql.get_schema(df, name = "yellow_taxi_data")
        ```
    - 텍스트로 되어 있는 날짜 데이터 처리
        ```
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
        ```
        <img width="758" alt="image" src="https://user-images.githubusercontent.com/118493627/214616709-314cc76e-a8ab-4dfd-a668-d32343873dc0.png">

    - 데이터 volume이 많을 때 
        - db가 어떻게 반응 할지 모르기 때문에 iterator 형태로 입력 하는 방법
        - 사전 작업
        ```
        df_iter = pd.read_csv("yellow_tripdata_2021-01.csv", iterator= True, chunksize=100000)
        ```
        - chunksize = "데이터 덩어리" 몇 개의 데이터를 한 번의 실행으로 다룰지 결정
        - iterator = 객체 형식으로 데이터 타입을 만들지 결정
        - iteraotr 호출 
        ```
        df = next(df_iter)

        len(df)
        >> 100000
        ```
        - 이 명령어를 사용하면 우리가 데이터를 읽을 때 전체를 읽어오는 게 아니라 한번에 100000개 row로 이루어진 데이터 개수의 하나를 읽어온다
        - df_iter를 호출하면 일반 판다스 데이터 프레임 형태가 아닌 객체 형태를 나타낸다.`<pandas.io.parsers.readers.TextFileReader at 0x7fc138875a00>`

    #### 데이터를 chunksize로 불러오기
    - 객체를 호출하면서 시간 측정 하기
        ```
        while True :
        t_start = time()
        
        df = next(df_iter)
        
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
        
        df.to_sql(name = "yellow_taxi_data", con = engine, if_exists="append")
        
        t_end = time()
        
        print(f" 다른 데이터 덩어리를 넣었을 때 걸리는 시간 {t_end - t_start:.3f}")
        ```
        - 데이터베이스를 모두 삽입하고 난 결과
        <img width="508" alt="image" src="https://user-images.githubusercontent.com/118493627/215664064-a0d43a51-90d9-4c98-ab62-f67fec2d32e7.png">


### Error를 해결한 사례
1. port number already use cases
    ```
    sudo lsof -i :5432
    sudo kill -9 [PID]
    ```


