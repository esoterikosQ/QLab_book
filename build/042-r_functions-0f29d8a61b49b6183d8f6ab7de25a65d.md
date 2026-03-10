# 1.4.3. R 함수

함수는 재사용 가능한 코드 블록입니다.

## 1.4.3.1. 함수 정의

```r
# 기본 함수
greet <- function(name) {
    paste("Hello,", name)
}

result <- greet("Alice")  # "Hello, Alice"

# 여러 값 반환 (리스트)
get_stats <- function(x) {
    list(
        mean = mean(x),
        median = median(x),
        sd = sd(x)
    )
}

stats <- get_stats(c(1, 2, 3, 4, 5))
stats$mean

# 기본값
power <- function(x, n = 2) {
    x ^ n
}

power(3)      # 9
power(3, 3)   # 27

# 가변 인자
sum_all <- function(...) {
    sum(...)
}

sum_all(1, 2, 3, 4, 5)  # 15

# 명명된 인자
create_person <- function(name, age, city = "Seoul") {
    list(name = name, age = age, city = city)
}

person <- create_person(name = "Alice", age = 25)
```

## 1.4.3.2. 함수형 프로그래밍

```r
# lapply, sapply, vapply
nums <- list(a = 1:5, b = 6:10, c = 11:15)
lapply(nums, mean)
sapply(nums, mean)

# Map (lapply의 별칭)
Map(function(x, y) x + y, 1:3, 4:6)

# Reduce
Reduce(function(x, y) x + y, 1:10)  # 55

# Filter
Filter(function(x) x %% 2 == 0, 1:10)  # 짝수만

# 익명 함수 (단축 문법, R 4.1+)
sapply(nums, \(x) mean(x))
```

## 1.4.3.3. purrr 패키지 (tidyverse)

```r
library(purrr)

# map: lapply와 유사
nums <- list(a = 1:5, b = 6:10)
map(nums, mean)
map_dbl(nums, mean)      # 숫자 벡터 반환
map_chr(nums, \(x) paste(x, collapse = ","))

# map2: 두 입력
map2(1:3, 4:6, \(x, y) x + y)

# pmap: 여러 입력
pmap(list(1:3, 4:6, 7:9), \(x, y, z) x + y + z)

# keep, discard
keep(1:10, \(x) x %% 2 == 0)
discard(1:10, \(x) x %% 2 == 0)

# reduce
reduce(1:10, \(x, y) x + y)
```

## 1.4.3.4. 스코프와 환경

```r
# 전역 변수
x <- 10

my_function <- function() {
    # 지역 변수
    y <- 20
    x + y  # 전역 x 사용
}

my_function()  # 30

# <<- 로 전역 변수 수정
counter <- 0
increment <- function() {
    counter <<- counter + 1
    counter
}

increment()  # 1
increment()  # 2
```

## 1.4.3.5. 클로저

```r
make_counter <- function() {
    count <- 0
    function() {
        count <<- count + 1
        count
    }
}

counter1 <- make_counter()
counter1()  # 1
counter1()  # 2

counter2 <- make_counter()
counter2()  # 1 (독립적)
```

## 1.4.3.6. 재귀 함수

```r
# 팩토리얼
factorial <- function(n) {
    if (n <= 1) {
        return(1)
    }
    n * factorial(n - 1)
}

factorial(5)  # 120

# 피보나치
fibonacci <- function(n) {
    if (n <= 1) {
        return(n)
    }
    fibonacci(n - 1) + fibonacci(n - 2)
}

fibonacci(10)  # 55

# 메모이제이션
library(memoise)
fib_memo <- memoise(fibonacci)
fib_memo(100)  # 빠르게 계산
```

## 1.4.3.7. 오류 처리

```r
# tryCatch
result <- tryCatch({
    10 / 0
}, warning = function(w) {
    print("Warning occurred")
}, error = function(e) {
    print("Error occurred")
    NA
}, finally = {
    print("Always executed")
})

# try
result <- try({
    10 / 0
})

if (inherits(result, "try-error")) {
    print("Error occurred")
}

# stop (오류 발생)
validate <- function(x) {
    if (x < 0) {
        stop("x must be non-negative")
    }
    x
}

# warning (경고)
check_value <- function(x) {
    if (x < 0) {
        warning("x is negative")
    }
    x
}
```

## 1.4.3.8. 유용한 내장 함수

```r
# 수학
abs(-5)
sqrt(16)
exp(1)
log(10)
round(3.7, 2)

# 통계
x <- c(1, 2, 3, 4, 5)
mean(x)
median(x)
var(x)
sd(x)
quantile(x)
cor(x, y)

# 벡터 연산
sum(x)
prod(x)  # 곱
cumsum(x)  # 누적 합
cumprod(x)  # 누적 곱
diff(x)  # 차분

# 집합 연산
union(c(1, 2, 3), c(3, 4, 5))
intersect(c(1, 2, 3), c(3, 4, 5))
setdiff(c(1, 2, 3), c(3, 4, 5))

# 문자열
paste("Hello", "World")
paste0("Hello", "World")
nchar("Hello")
substr("Hello", 1, 3)
strsplit("a,b,c", ",")[[1]]
```
