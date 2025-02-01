# DEzoomcamp
Data Engineering Zoomcamp 2025

## Dockerizing the Ingestion Script

주피터 노트북을 통해 스크립트를 단계 별로 실행 했던 파이프라인을 파이썬 파일로 통합한다.

해당 파이썬 파일을 로컬에서 실행 하고 데이터를 추가 하며 테스트를 거친 뒤 컨테이너화 하여 이미지를 빌드하고 실행 한다.
- 이 때, 실행 명령어를 로컬 파이썬 실행 하듯이 host를 설정하고 실행 하게 되면 컨테이너 자기 자신을 가르키고 있기 때문에 실행이 실패한다. host를 도커 네트워크로 변경 해야 한다는 것을 잊지 말아야한다.


## Get start before!!

1. Create docker network

    ```shell
    docker network create pg-network
    ```

2. Run postgres database

    ```shell
    docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    --network=pg-network \
    --name pg-database \
    postgres:13
    ```

3. PgAdmin GUI hosting

    ```shell
    docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    dpage/pgadmin4
    ```



## Search keywords and commands

### Commands

> [!IMPORTANT]

***how to run pipeline command***

```shell

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

python3 ingest_data.py \
    --user=root \
    --password=root \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}
```

> [!IMPORTANT]

***Docker build and run we're pipeline script***

> "Build"

```shell
docker build -t taxi_ingest:v001 .
```

> "Run"

```shell
docker run -it \
    --network=pg-network \
    taxi_ingest:v001 \
        --user=root \
        --password=root \
        --host=pg-database \
        --port=5432 \
        --db=ny_taxi \
        --table_name=yellow_taxi_trips \
        --url=${URL}
```

### Search keywords

> [!NOTE]
***argparse***

- "*How to run script use arguments*"

> Google search keyword: ***"argparse"***
> Ref: [Python docs](https://docs.python.org/ko/3.13/library/argparse.html)

> [!NOTE]
***main block***

- "*Why need `if __name__ == "__main__"` block?*"

> Google search keyword: ***"main block python"***
> 
> Ref: [Python docs](https://docs.python.org/3/library/__main__.html)

> [!NOTE]
***psycopg2***

- "*Why install `psycopg2` in Dockerfile*"

> Google search keyword: ***"psycopg2"***
> 
> Ref: [Python docs](https://docs.python.org/3/library/__main__.html)

