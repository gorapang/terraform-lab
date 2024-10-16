# Terraform을 이용한 AWS S3 및 EC2 설정

<img src="https://img.shields.io/badge/Linux-FCC624?style=flat&logo=Linux&logoColor=black"/> <img src="https://img.shields.io/badge/AWS-232F3E?style=flat&logo=Amazon%20AWS&logoColor=white"/> <img src="https://img.shields.io/badge/Terraform-623CE4?style=flat&logo=Terraform&logoColor=white"/>
<img src="https://img.shields.io/badge/VSCode-007ACC?style=flat&logo=Visual%20Studio%20Code&logoColor=white"/>


## 🌐 실습 환경
Ubuntu 22.04 LTS

```bash
username@awsclient:~/s3bucket$ aws --version
aws-cli/2.18.0 Python/3.12.6 Linux/5.15.0-122-generic exe/x86_64.ubuntu.22
```

---

## ⚙️ 1. Terraform 설치 및 설정

- **root 계정으로 전환**
```bash
sudo -i
# 또는
sudo su -
```

- **Terraform 설치**
  
  Terraform 설치가 완료되면 `terraform -version` 명령어로 설치를 확인한다.
```bash
# wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# apt-get update && apt-get install terraform -y

# terraform -version

# exit
```

<br>

- **`-auto-approve`**

  Terraform이 리소스를 생성하거나 수정할 때 자동으로 승인하는 옵션
  
  `terraform apply` 시 사용자에게 별도로 "yes"를 입력하라는 프롬프트 없이 바로 실행되도록 한다.
  
```bash
terraform apply -auto-approve
```



---

## 🛡️ 2. 정책 권한 승인: `policy.tf`

- EC2 인스턴스에 필요한 IAM 역할과 S3 버킷에 대한 권한을 설정한다.
  
- **주요 작업**:
  - `aws_iam_role`: EC2 인스턴스에 필요한 역할을 생성
  - `aws_iam_policy`: S3에 대한 전체 접근 권한을 부여하는 정책을 생성
  - `aws_iam_role_policy_attachment`: IAM 역할과 정책을 연결

---

## 📦 3. 버킷 생성: `create_bucket.tf`

- S3 버킷을 생성하고, 웹사이트 호스팅과 퍼블릭 액세스 정책을 설정한다.

- **주요 작업**:
  - `aws_s3_bucket`: S3 버킷을 생성
  - `aws_s3_bucket_public_access_block`: 퍼블릭 액세스 제한을 설정
  - `aws_s3_bucket_website_configuration`: S3 버킷을 정적 웹사이트로 설정
  - `aws_s3_bucket_policy`: 퍼블릭 읽기 권한을 부여하는 정책을 추가

---

## 📄 4. 새로운 파일 업로드: `upload_new_index.tf`

- 새로운 `index.html` 파일을 S3 버킷에 업로드한다.
  
- **주요 작업**:
  - `aws_s3_object`: S3 버킷에 `index.html` 파일을 업로드

---

## ✏️ 5. 기존 파일을 수정 후 업로드: `modify_index.tf`

- 기존의 `index.html` 파일을 수정한 후 다시 S3 버킷에 업로드한다. `etag` 필드를 사용해 파일 변경 여부를 확인하고, 변경된 경우에만 업로드한다.
  
- **주요 작업**:
  - `aws_s3_object`: 수정된 `index.html` 파일을 S3에 업로드
  - `etag = filemd5("index.html")`: 파일이 변경되었는지 확인하고 재업로드를 트리거함

---

## 📂 6. 새로운 파일 업로드: `upload_main.tf`

- `main.html` 파일을 S3 버킷에 업로드한다.
  
- **주요 작업**:
  - `aws_s3_object`: 새로운 `main.html` 파일을 S3 버킷에 업로드

---
## 🌐 7. 웹사이트 엔드포인트 출력: `output.tf`

- S3 버킷의 정적 웹사이트 URL을 출력하여, 콘솔에서 바로 확인할 수 있도록 설정한다.

- **주요 작업**:
  - `output`: Terraform 작업 후 출력할 값을 설정
  - `value`: S3 버킷의 정적 웹사이트 엔드포인트를 출력
  - `description`: 출력되는 값에 대한 설명을 제공

---

## 🛠️ 실행 방법

1. **Terraform 초기화**: 프로젝트 디렉토리에서 Terraform을 초기화한다.
   ```bash
   terraform init
   ```

2. **계획 확인**: 리소스가 어떻게 생성될지 계획을 확인한다.
   ```bash
   terraform plan
   ```

3. **리소스 적용**: 각 `tf` 파일을 순서대로 실행하여 리소스를 생성하고 설정을 완료한다.
   ```bash
   terraform apply
   ```
