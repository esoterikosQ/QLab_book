# 1.2.2. Docker

Docker는 애플리케이션을 컨테이너로 패키징하여 일관된 환경에서 실행할 수 있게 해주는 플랫폼입니다.

## 1.2.2.1. Docker 설치 (Ubuntu 24.04)

```bash
# 기존 버전 제거
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt remove $pkg
done

# Docker 공식 GPG 키 추가
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Docker repository 추가
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker 설치
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 사용자를 docker 그룹에 추가 (sudo 없이 사용)
sudo usermod -aG docker $USER
newgrp docker
```

## 1.2.2.2. Docker 기본 명령어

### 이미지 관리

```bash
# 이미지 검색
docker search ubuntu

# 이미지 다운로드
docker pull ubuntu:24.04
docker pull python:3.13-slim

# 이미지 목록
docker images

# 이미지 삭제
docker rmi IMAGE_ID
```

### 컨테이너 실행

```bash
# 컨테이너 실행
docker run -it ubuntu:24.04 /bin/bash

# 백그라운드 실행
docker run -d --name mycontainer ubuntu:24.04 sleep infinity

# 포트 포워딩과 볼륨 마운트
docker run -d -p 8888:8888 -v $(pwd):/workspace jupyter/datascience-notebook

# 환경 변수 전달
docker run -e POSTGRES_PASSWORD=secret -d postgres:16
```

### 컨테이너 관리

```bash
# 실행 중인 컨테이너 확인
docker ps

# 모든 컨테이너 확인
docker ps -a

# 컨테이너 중지
docker stop CONTAINER_ID

# 컨테이너 시작
docker start CONTAINER_ID

# 컨테이너 재시작
docker restart CONTAINER_ID

# 컨테이너 삭제
docker rm CONTAINER_ID

# 실행 중인 컨테이너에 접속
docker exec -it CONTAINER_ID /bin/bash

# 컨테이너 로그 확인
docker logs CONTAINER_ID
docker logs -f CONTAINER_ID  # 실시간 로그
```

## 1.2.2.3. Dockerfile 작성

### Python 3.13 개발 환경

```dockerfile
FROM python:3.13-slim

# 작업 디렉토리 설정
WORKDIR /app

# 시스템 패키지 업데이트 및 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Python 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 소스 코드 복사
COPY . .

# 포트 노출
EXPOSE 8000

# 실행 명령
CMD ["python", "app.py"]
```

### R 4.25.4 분석 환경

```dockerfile
FROM r-base:4.4.2

# 빌드 도구 설치
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# R 패키지 설치
RUN R -e "install.packages(c('tidyverse', 'rmarkdown', 'shiny'), repos='https://cloud.r-project.org/')"

WORKDIR /workspace

CMD ["R"]
```

### 이미지 빌드 및 실행

```bash
# 이미지 빌드
docker build -t myapp:latest .

# 특정 Dockerfile 사용
docker build -f Dockerfile.dev -t myapp:dev .

# 빌드 캐시 무시
docker build --no-cache -t myapp:latest .

# 이미지 실행
docker run -p 8000:8000 myapp:latest
```

## 1.2.2.4. Docker Compose

Docker Compose는 여러 컨테이너를 정의하고 실행하는 도구입니다.

### docker-compose.yml 예제

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:16
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

### Docker Compose 명령어

```bash
# 서비스 시작
docker compose up

# 백그라운드 실행
docker compose up -d

# 특정 서비스만 시작
docker compose up web

# 서비스 중지
docker compose down

# 볼륨까지 삭제
docker compose down -v

# 로그 확인
docker compose logs
docker compose logs -f web

# 실행 중인 서비스 확인
docker compose ps

# 서비스 재시작
docker compose restart
```

## 1.2.2.5. Jupyter Lab Docker 환경

### Jupyter Data Science Stack

```bash
# 공식 Jupyter 이미지 실행
docker run -p 8888:8888 \
  -v "${PWD}":/home/jovyan/work \
  jupyter/datascience-notebook:latest

# Python 3.13 환경으로 커스터마이징
docker run -p 8888:8888 \
  -e JUPYTER_ENABLE_LAB=yes \
  -v "${PWD}":/home/jovyan/work \
  jupyter/scipy-notebook:python-3.13
```

### 커스텀 Jupyter Dockerfile

```dockerfile
FROM jupyter/base-notebook:python-3.13

USER root
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# Python 패키지 설치
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    tensorflow \
    torch

# Jupyter 확장 설치
RUN pip install --no-cache-dir \
    jupyterlab-git \
    jupyterlab-lsp \
    python-lsp-server

WORKDIR /home/jovyan/work
```

## 1.2.2.6. 유용한 팁

### 컨테이너 정리

```bash
# 중지된 컨테이너 모두 삭제
docker container prune

# 사용하지 않는 이미지 삭제
docker image prune

# 모든 미사용 리소스 정리
docker system prune -a

# 볼륨 정리
docker volume prune
```

### 리소스 모니터링

```bash
# 컨테이너 리소스 사용량 확인
docker stats

# 특정 컨테이너만 확인
docker stats CONTAINER_ID

# 한번만 출력
docker stats --no-stream
```

### 이미지 최적화

```dockerfile
# Multi-stage build 예제
FROM python:3.13 AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM python:3.13-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]
```
