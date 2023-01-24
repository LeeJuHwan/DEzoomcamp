# DEzoomcamp
Data Engineering Zoomcamp 2023

## WEEK 1.
> Basic & Set up
---
- [ ] 환경설정
    - 도커 설치[MAC OS]
        - [설치 설명 블로그](https://velog.io/@kimsia/Docker-m1%EC%97%90-%EB%8F%84%EC%BB%A4-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0)
        ```
        $ docker run hello-world

        latest: Pulling from library/hello-world
        7050e35b49f5: Pull complete
        Digest: sha256:aa0cc8055b82dc2509bed2e19b275c8f463506616377219d9642221ab53cf9fe
        Status: Downloaded newer image for hello-world:latest

        Hello from Docker!
        This message shows that your installation appears to be working correctly.
        ```
    - 도커 이미지 상호작용
        - [유튜브 링크](https://www.youtube.com/watch?v=EYNwNlOrpr0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb)
        ```
        docker run -it ubuntu bash

        Unable to find image 'ubuntu:latest' locally
        latest: Pulling from library/ubuntu
        10175de2f0c4: Pull complete
        Digest: sha256:27cb6e6ccef575a4698b66f5de06c7ecd61589132d5a91d098f7f3f9285415a9
        Status: Downloaded newer image for ubuntu:latest
        root@cb4d8d123eeb:/#
        ```
        > What is " docker run it ubuntu bash "
        - [데이터 엔지니어 기술 블로그](https://velog.io/@dainlinda/Week-1-%EA%B8%B0%EC%B4%88%EC%99%80-%ED%99%98%EA%B2%BD-%EC%85%8B%ED%8C%85)
        - docker run : 실행
        - it : 상호작용
        - ubuntu : 이미지
        - bash : 파라미터 
    ---
    - 도커 실습 #1
        | os remove and load new container
        ```
        # 최상위 권한의 시스템 강제 삭제
        rm -rf / --no-preserve-root
        --> 앞으로의 컨테이너는 사용이 불가능한 상태이다.

        exit

        # 원상복구
        docker run -it ubuntu bash
        
        ```
    - 도커 실습 #2 
    | use Python
        ```
        docker run -it python:3.9
        Python 3.9.16 (main, Jan 23 2023, 23:47:45)
        [GCC 10.2.1 20210110] on linux
        Type "help", "copyright", "credits" or "license" for more information.

        >>> print("hello world!")
        hello world!

        >>> import pandas
        no module named "pandas"

        # 컨테이너에서 install 하지 않고 bash에서 install 해야한다.
        docker run -it --entrypoint=bash python:3.9
        root@c02367bd12a2:/# pip install pandas
        ```
        <img width="976" alt="image" src="https://user-images.githubusercontent.com/118493627/214312803-40f3c1b9-54d5-47bc-99bb-91ac9b99e977.png">

        ```
        root@c02367bd12a2:/# python
        Python 3.9.16 (main, Jan 23 2023, 23:47:45)
        [GCC 10.2.1 20210110] on linux
        Type "help", "copyright", "credits" or "license" for more information.

        >>> import pandas
        >>> pandas.__version__
        '1.5.3' 
        ```
        - 판다스 설치 후 컨테이너 환경을 다시 불러오면 모든게 초기화 되어 있기 때문에 판다스 라이브러리를 임포트 하여도 불러지지 않는다.
    
- [ ] Dockerfile 작성하기
    - Write code in Dockerfile and build image
    ```
    FROM python:3.9

    RUN pip install pandas

    ENTRYPOINT [ "bash" ] 
    ```
    - entrypoint bash : 컨테이너를 불러올 때 상시 prompt를 bash로 설정

    ```
    docker build -t test:pandas .
    ```
    - build : docker 파일로부터 이미지 생성
    - -t : 태그명 사용
    - test:pandas :  생성 할 이미지 이름 : 태그
    - . : 상대경로 현재 위치
    <img width="1431" alt="image" src="https://user-images.githubusercontent.com/118493627/214316760-b3a45548-c8ac-486c-bf3c-1cacf5eaaab7.png">

    > Docker build and run 
    - import pandas 부분을 보면, install 된 것을 확인 할 수 있다.
    ```
    docker run -it test:pandas
    root@1c60133f140d:/# python
    Python 3.9.1 (default, Feb  9 2021, 15:26:01)
    [GCC 8.3.0] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import pandas
    >>>
    ```

- [ ] Dockerfile과 Pipeline
    - pipeline is auto load python script
    #### pipeline
    ```
    import sys

    import pandas as pd

    print(sys.argv)

    day = sys.argv[1]

    # some fancy stuff with pandas

    print(f"job finished successfully for day = {day}")

    docker build -t test:pandas .
    docker run -it test:pandas 2023-01-24
    ['pipeline.py', '2023-01-24']
    job finished successfully for day = 2023-01-24
    ```

    #### Dockerfile
    ```
    FROM python:3.9.1

    RUN pip install pandas

    WORKDIR /app
    COPY pipeline.py pipeline.py

    ENTRYPOINT [ "python", "pipeline.py" ] 
    ```
    <img width="480" alt="image" src="https://user-images.githubusercontent.com/118493627/214324994-87b66f3a-04cc-41bb-9655-1f657ecb7a23.png">
    
    - COPY : pipeline.py 라는 파일을 pipeline.py 라고 컨테이너에 넣어준다.( 첫번째 인자는 로컬 파일, 두번째 인자는 컨테이너에서 사용 될 파일)
    - WORKDIR : 직역 그대로 작업영역 폴더이다. 폴더명을 지정하면 컨테이너를 불러왔을 때 그 폴더 내부에서 작업을 할 수 있게 된다.


