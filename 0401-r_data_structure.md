# 1.4.2. R 자료구조

R의 기본 자료구조는 벡터, 리스트, 행렬, 데이터 프레임, 팩터입니다.

## 1.4.2.1. 벡터 (Vector)

```r
# 생성
nums <- c(1, 2, 3, 4, 5)
chars <- c("a", "b", "c")

# 명명
names(nums) <- c("first", "second", "third", "fourth", "fifth")
named_vec <- c(a=1, b=2, c=3)

# 인덱싱
nums[1]                  # 1 (1부터 시작)
nums[c(1, 3, 5)]         # 1, 3, 5
nums[nums > 2]           # 3, 4, 5
nums["first"]            # 이름으로 접근

# 연산
nums + 10
nums * 2
sum(nums)
mean(nums)
```

## 1.4.2.2. 리스트 (List)

```r
# 생성
person <- list(
    name = "Alice",
    age = 25,
    scores = c(85, 90, 88),
    passed = TRUE
)

# 접근
person$name              # "Alice"
person[[1]]              # "Alice"
person[["name"]]         # "Alice"
person["name"]           # 리스트로 반환

# 수정
person$age <- 26
person$city <- "Seoul"   # 새 요소 추가

# 길이
length(person)           # 5

# 리스트 결합
list1 <- list(a=1, b=2)
list2 <- list(c=3, d=4)
combined <- c(list1, list2)
```

## 1.4.2.3. 행렬 (Matrix)

```r
# 생성
mat <- matrix(1:12, nrow=3, ncol=4)
# mat <- matrix(1:12, nrow=3, byrow=TRUE)  # 행 우선

# 차원 확인
dim(mat)                 # c(3, 4)
nrow(mat)                # 3
ncol(mat)                # 4

# 인덱싱
mat[1, 2]                # 1행 2열
mat[1, ]                 # 1행 전체
mat[, 2]                 # 2열 전체
mat[c(1, 3), c(2, 4)]    # 특정 행/열

# 행/열 이름
rownames(mat) <- c("r1", "r2", "r3")
colnames(mat) <- c("c1", "c2", "c3", "c4")

# 연산
mat + 10
mat * 2
mat %*% t(mat)           # 행렬 곱
t(mat)                   # 전치

# 행/열 결합
rbind(mat, c(13, 14, 15, 16))  # 행 추가
cbind(mat, c(13, 14, 15))      # 열 추가

# apply
apply(mat, 1, sum)       # 행별 합
apply(mat, 2, mean)      # 열별 평균
```

## 1.4.2.4. 배열 (Array)

```r
# 3차원 배열
arr <- array(1:24, dim=c(3, 4, 2))

# 인덱싱
arr[1, 2, 1]
arr[, , 1]               # 첫 번째 슬라이스
```

## 1.4.2.5. 데이터 프레임 (Data Frame)

```r
# 생성
df <- data.frame(
    name = c("Alice", "Bob", "Charlie"),
    age = c(25, 30, 35),
    score = c(85.5, 92.0, 78.5),
    passed = c(TRUE, TRUE, FALSE)
)

# 구조 확인
str(df)
summary(df)
head(df, 2)
tail(df, 2)
dim(df)

# 열 접근
df$name
df[["name"]]
df[, "name"]
df[, 1]

# 행 접근
df[1, ]                  # 첫 행
df[c(1, 3), ]            # 1, 3행

# 필터링
df[df$age > 25, ]
df[df$score >= 80, c("name", "score")]

# 열 추가/삭제
df$grade <- c("B", "A", "C")
df$grade <- NULL         # 삭제

# 행 추가
new_row <- data.frame(name="David", age=28, score=88.0, passed=TRUE)
df <- rbind(df, new_row)

# 정렬
df[order(df$score), ]              # 오름차순
df[order(-df$score), ]             # 내림차순
df[order(df$age, -df$score), ]     # 다중 정렬
```

## 1.4.2.6. 팩터 (Factor)

```r
# 생성
colors <- factor(c("red", "blue", "red", "green", "blue"))

# 레벨 확인
levels(colors)           # "blue", "green", "red" (알파벳 순)
nlevels(colors)          # 3

# 레벨 순서 지정
colors <- factor(c("red", "blue", "red", "green", "blue"),
                 levels=c("red", "green", "blue"))

# 순서형 팩터
sizes <- ordered(c("S", "M", "L", "M", "S"),
                 levels=c("S", "M", "L"))

# 팩터 → 문자열
as.character(colors)

# 문자열 → 팩터
chars <- c("a", "b", "c", "a")
factor(chars)
```

## 1.4.2.7. tibble (tidyverse)

```r
library(tibble)

# 생성
tbl <- tibble(
    name = c("Alice", "Bob", "Charlie"),
    age = c(25, 30, 35),
    score = c(85.5, 92.0, 78.5)
)

# 장점
# 1. 출력이 깔끔 (많은 행도 자동으로 일부만 표시)
# 2. 타입 변환 안 함 (문자열이 자동으로 factor가 되지 않음)
# 3. 부분 매칭 안 됨 (tbl$nam은 오류)

# tribble (행 단위 생성)
tbl <- tribble(
    ~name,      ~age, ~score,
    "Alice",    25,   85.5,
    "Bob",      30,   92.0,
    "Charlie",  35,   78.5
)

# data.frame으로 변환
as.data.frame(tbl)

# tibble로 변환
as_tibble(df)
```

## 1.4.2.8. 자료구조 변환

```r
# 벡터 → 행렬
vec <- 1:12
mat <- matrix(vec, nrow=3)

# 행렬 → 데이터프레임
df <- as.data.frame(mat)

# 리스트 → 데이터프레임
lst <- list(a=1:3, b=4:6, c=7:9)
df <- as.data.frame(lst)

# 데이터프레임 → 행렬
mat <- as.matrix(df)

# 팩터 → 숫자
f <- factor(c("1", "2", "3"))
as.numeric(as.character(f))   # 올바른 방법
```

## 1.4.2.9. 결측치 처리

```r
x <- c(1, 2, NA, 4, 5)

# 결측치 확인
is.na(x)                 # c(FALSE, FALSE, TRUE, FALSE, FALSE)
anyNA(x)                 # TRUE
sum(is.na(x))            # 1

# 제거
x[!is.na(x)]             # c(1, 2, 4, 5)
na.omit(x)               # c(1, 2, 4, 5)

# 데이터프레임
df <- data.frame(a=c(1, NA, 3), b=c(4, 5, NA))
complete.cases(df)       # c(TRUE, FALSE, FALSE)
df[complete.cases(df), ]  # 완전한 행만
na.omit(df)              # 결측치 행 제거

# 대체
x[is.na(x)] <- mean(x, na.rm=TRUE)
```

## 1.4.2.10. 자료구조 비교

| 구조 | 차원 | 타입 | 가변성 |
|------|------|------|--------|
| Vector | 1D | 단일 | 가변 |
| List | 1D | 혼합 | 가변 |
| Matrix | 2D | 단일 | 가변 |
| Array | nD | 단일 | 가변 |
| Data Frame | 2D | 혼합 | 가변 |
| Factor | 1D | 범주 | 가변 |
