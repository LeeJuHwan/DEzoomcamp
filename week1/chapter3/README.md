# DEzoomcamp
Data Engineering Zoomcamp 2023

## Docker_PgAdmin
---
### Docker Image built(PgAdmin)
- copy this

    <img width="431" alt="image" src="https://user-images.githubusercontent.com/118493627/215729751-87c0ccf0-7cf6-4725-880e-ba22af512870.png">

- docker built

    ```
    docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    dpage/pgadmin4
    ```
    - `PgAdmin params`
    - PGADMIN_DEFAULT_EMAIL 
    - PGADMIN_DEFAULT_PASSWORD

    - Port mapping
    
        - host machine의 8080 포트를 컨테이너의 80포트와 매핑

        - pgAdmin은 80포트를 리스닝`(listening)`하고 있다

    - PgAdmin create server

    <img width="551" alt="image" src="https://user-images.githubusercontent.com/118493627/215747058-fed747bc-3776-4ef2-8355-38f1063e08ac.png">

    - Name 

    <img width="644" alt="image" src="https://user-images.githubusercontent.com/118493627/215747321-1457e4c9-17a2-4ea0-a338-3c9a213503b8.png">

    - Connection

    <img width="654" alt="image" src="https://user-images.githubusercontent.com/118493627/215747819-e1459294-6509-4790-bf5a-18d32ea9b97d.png">

- terminal

    <img width="742" alt="image" src="https://user-images.githubusercontent.com/118493627/215733219-8cf4bbaa-1a5a-44a7-9cf5-8a74e87e0b4a.png">


- localhost connect

    <img width="1199" alt="image" src="https://user-images.githubusercontent.com/118493627/215732810-e12c3317-5214-4848-b6ac-068996e46f9e.png">

- docker Network

    ```
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
    <img width="1084" alt="image" src="https://user-images.githubusercontent.com/118493627/215735962-7b14bd82-d8c0-4804-aec0-6e903f63f383.png">

    - Docker Network를 실행 하기 위해서는 현재 띄워놓은 Container를 중단 해야한다.
        - 이제 Postgres 컨테이너를 띄울 때 해당 컨테이너는 이 네트워크 안에서 실행되어야한다고 명시해주어야한다.
    

- PGCLI restart
    ```
    pgcli -h localhost -p 5432 -u root -d ny_taxi
    ```

- result
<img width="1153" alt="image" src="https://user-images.githubusercontent.com/118493627/215744457-9b6af0a1-bef6-48db-917e-e854d9c68519.png">