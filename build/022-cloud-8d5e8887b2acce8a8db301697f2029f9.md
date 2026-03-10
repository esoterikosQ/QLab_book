# 1.2.3. 클라우드 플랫폼

클라우드 플랫폼은 인터넷을 통해 서버, 스토리지, 데이터베이스, 네트워킹, 소프트웨어 등의 컴퓨팅 리소스를 제공하는 서비스입니다.

## 1.2.3.1. Google Cloud Platform (GCP)

### gcloud CLI 설치 (Ubuntu 24.04)

```bash
# Google Cloud SDK 설치
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt update
sudo apt install google-cloud-cli

# 초기화 및 인증
gcloud init
gcloud auth login
```

### 주요 서비스

#### Compute Engine (VM 인스턴스)

```bash
# VM 인스턴스 생성
gcloud compute instances create my-instance \
  --zone=us-central1-a \
  --machine-type=e2-medium \
  --image-family=ubuntu-2404-lts-amd64 \
  --image-project=ubuntu-os-cloud

# SSH 접속
gcloud compute ssh my-instance --zone=us-central1-a

# 인스턴스 중지/시작
gcloud compute instances stop my-instance --zone=us-central1-a
gcloud compute instances start my-instance --zone=us-central1-a

# 인스턴스 삭제
gcloud compute instances delete my-instance --zone=us-central1-a
```

#### Cloud Storage

```bash
# 버킷 생성
gcloud storage buckets create gs://my-bucket-name --location=us-central1

# 파일 업로드
gcloud storage cp local-file.txt gs://my-bucket-name/

# 파일 다운로드
gcloud storage cp gs://my-bucket-name/file.txt ./

# 디렉토리 동기화
gcloud storage rsync -r ./local-dir gs://my-bucket-name/remote-dir

# 버킷 목록
gcloud storage ls

# 파일 목록
gcloud storage ls gs://my-bucket-name/
```

#### Cloud Run (서버리스 컨테이너)

```bash
# 컨테이너 배포
gcloud run deploy my-service \
  --image gcr.io/project-id/image:tag \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated

# 서비스 목록
gcloud run services list

# 서비스 삭제
gcloud run services delete my-service --region=us-central1
```

## 1.2.3.2. Amazon Web Services (AWS)

### AWS CLI 설치

```bash
# AWS CLI v2 설치
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# 설정
aws configure
# AWS Access Key ID: [YOUR_ACCESS_KEY]
# AWS Secret Access Key: [YOUR_SECRET_KEY]
# Default region name: us-east-1
# Default output format: json
```

### 주요 서비스

#### EC2 (가상 서버)

```bash
# 인스턴스 목록
aws ec2 describe-instances

# 인스턴스 시작
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --key-name MyKeyPair \
  --security-groups my-sg

# 인스턴스 중지
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# 인스턴스 종료
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

#### S3 (스토리지)

```bash
# 버킷 생성
aws s3 mb s3://my-bucket-name

# 파일 업로드
aws s3 cp file.txt s3://my-bucket-name/

# 파일 다운로드
aws s3 cp s3://my-bucket-name/file.txt ./

# 디렉토리 동기화
aws s3 sync ./local-dir s3://my-bucket-name/remote-dir

# 버킷 목록
aws s3 ls

# 파일 목록
aws s3 ls s3://my-bucket-name/
```

## 1.2.3.3. Microsoft Azure

### Azure CLI 설치

```bash
# Azure CLI 설치
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# 로그인
az login

# 구독 목록
az account list --output table

# 기본 구독 설정
az account set --subscription "Subscription Name"
```

### 주요 서비스

#### Virtual Machines

```bash
# 리소스 그룹 생성
az group create --name myResourceGroup --location eastus

# VM 생성
az vm create \
  --resource-group myResourceGroup \
  --name myVM \
  --image Ubuntu2404 \
  --admin-username azureuser \
  --generate-ssh-keys

# VM 시작/중지
az vm start --resource-group myResourceGroup --name myVM
az vm stop --resource-group myResourceGroup --name myVM

# VM 삭제
az vm delete --resource-group myResourceGroup --name myVM
```

#### Blob Storage

```bash
# 스토리지 계정 생성
az storage account create \
  --name mystorageaccount \
  --resource-group myResourceGroup \
  --location eastus \
  --sku Standard_LRS

# 컨테이너 생성
az storage container create \
  --account-name mystorageaccount \
  --name mycontainer

# 파일 업로드
az storage blob upload \
  --account-name mystorageaccount \
  --container-name mycontainer \
  --name myblob \
  --file ./file.txt
```

## 1.2.3.4. Jupyter Notebook 클라우드 환경

### Google Colab

Google Colab은 무료 Jupyter 노트북 환경을 제공합니다.

```python
# Google Drive 마운트
from google.colab import drive
drive.mount('/content/drive')

# GPU 확인
import tensorflow as tf
print("Num GPUs Available: ", len(tf.config.list_physical_devices('GPU')))

# 패키지 설치
!pip install package-name

# 셸 명령 실행
!ls -la
!wget https://example.com/data.csv
```

### Kaggle Notebooks

Kaggle은 데이터 과학 경진대회와 함께 무료 Jupyter 환경을 제공합니다.

```python
# Kaggle 데이터셋 로드
import pandas as pd
df = pd.read_csv('/kaggle/input/dataset-name/file.csv')

# GPU/TPU 사용
import tensorflow as tf
print("Available devices:", tf.config.list_physical_devices())
```

### JupyterHub on Kubernetes

```bash
# Helm으로 JupyterHub 설치
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update

# config.yaml 생성
cat <<EOF > config.yaml
hub:
  config:
    Authenticator:
      admin_users:
        - admin
    DummyAuthenticator:
      password: changeme

singleuser:
  image:
    name: jupyter/datascience-notebook
    tag: python-3.13
EOF

# 설치
helm install jupyterhub jupyterhub/jupyterhub \
  --namespace jhub \
  --create-namespace \
  --values config.yaml
```

## 1.2.3.5. 비용 관리

### GCP 예산 알림 설정

```bash
# 예산 생성 (API 사용)
gcloud billing budgets create \
  --billing-account=BILLING_ACCOUNT_ID \
  --display-name="Monthly Budget" \
  --budget-amount=100USD \
  --threshold-rule=percent=50 \
  --threshold-rule=percent=90 \
  --threshold-rule=percent=100
```

### AWS 비용 모니터링

```bash
# 비용 탐색기 (Cost Explorer) 사용
aws ce get-cost-and-usage \
  --time-period Start=2024-03-01,End=2024-03-31 \
  --granularity MONTHLY \
  --metrics "BlendedCost"

# 예산 생성
aws budgets create-budget \
  --account-id 123456789012 \
  --budget file://budget.json
```

### 리소스 최적화 팁

```bash
# 미사용 리소스 확인
# GCP
gcloud compute instances list --filter="status:TERMINATED"

# AWS
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=stopped" \
  --query 'Reservations[].Instances[].[InstanceId,State.Name]' \
  --output table

# 스냅샷 정리 (AWS)
aws ec2 describe-snapshots --owner-ids self \
  --query 'Snapshots[?StartTime<=`2023-01-01`].[SnapshotId,StartTime]' \
  --output table
```

## 1.2.3.6. 데이터 과학 워크플로우

### 클라우드 기반 머신러닝

```python
# Vertex AI (GCP) 사용 예제
from google.cloud import aiplatform

aiplatform.init(project='my-project', location='us-central1')

# 모델 학습
job = aiplatform.CustomTrainingJob(
    display_name="training-job",
    script_path="train.py",
    container_uri="gcr.io/cloud-aiplatform/training/tf-cpu.2-13:latest",
    requirements=["pandas", "scikit-learn"],
)

job.run(
    replica_count=1,
    machine_type="n1-standard-4",
)
```

### 배치 처리

```bash
# GCP Dataflow (Apache Beam)
python -m apache_beam.examples.wordcount \
  --input gs://dataflow-samples/shakespeare/kinglear.txt \
  --output gs://my-bucket/counts \
  --runner DataflowRunner \
  --project my-project \
  --region us-central1 \
  --temp_location gs://my-bucket/tmp/
```
