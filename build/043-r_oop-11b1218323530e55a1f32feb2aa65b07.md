# 1.4.4. R 객체지향 프로그래밍

R에는 S3, S4, R6 세 가지 주요 OOP 시스템이 있습니다.

## 1.4.4.1. S3 (가장 간단하고 널리 사용)

```r
# S3 객체 생성
person <- list(
    name = "Alice",
    age = 25
)
class(person) <- "Person"

# 메서드 정의
print.Person <- function(x) {
    cat("Person:\n")
    cat("  Name:", x$name, "\n")
    cat("  Age:", x$age, "\n")
}

print(person)

# 생성자 함수
Person <- function(name, age) {
    obj <- list(name = name, age = age)
    class(obj) <- "Person"
    obj
}

alice <- Person("Alice", 25)

# 메서드 추가
summary.Person <- function(x) {
    cat(sprintf("%s is %d years old\n", x$name, x$age))
}

summary(alice)

# 메서드 확인
methods(class = "Person")
methods(print)
```

## 1.4.4.2. S4 (더 엄격하고 공식적)

```r
# 클래스 정의
setClass("Person",
    slots = c(
        name = "character",
        age = "numeric"
    ),
    prototype = list(
        name = NA_character_,
        age = NA_real_
    )
)

# 객체 생성
alice <- new("Person", name = "Alice", age = 25)

# 슬롯 접근
alice@name
slot(alice, "name")

# 메서드 정의
setMethod("show", "Person",
    function(object) {
        cat("Person:\n")
        cat("  Name:", object@name, "\n")
        cat("  Age:", object@age, "\n")
    }
)

# 제네릭 함수 정의
setGeneric("greet", function(x) standardGeneric("greet"))

setMethod("greet", "Person",
    function(x) {
        paste("Hello, I'm", x@name)
    }
)

greet(alice)

# 상속
setClass("Student",
    contains = "Person",
    slots = c(
        grade = "numeric"
    )
)

bob <- new("Student", name = "Bob", age = 20, grade = 85)
```

## 1.4.4.3. R6 (참조 클래스, 가장 OOP답)

```r
library(R6)

# 클래스 정의
Person <- R6Class("Person",
    public = list(
        name = NULL,
        age = NULL,
        
        # 생성자
        initialize = function(name, age) {
            self$name <- name
            self$age <- age
        },
        
        # 메서드
        greet = function() {
            cat(sprintf("Hello, I'm %s\n", self$name))
        },
        
        print = function() {
            cat("Person:\n")
            cat("  Name:", self$name, "\n")
            cat("  Age:", self$age, "\n")
        }
    ),
    
    # private 멤버
    private = list(
        .id = NULL
    )
)

# 객체 생성
alice <- Person$new("Alice", 25)
alice$greet()
alice$name  # "Alice"

# 상속
Student <- R6Class("Student",
    inherit = Person,
    public = list(
        grade = NULL,
        
        initialize = function(name, age, grade) {
            super$initialize(name, age)
            self$grade <- grade
        },
        
        study = function() {
            cat(sprintf("%s is studying\n", self$name))
        }
    )
)

bob <- Student$new("Bob", 20, 85)
bob$greet()
bob$study()

# 액티브 바인딩 (프로퍼티)
BankAccount <- R6Class("BankAccount",
    private = list(
        .balance = 0
    ),
    public = list(
        deposit = function(amount) {
            private$.balance <- private$.balance + amount
        },
        
        withdraw = function(amount) {
            if (amount <= private$.balance) {
                private$.balance <- private$.balance - amount
                return(TRUE)
            }
            FALSE
        }
    ),
    active = list(
        balance = function() {
            private$.balance
        }
    )
)

account <- BankAccount$new()
account$deposit(1000)
account$balance  # 1000 (읽기 전용)
```

## 1.4.4.4. 제네릭 메서드

```r
# S3 제네릭
print <- function(x, ...) UseMethod("print")
summary <- function(x, ...) UseMethod("summary")

# 커스텀 제네릭
describe <- function(x) UseMethod("describe")

describe.default <- function(x) {
    cat("Object of class:", class(x), "\n")
}

describe.Person <- function(x) {
    cat(sprintf("%s, %d years old\n", x$name, x$age))
}

# S4 제네릭
setGeneric("process", function(x) standardGeneric("process"))
```

## 1.4.4.5. 시스템 비교

| 특징 | S3 | S4 | R6 |
|------|----|----|-----|
| 단순성 | 매우 간단 | 복잡 | 중간 |
| 타입 검사 | 없음 | 엄격 | 중간 |
| 참조 의미 | 복사 | 복사 | 참조 |
| 상속 | 단순 | 다중 가능 | 단일 |
| 사용처 | 대부분 패키지 | 공식 패키지 | 최신 패키지 |
