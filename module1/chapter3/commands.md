# Module 1 hands-on commands

### PG Admin GUI by docker image

> [!NOTE]
> Google search keyword: ***"pgadmin docker "***
> Ref: [Docker hub](https://hub.docker.com/r/dpage/pgadmin4/)

```shell
docker run -it \
-e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
-e PGADMIN_DEFAULT_PASSWORD="root" \
-p 8080:80 \
dpage/pgadmin4
```

### Create network

> [!NOTE]
> Google search keyword: ***"docker network create"***
> Ref: [Docker docs](https://docs.docker.com/reference/cli/docker/network/create/)

```shell
docker network create pg-network
```

> "PgAdmin with Postgres"

- postgresql

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

- pgadmin4
```shell
docker run -it \
-e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
-e PGADMIN_DEFAULT_PASSWORD="root" \
-p 8080:80 \
--network=pg-network \
--name pg-admin \
dpage/pgadmin4
```