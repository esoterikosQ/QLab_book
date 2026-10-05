# R 및 RStudio 설치 가이드

본 과정을 수행하기 위해서는 반드시 사용하고 있는 시스템에 R과 RStudio를 설치해야 합니다.

R은 통계 연구에 특화된 프로그래밍 언어이고, RStudio는 R을 편리하게 사용할 수 있도록 다양한 기능을 제공하는 통합 개발 환경(IDE)입니다.

---

## 1. R 설치하기

1. **CRAN 공식 웹사이트 접속**

[CRAN 미러(cran.r-project.org)](https://cran.r-project.org/?utm_source=gemini)에서 본인의 운영체제에 맞는 버전을 선택하여 설치하세요.

* Windows: `Download R for Windows` -> `base` -> `Download R-x.x.x for Windows` 클릭
* macOS: `Download R for macOS` -> 본인 Mac의 칩셋에 맞는 패키지(Apple silicon용 `arm64` 또는 Intel용 `x86_64`) 선택 다운로드


2. **설치 프로그램 실행**

다운로드된 설치 파일(`.exe` 또는 `.pkg`)을 열고 기본(Default) 옵션을 유지하며 설치를 완료합니다.

```{warning}
Windows 사용자의 경우, 사용자 계정 이름이나 설치 경로에 **한글 또는 공백**이 포함되어 있으면 패키지 컴파일 및 경로 인식 시 오류가 발생할 수 있습니다. 가급적 기본 영문 경로 설정을 권장합니다.

```

---

## 2. RStudio Desktop 설치하기

1. **Posit 공식 웹사이트 접속**
[Posit 공식 다운로드 페이지](https://posit.co/download/rstudio-desktop/?utm_source=gemini)에서 본인의 운영체제에 맞는 버전을 선택하여 설치하세요.

* `Install Links - Open Source` 섹션에서 운영체제에 맞는 RStudio Desktop 버전 선택

2. **설치 진행**

설치 마법사의 안내에 따라 설치를 완료합니다.

---

## 3. 설치 정상 작동 확인

RStudio를 실행하면 4개의 창이 나타납니다. 기본 설정에서는 좌상단부터 시계방향으로 **스크립트(Script) 창**, **환경(Environment) 창**, **파일(File) 창**, **콘솔(Console) 창**이라고 부르는 창이 뜹니다.

이 중, 좌하단에 있는 콘솔(Console) 창에 아래 코드를 입력하고 `Enter`를 눌러 작동을 확인합니다.

```{code-block} r
# R 버전 확인 및 간단한 계산 테스트
version$version.string

# 연산 테스트
x <- c(10, 20, 30, 40, 50)
mean(x)

```
콘솔 창에는 계산 결과(`[1] 30`)가 출력되어야 합니다. 
