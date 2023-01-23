# DEzoomcamp
Data Engineering Zoomcamp 2023

## WEEK 1.
> Basic & Set up
---
- [ ] 환경설정
    - 도커 설치[MAC OS]
        - [참고자료](https://velog.io/@kimsia/Docker-m1%EC%97%90-%EB%8F%84%EC%BB%A4-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0)
        ```
        $ docker run hello-world

        latest: Pulling from library/hello-world
        7050e35b49f5: Pull complete
        Digest: sha256:aa0cc8055b82dc2509bed2e19b275c8f463506616377219d9642221ab53cf9fe
        Status: Downloaded newer image for hello-world:latest

        Hello from Docker!
        This message shows that your installation appears to be working correctly.
        ```
    - 가상화 환경 활성화
        ```
        conda activate zoom
        ```
    - 가상환경 셋팅
        ```
        pip install -r requirments.txt
        ```