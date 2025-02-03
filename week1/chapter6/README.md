# DEzoomcamp
Data Engineering Zoomcamp 2025


## Terraform with GCP

### Initial setup

1. Create an account with google id - "my gmail"
2. Setup new project - "de-zommcamp-2025"
3. Setup IAM user - "jhlee-infra"
    - role: `Big Query Admin`, `Storage Directory Admin`, `Compute Admin`
4. Install gcloud sdk by [docs](https://cloud.google.com/sdk/docs/install-sdk)
5. Set environment variable gcp key
    - `export GOOGLE_APPLICATION_CREDENTIALS={path.json}`
6. Refresh service-account's auth-token for this session
    - `gcloud auth application-default login`


### Terraform Basics

GCP 회원가입과 간단한 IAM 유저를 생성하여 앞으로 진행할 프로젝트에 대한 권한을 설정한다.

프로바이더에 대한 기본적인 설정을 마쳤다면 테라폼을 이용하기 위한 기본 구성을 작성한다.

실습 예제는 검색 키워드 결과인 `google cloud bucket` 이며 테라폼의 워크플로우를 경험 해보기 위한 리소스이다.


## Search Keywords 

<br>

> [!NOTE]
> ***Google Cloud Bucket***
> 
> "*Overview of google cloud buckets*"

- Google search keyword: ***"terraform google cloud storage bucket"***
- Ref: [Terraform docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket.html)

</br>
