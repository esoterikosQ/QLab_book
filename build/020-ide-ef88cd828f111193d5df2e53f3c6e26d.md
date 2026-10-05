# 1.2.1. 통합 개발 환경 (IDE)

통합 개발 환경(Integrated Development Environment, IDE)은 코드 작성, 디버깅, 빌드, 테스트를 하나의 도구에서 처리할 수 있는 소프트웨어입니다.

## 1.2.1.1. VS Code

Visual Studio Code는 Microsoft가 개발한 오픈소스 코드 에디터로, 가볍고 확장성이 뛰어나 가장 널리 사용됩니다.

### 설치 (Ubuntu 24.04)

```bash
# 공식 Microsoft repository 추가
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# 설치
sudo apt update
sudo apt install code
```

### 필수 확장 프로그램

```bash
# 명령어로 확장 프로그램 설치
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-vscode.cpptools
code --install-extension reditorsupport.r
code --install-extension rdebugger.r-debugger
code --install-extension ms-azuretools.vscode-docker
code --install-extension eamodio.gitlens
```

### 주요 단축키

| 기능 | Linux/Windows | macOS |
|------|--------------|-------|
| 명령 팔레트 | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| 파일 검색 | `Ctrl+P` | `Cmd+P` |
| 터미널 토글 | `Ctrl+`` | `Cmd+`` |
| 사이드바 토글 | `Ctrl+B` | `Cmd+B` |
| 전체 검색 | `Ctrl+Shift+F` | `Cmd+Shift+F` |
| 정의로 이동 | `F12` | `F12` |
| 이름 변경 | `F2` | `F2` |

## 1.2.1.2. Jupyter Lab

Jupyter Lab은 대화형 컴퓨팅 환경으로, 데이터 분석과 과학 연구에 최적화되어 있습니다.

### 설치 (Python 3.13)

```bash
# pip를 이용한 설치
python3.13 -m pip install jupyterlab

# 또는 conda 환경에서
conda install -c conda-forge jupyterlab
```

### 실행

```bash
# 기본 실행
jupyter lab

# 특정 포트에서 실행
jupyter lab --port=8889

# 백그라운드 실행
nohup jupyter lab --no-browser --port=8888 > jupyter.log 2>&1 &
```

### 유용한 확장 프로그램

```bash
# Table of Contents 확장
pip install jupyterlab-toc

# Git 통합
pip install jupyterlab-git

# LSP (Language Server Protocol) 지원
pip install jupyterlab-lsp python-lsp-server

# 변수 검사기
pip install lckr-jupyterlab-variableinspector
```

## 1.2.1.3. RStudio

RStudio는 R 프로그래밍을 위한 통합 개발 환경입니다.

### 설치 (Ubuntu 24.04, R 4.25.4)

```bash
# R 4.25.4 설치 (CRAN repository 사용)
sudo apt update
sudo apt install -y --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install -y r-base r-base-dev

# RStudio Desktop 설치
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2024.12.0-467-amd64.deb
sudo apt install -y ./rstudio-2024.12.0-467-amd64.deb
rm rstudio-2024.12.0-467-amd64.deb
```

### 필수 R 패키지

```r
# 기본 개발 도구
install.packages(c("devtools", "usethis", "roxygen2"))

# 데이터 처리
install.packages(c("tidyverse", "data.table", "dtplyr"))

# 시각화
install.packages(c("ggplot2", "plotly", "patchwork"))

# 문서 작성
install.packages(c("rmarkdown", "knitr", "bookdown"))
```

## 1.2.1.4. PyCharm

PyCharm은 JetBrains에서 개발한 Python 전용 IDE로, 강력한 디버깅과 리팩토링 기능을 제공합니다.

### 설치 (Community Edition)

```bash
# Snap을 이용한 설치
sudo snap install pycharm-community --classic

# 또는 직접 다운로드
wget https://download.jetbrains.com/python/pycharm-community-2024.3.tar.gz
sudo tar xzf pycharm-community-*.tar.gz -C /opt/
cd /opt/pycharm-community-*/bin
./pycharm.sh
```

### 주요 기능

- **인텔리전트 코드 완성**: 컨텍스트 기반 스마트 제안
- **강력한 디버거**: 중단점, 변수 검사, 표현식 평가
- **리팩토링**: 안전한 코드 재구조화
- **테스트 통합**: pytest, unittest 지원
- **원격 개발**: SSH를 통한 원격 인터프리터 사용

## 1.2.1.5. 환경 설정 팁

### Python 가상환경 사용

```bash
# venv 생성 (Python 3.13)
python3.13 -m venv ~/venvs/project_env

# 활성화
source ~/venvs/project_env/bin/activate

# 비활성화
deactivate
```

### R 라이브러리 경로 설정

```r
# .Renviron 파일에 추가
R_LIBS_USER="~/R/library/%p-library/%v"

# 또는 세션에서 직접 설정
.libPaths(c("~/R/library", .libPaths()))
```

### Git 통합

```bash
# Git 사용자 정보 설정
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# IDE에서 사용할 기본 에디터 설정
git config --global core.editor "code --wait"
```
