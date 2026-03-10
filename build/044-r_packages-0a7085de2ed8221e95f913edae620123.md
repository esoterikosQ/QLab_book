# 1.4.5. R 패키지 관리

R 패키지는 함수, 데이터, 문서를 포함한 재사용 가능한 코드 모음입니다.

## 1.4.5.1. 패키지 설치 및 관리

### CRAN 패키지 (R 4.25.4)

```r
# 패키지 설치
install.packages("ggplot2")
install.packages(c("dplyr", "tidyr", "readr"))

# 특정 버전 설치
install.packages("dplyr", version = "1.1.4")

# 패키지 로드
library(ggplot2)
require(dplyr)  # library와 유사하지만 논리값 반환

# 패키지 언로드
detach("package:ggplot2", unload = TRUE)

# 설치된 패키지 목록
installed.packages()
library()

# 패키지 정보
packageVersion("ggplot2")
packageDescription("dplyr")

# 패키지 업데이트
update.packages()
update.packages(ask = FALSE)  # 자동 업데이트

# 패키지 제거
remove.packages("ggplot2")

# 로드된 패키지 확인
(.packages())  # 로드된 패키지
search()  # 검색 경로
```

### Ubuntu 24.04에서 시스템 dependencies

```bash
# tidyverse 의존성
sudo apt install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev

# sf (공간 데이터) 의존성
sudo apt install -y \
    libgdal-dev \
    libgeos-dev \
    libproj-dev

# RMySQL 의존성
sudo apt install -y libmysqlclient-dev

# RPostgreSQL 의존성
sudo apt install -y libpq-dev
```

## 1.4.5.2. devtools와 GitHub 패키지

```r
# devtools 설치
install.packages("devtools")
library(devtools)

# GitHub에서 설치
devtools::install_github("tidyverse/dplyr")
devtools::install_github("user/repo@branch")  # 특정 브랜치
devtools::install_github("user/repo@v1.0.0")  # 특정 태그

# 로컬 패키지 설치
devtools::install_local("path/to/package.tar.gz")

# 개발 모드 설치 (수정사항 즉시 반영)
devtools::load_all("path/to/package")
```

## 1.4.5.3. 필수 데이터 과학 패키지

### tidyverse (통합 패키지)

```r
# tidyverse 설치 (여러 패키지 포함)
install.packages("tidyverse")
library(tidyverse)

# 포함된 패키지
# - ggplot2: 시각화
# - dplyr: 데이터 변환
# - tidyr: 데이터 정리
# - readr: 파일 읽기
# - purrr: 함수형 프로그래밍
# - tibble: 데이터 프레임 개선
# - stringr: 문자열 처리
# - forcats: 팩터 처리
```

### dplyr - 데이터 변환

```r
library(dplyr)

# 데이터 변환
mtcars %>%
    filter(mpg > 20) %>%
    select(mpg, cyl, hp) %>%
    mutate(kpl = mpg * 0.425) %>%
    arrange(desc(mpg)) %>%
    group_by(cyl) %>%
    summarise(
        mean_mpg = mean(mpg),
        count = n()
    )

# 조인
left_join(df1, df2, by = "id")
inner_join(df1, df2)
full_join(df1, df2)
```

### ggplot2 - 시각화

```r
library(ggplot2)

# 기본 플롯
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    geom_smooth(method = "lm") +
    labs(title = "Weight vs MPG", x = "Weight", y = "Miles per Gallon") +
    theme_minimal()

# 저장
ggsave("plot.png", width = 8, height = 6, dpi = 300)
```

### readr - 파일 읽기

```r
library(readr)

# CSV 읽기 (빠름)
df <- read_csv("data.csv")
df <- read_csv("data.csv", col_types = cols(
    id = col_integer(),
    name = col_character(),
    value = col_double()
))

# 쓰기
write_csv(df, "output.csv")

# 기타 포맷
read_tsv("data.tsv")  # TSV
read_delim("data.txt", delim = "|")
```

### data.table - 고성능 데이터 처리

```r
library(data.table)

# data.table 생성
dt <- data.table(
    id = 1:1000000,
    value = rnorm(1000000)
)

# 빠른 필터링
dt[value > 0]

# 빠른 집계
dt[, .(mean_value = mean(value)), by = .(group = id %% 10)]

# 빠른 조인
setkey(dt1, id)
setkey(dt2, id)
dt1[dt2]
```

### tidyr - 데이터 정리

```r
library(tidyr)

# Wide → Long
df_long <- pivot_longer(df, cols = c(col1, col2), 
                        names_to = "variable", values_to = "value")

# Long → Wide
df_wide <- pivot_wider(df_long, names_from = variable, values_from = value)

# 결측치 처리
df %>% drop_na()  # 결측치 행 제거
df %>% fill(column, .direction = "down")  # 앞 값으로 채우기
df %>% replace_na(list(column = 0))  # 0으로 대체
```

### stringr - 문자열 처리

```r
library(stringr)

text <- c("apple", "banana", "cherry")

str_length(text)
str_to_upper(text)
str_to_lower(text)
str_detect(text, "a")
str_replace(text, "a", "A")
str_split(text, "")
str_extract(text, "[a-z]{3}")
```

### lubridate - 날짜/시간 처리

```r
library(lubridate)

# 파싱
ymd("2024-03-09")
mdy("03/09/2024")
dmy("09-03-2024")
ymd_hms("2024-03-09 15:30:45")

# 현재
now()
today()

# 연산
today() + days(7)
now() + hours(3)
today() - years(1)

# 추출
date <- ymd("2024-03-09")
year(date)
month(date)
day(date)
wday(date, label = TRUE)  # 요일
```

## 1.4.5.4. 머신러닝 패키지

### caret - 통합 ML 프레임워크

```r
library(caret)

# 데이터 분할
trainIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
trainData <- iris[trainIndex, ]
testData <- iris[-trainIndex, ]

# 모델 훈련
model <- train(Species ~ ., data = trainData, method = "rf")

# 예측
predictions <- predict(model, testData)

# 평가
confusionMatrix(predictions, testData$Species)
```

### randomForest

```r
library(randomForest)

model <- randomForest(Species ~ ., data = iris, ntree = 100)
predictions <- predict(model, iris)
importance(model)
```

## 1.4.5.5. 패키지 개발

### 패키지 구조

```
mypackage/
├── DESCRIPTION
├── NAMESPACE
├── R/
│   ├── function1.R
│   └── function2.R
├── man/
│   ├── function1.Rd
│   └── function2.Rd
├── tests/
│   └── testthat/
├── vignettes/
└── data/
```

### 패키지 생성

```r
# usethis로 패키지 생성
library(usethis)
create_package("~/mypackage")

# 함수 추가
use_r("function_name")

# 문서화 (roxygen2)
library(roxygen2)
document()

# 테스트 추가
use_testthat()
use_test("function_name")

# 빌드 및 체크
devtools::build()
devtools::check()

# 설치
devtools::install()
```

### DESCRIPTION 파일

```
Package: mypackage
Title: What the Package Does
Version: 0.1.0
Authors@R: person("First", "Last", email = "first.last@example.com", role = c("aut", "cre"))
Description: What the package does (one paragraph).
License: MIT + file LICENSE
Encoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.2.3
Imports:
    dplyr (>= 1.1.0),
    ggplot2
Suggests:
    testthat (>= 3.0.0),
    knitr,
    rmarkdown
```

### roxygen2 문서화

```r
#' Add Two Numbers
#'
#' This function adds two numbers together.
#'
#' @param x A number.
#' @param y A number.
#' @return The sum of x and y.
#' @examples
#' add(2, 3)
#' add(10, 20)
#' @export
add <- function(x, y) {
    x + y
}
```

## 1.4.5.6. renv - 의존성 관리

```r
# renv 설치
install.packages("renv")

# 프로젝트 초기화
renv::init()

# 스냅샷 (현재 상태 저장)
renv::snapshot()

# 복원 (저장된 상태로)
renv::restore()

# 상태 확인
renv::status()
```
