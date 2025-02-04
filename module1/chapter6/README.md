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


### Terraform Variables

기존에 만들어두었던 리소스 외에 다른 리소스를 추가로 구성하며, 리소스 정의를 확인하고 싶을 때 테라폼 공식문서를 이용하고 언제든 문서 내에 ***Required*** 필드를 검색 하여 필요한 정보가 무엇인지 확인해야한다.

설정 값 모두 변수 파일로 분리하여 관리할 수 있습니다.

Credential 변수를 등록 하지 않고 테라폼의 JSON 파일을 불러오는 함수를 이용하여 변수를 지정할 수도 있습니다.

## Search Keywords 

<br>

> [!NOTE]
> ***Google Cloud Bucket***
> 
> "*Overview of google cloud buckets*"

- Google search keyword: ***"terraform google cloud storage bucket"***
- Ref: [Terraform docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket.html)

</br>

<br>

> [!NOTE]
> ***Google Cloud Biquery Dataset***
> 
> "*Overview of google cloud bigquery dataset*"

- Google search keyword: ***"terraform bigquery dataset"***
- Ref: [Terraform docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset)

</br>

<br>

> [!NOTE]
> ***Linux environment variable unset***
> 
> "*Overview of linux unset variable*"

- Google search keyword: ***"unset variable linux"***
- Ref: [Stackoverflow](https://stackoverflow.com/questions/6877727/how-do-i-delete-an-exported-environment-variable)

</br>