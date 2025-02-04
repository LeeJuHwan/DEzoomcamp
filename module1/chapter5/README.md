# DEzoomcamp
Data Engineering Zoomcamp 2025

## Running postgres and pgAdmin with Docker-Compose

`postgres db`와 `pgAdmin`을 이용하기 위해 사전에 만든 도커 네트워크 그리고 빌드 된 도커 이미지 2개를 개별적으로 실행 시킨 다음 접근 했었다.

이 과정은 한 번에 이루어지지 않기 때문에 관리하기 까다롭고, 개별 도커 컨테이너 프로세스의 로그를 확인할 때 또한 컨테이너 각 각 접근 해야 하는 불편함이 있다.

그래서 해당 섹션에서는 `docker compose`를 통해 개별로 관리하던 도커 컨테이너를 관리하는 방법을 다룬다.


## Search keywords and commands

### Commands

<br>

> [!IMPORTANT]
> ***Control docker compose file***

- *Run*

    ```shell
    docker compose up
    ```

- *Stop*

    ```shell
    docker compose down
    ```

- *Run background*

    ```shell
    docker compose up -d
    ```

</br>


### Search keywords

<br>

> [!NOTE]
> ***Docker Compose***
> 
> "*Overview of Docker Compose*"

- Google search keyword: ***"docker compose"***
- Ref: [docker docs](https://docs.docker.com/compose/)

</br>
