# 1.4.1. R 소개

R은 통계 계산과 그래픽을 위한 프로그래밍 언어로, 데이터 분석과 통계 모델링에 최적화되어 있습니다.

## 1.4.1.1. R 설치 (Ubuntu 24.04)

### R 4.25.4 설치

```bash
# 필수 패키지 설치
sudo apt update
sudo apt install -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    ca-certificates \
    gnupg

# CRAN GPG 키 추가
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
    sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

# CRAN repository 추가 (Ubuntu 24.04 Noble)
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/"

# R 설치
sudo apt update
sudo apt install -y r-base r-base-dev

# 버전 확인
R --version  # R version 4.25.4 (2026-xx-xx)
```

### 필수 시스템 라이브러리

```bash
# 데이터 처리 및 시각화 패키지 의존성
sudo apt install -y \
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
    libgit2-dev
```

## 1.4.1.2. 기본 문법

### 변수와 데이터 타입

```r
# 숫자
x <- 42
y = 3.14  # = 도 사용 가능하지만 <- 권장

# 문자열
name <- "Alice"
message <- 'Hello, World!'

# 논리값
is_valid <- TRUE
is_empty <- FALSE

# NA (결측치)
missing <- NA

# NULL
nothing <- NULL

# 타입 확인
class(x)        # "numeric"
typeof(x)       # "double"
is.numeric(x)   # TRUE
is.character(name)  # TRUE
```

### 벡터 (Vector)

```r
# 생성
nums <- c(1, 2, 3, 4, 5)
chars <- c("a", "b", "c")
logicals <- c(TRUE, FALSE, TRUE)

# 연속 숫자
seq1 <- 1:10
seq2 <- seq(0, 1, by=0.1)
seq3 <- seq(0, 1, length.out=11)

# 반복
rep1 <- rep(5, times=3)      # c(5, 5, 5)
rep2 <- rep(c(1, 2), times=3)  # c(1, 2, 1, 2, 1, 2)
rep3 <- rep(c(1, 2), each=3)   # c(1, 1, 1, 2, 2, 2)

# 인덱싱 (1부터 시작!)
nums[1]        # 첫 번째 요소: 1
nums[c(1, 3, 5)]  # 1, 3, 5번째: c(1, 3, 5)
nums[-1]       # 첫 요소 제외
nums[nums > 2]  # 조건 필터링

# 길이
length(nums)   # 5

# 벡터 연산
x <- c(1, 2, 3, 4)
y <- c(10, 20, 30, 40)
x + y          # c(11, 22, 33, 44)
x * 2          # c(2, 4, 6, 8)
sqrt(x)        # 제곱근
```

### 조건문

```r
# if-else
score <- 85

if (score >= 90) {
    grade <- "A"
} else if (score >= 80) {
    grade <- "B"
} else if (score >= 70) {
    grade <- "C"
} else {
    grade <- "F"
}

# ifelse (벡터화)
scores <- c(95, 75, 88, 62)
grades <- ifelse(scores >= 80, "Pass", "Fail")
```

### 반복문

```r
# for 루프
for (i in 1:5) {
    print(i)
}

fruits <- c("apple", "banana", "cherry")
for (fruit in fruits) {
    print(fruit)
}

# while 루프
count <- 0
while (count < 5) {
    print(count)
    count <- count + 1
}

# repeat (무한 루프)
count <- 0
repeat {
    print(count)
    count <- count + 1
    if (count >= 5) break
}

# next (continue)
for (i in 1:10) {
    if (i %% 2 == 0) next
    print(i)  # 홀수만 출력
}
```

## 1.4.1.3. 연산자

```r
# 산술
5 + 3    # 8
5 - 3    # 2
5 * 3    # 15
5 / 3    # 1.666...
5 %/% 3  # 1 (정수 나눗셈)
5 %% 3   # 2 (나머지)
5 ^ 3    # 125 (거듭제곱)

# 비교
5 == 3   # FALSE
5 != 3   # TRUE
5 > 3    # TRUE
5 < 3    # FALSE
5 >= 3   # TRUE
5 <= 3   # FALSE

# 논리
TRUE & FALSE   # FALSE (AND)
TRUE | FALSE   # TRUE (OR)
!TRUE          # FALSE (NOT)
TRUE && FALSE  # FALSE (단락 평가, 스칼라만)
TRUE || FALSE  # TRUE (단락 평가, 스칼라만)

# 벡터 연산자
c(TRUE, FALSE) & c(TRUE, TRUE)   # c(TRUE, FALSE)
c(TRUE, FALSE) | c(TRUE, TRUE)   # c(TRUE, TRUE)
```

## 1.4.1.4. 입출력

### 콘솔 입출력

```r
# 출력
print("Hello, World!")
cat("Hello", "World", "\n")

# 포매팅
name <- "Alice"
age <- 25
sprintf("Name: %s, Age: %d", name, age)
cat(sprintf("Name: %s, Age: %d\n", name, age))

# 입력 (대화형)
name <- readline(prompt="Enter your name: ")
age <- as.integer(readline(prompt="Enter your age: "))
```

### 파일 입출력

```r
# CSV 읽기/쓰기
df <- read.csv("data.csv")
write.csv(df, "output.csv", row.names=FALSE)

# RDS 형식 (R 전용, 압축)
saveRDS(df, "data.rds")
df <- readRDS("data.rds")

# 텍스트 파일
lines <- readLines("file.txt")
writeLines(c("line1", "line2"), "output.txt")

# readr 패키지 (tidyverse, 더 빠름)
library(readr)
df <- read_csv("data.csv")
write_csv(df, "output.csv")
```

## 1.4.1.5. 내장 함수

```r
# 수학 함수
abs(-5)         # 5
sqrt(16)        # 4
exp(1)          # 2.718...
log(10)         # 2.302... (자연로그)
log10(100)      # 2
sin(pi/2)       # 1
round(3.7)      # 4
ceiling(3.1)    # 4
floor(3.9)      # 3

# 통계 함수
x <- c(1, 2, 3, 4, 5)
sum(x)          # 15
mean(x)         # 3
median(x)       # 3
var(x)          # 2.5 (분산)
sd(x)           # 1.58 (표준편차)
min(x)          # 1
max(x)          # 5
range(x)        # c(1, 5)
quantile(x)     # 사분위수

# 문자열 함수
text <- "Hello, World!"
nchar(text)                    # 13 (길이)
toupper(text)                  # "HELLO, WORLD!"
tolower(text)                  # "hello, world!"
substr(text, 1, 5)             # "Hello"
strsplit(text, ", ")[[1]]      # c("Hello", "World!")
paste("Hello", "World")        # "Hello World"
paste0("Hello", "World")       # "HelloWorld"

# 벡터 함수
x <- c(3, 1, 4, 1, 5, 9)
sort(x)         # 정렬
rev(x)          # 역순
unique(x)       # 중복 제거
table(x)        # 빈도표
which(x > 3)    # 조건 만족 인덱스
```

## 1.4.1.6. Apply 함수군

```r
# lapply: 리스트 반환
nums <- list(a=1:5, b=6:10, c=11:15)
lapply(nums, mean)  # 각 요소의 평균

# sapply: 단순화된 결과
sapply(nums, mean)  # c(a=3, b=8, c=13)

# vapply: 타입 지정
vapply(nums, mean, numeric(1))

# apply: 행렬/배열
mat <- matrix(1:12, nrow=3)
apply(mat, 1, sum)  # 행별 합
apply(mat, 2, sum)  # 열별 합

# mapply: 다중 입력
mapply(function(x, y) x + y, 1:3, 4:6)  # c(5, 7, 9)

# tapply: 그룹별 적용
ages <- c(25, 30, 35, 28, 32)
groups <- c("A", "B", "A", "B", "A")
tapply(ages, groups, mean)  # A: 30, B: 29
```

## 1.4.1.7. 작업 환경

```r
# 작업 디렉토리
getwd()                  # 현재 디렉토리
setwd("/path/to/dir")    # 디렉토리 변경

# 객체 관리
ls()                     # 변수 목록
rm(x, y)                 # 변수 삭제
rm(list=ls())            # 모든 변수 삭제

# 히스토리
history()                # 명령 히스토리
savehistory("hist.R")
loadhistory("hist.R")

# 세션 정보
sessionInfo()            # R 버전, 패키지 정보

# 도움말
help(mean)
?mean
help.search("regression")
??regression
example(mean)
```

## 1.4.1.8. 파이프 연산자

```r
# base R 파이프 (R 4.1+)
1:10 |> 
    sum() |>
    sqrt()

# magrittr 파이프 (tidyverse)
library(magrittr)
1:10 %>%
    sum() %>%
    sqrt()

# 실용 예제
library(dplyr)
mtcars %>%
    filter(mpg > 20) %>%
    select(mpg, cyl, hp) %>%
    arrange(desc(mpg)) %>%
    head(10)
```

## 1.4.1.9. R 스타일 가이드

```r
# 변수명: 스네이크 케이스
my_variable <- 42
total_count <- 100

# 함수명: 스네이크 케이스 또는 카멜 케이스
calculate_mean <- function(x) mean(x)
calculateMean <- function(x) mean(x)  # 기존 R 스타일

# 들여쓰기: 2칸
if (condition) {
  # 2칸 들여쓰기
  do_something()
}

# 공백
x <- 5         # <- 양쪽에 공백
mean(x, na.rm = TRUE)  # 인자 주위 공백

# 주석
# 한 줄 주석은 # 하나만 사용
```
