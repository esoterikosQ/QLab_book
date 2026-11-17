# 1.3.1. Python 소개

Python은 1991년 Guido van Rossum이 개발한 고급 프로그래밍 언어로, 간결하고 읽기 쉬운 문법으로 데이터 과학, 웹 개발, 자동화 등 다양한 분야에서 사용됩니다.

## 1.3.1.1. Python 설치 (Ubuntu 24.04)

### Python 3.13 설치

```bash
# 필수 패키지 설치
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# pyenv 설치 (Python 버전 관리)
curl https://pyenv.run | bash

# ~/.bashrc에 추가
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# 설정 적용
source ~/.bashrc

# Python 3.13 설치
pyenv install 3.13.0
pyenv global 3.13.0

# 설치 확인
python --version  # Python 3.13.0
```

### pip 업그레이드

```bash
python -m pip install --upgrade pip setuptools wheel
```

## 1.3.1.2. 기본 문법

### Hello World

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

print("Hello, World!")

# 여러 줄 출력
print("첫 번째 줄")
print("두 번째 줄")

# f-string 사용 (Python 3.6+)
name = "Python"
version = 3.13
print(f"언어: {name}, 버전: {version}")

# format 메서드
print("언어: {}, 버전: {}".format(name, version))
```

### 변수와 타입

```python
# 정수 (int)
age = 25
big_number = 1_000_000_000  # 가독성을 위한 언더스코어

# 실수 (float)
pi = 3.14159
scientific = 1.23e-4  # 0.000123

# 문자열 (str)
single = 'Hello'
double = "World"
multiline = """여러 줄
문자열
사용 가능"""

# 불린 (bool)
is_valid = True
is_empty = False

# None (null 값)
result = None

# 타입 확인
print(type(age))        # <class 'int'>
print(type(pi))         # <class 'float'>
print(type(is_valid))   # <class 'bool'>
print(isinstance(age, int))  # True
```

### 주석

```python
# 한 줄 주석

"""
여러 줄 주석 (docstring)
함수나  클래스 설명에 주로 사용
"""

'''
작은따옴표로도 가능
'''
```

## 1.3.1.3. 연산자

### 산술 연산자

```python
a, b = 10, 3

print(a + b)   # 13 (덧셈)
print(a - b)   # 7  (뺄셈)
print(a * b)   # 30 (곱셈)
print(a / b)   # 3.333... (나눗셈)
print(a // b)  # 3  (정수 나눗셈)
print(a % b)   # 1  (나머지)
print(a ** b)  # 1000 (거듭제곱)

# 복합 대입
x = 5
x += 3   # x = x + 3
x *= 2   # x = x * 2
print(x) # 16
```

### 비교 연산자

```python
x, y = 5, 10

print(x == y)  # False (같음)
print(x != y)  # True  (다름)
print(x < y)   # True  (작음)
print(x > y)   # False (큼)
print(x <= y)  # True  (작거나 같음)
print(x >= y)  # False (크거나 같음)

# 체이닝 비교
age = 25
print(18 <= age < 65)  # True
```

### 논리 연산자

```python
a = True
b = False

print(a and b)  # False
print(a or b)   # True
print(not a)    # False

# 단락 평가 (short-circuit evaluation)
x = 5
result = x > 0 and x < 10  # True
```

## 1.3.1.4. 조건문

```python
# if-elif-else
score = 85

if score >= 90:
    grade = 'A'
elif score >= 80:
    grade = 'B'
elif score >= 70:
    grade = 'C'
else:
    grade = 'F'

print(f"학점: {grade}")

# 조건 표현식 (Ternary operator)
status = "pass" if score >= 60 else "fail"

# match-case (Python 3.10+, Structural Pattern Matching)
def http_status(code):
    match code:
        case 200:
            return "OK"
        case 404:
            return "Not Found"
        case 500 | 502 | 503:
            return "Server Error"
        case _:
            return "Unknown"

print(http_status(404))  # Not Found
```

## 1.3.1.5. 반복문

### for 루프

```python
# 리스트 순회
fruits = ['apple', 'banana', 'cherry']
for fruit in fruits:
    print(fruit)

# range 사용
for i in range(5):        # 0, 1, 2, 3, 4
    print(i)

for i in range(2, 10, 2): # 2, 4, 6, 8
    print(i)

# enumerate (인덱스와 값)
for idx, fruit in enumerate(fruits):
    print(f"{idx}: {fruit}")

# zip (여러 리스트 동시 순회)
names = ['Alice', 'Bob', 'Charlie']
ages = [25, 30, 35]
for name, age in zip(names, ages):
    print(f"{name} is {age} years old")
```

### while 루프

```python
count = 0
while count < 5:
    print(count)
    count += 1

# break와 continue
for i in range(10):
    if i == 3:
        continue  # 건너뛰기
    if i == 7:
        break     # 종료
    print(i)

# else 절 (break 없이 정상 종료 시 실행)
for i in range(5):
    print(i)
else:
    print("Loop completed")
```

## 1.3.1.6. 입출력

### 표준 입출력

```python
# 입력
name = input("이름을 입력하세요: ")
age = int(input("나이를 입력하세요: "))

# 출력
print(f"안녕하세요, {name}님! 나이는 {age}세이군요.")

# 출력 옵션
print("Hello", "World", sep=", ", end="!\n")  # Hello, World!
```

### 파일 입출력

```python
# 파일 쓰기
with open('output.txt', 'w', encoding='utf-8') as f:
    f.write("첫 번째 줄\n")
    f.write("두 번째 줄\n")

# 파일 읽기
with open('output.txt', 'r', encoding='utf-8') as f:
    content = f.read()
    print(content)

# 줄 단위 읽기
with open('output.txt', 'r', encoding='utf-8') as f:
    for line in f:
        print(line.strip())

# 모든 줄을 리스트로
with open('output.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()
```

## 1.3.1.7. 예외 처리

```python
# try-except
try:
    result = 10 / 0
except ZeroDivisionError:
    print("0으로 나눌 수 없습니다")

# 여러 예외 처리
try:
    value = int(input("숫자 입력: "))
    result = 100 / value
except ValueError:
    print("올바른 숫자가 아닙니다")
except ZeroDivisionError:
    print("0으로 나눌 수 없습니다")
except Exception as e:
    print(f"오류 발생: {e}")
else:
    print(f"결과: {result}")
finally:
    print("항상 실행됩니다")

# 예외 발생
def validate_age(age):
    if age < 0:
        raise ValueError("나이는 음수일 수 없습니다")
    return age

# 사용자 정의 예외
class CustomError(Exception):
    pass

try:
    raise CustomError("사용자 정의 오류")
except CustomError as e:
    print(e)
```

## 1.3.1.8. Python 스타일 가이드 (PEP 8)

```python
# 좋은 예
def calculate_area(width, height):
    """사각형의 넓이를 계산합니다."""
    return width * height

# 나쁜 예
def CalculateArea(Width,Height):
    return Width*Height

# 네이밍 규칙
module_name = "my_module"        # 소문자 스네이크 케이스
CONSTANT_VALUE = 42              # 대문자 스네이크 케이스
class MyClass:                   # 파스칼 케이스
    pass
def my_function():               # 소문자 스네이크 케이스
    pass

# 들여쓰기: 스페이스 4칸
if True:
    print("들여쓰기 4칸")

# 한 줄 최대 길이: 79자
# 긴 줄은 백슬래시나 괄호로 나누기
long_string = (
    "매우 긴 문자열을 "
    "여러 줄로 나눠서 "
    "작성할 수 있습니다"
)
```

## 1.3.1.9. 유용한 내장 함수

```python
# 형변환
int("42")        # 42
float("3.14")    # 3.14
str(123)         # "123"
bool(1)          # True

# 수학 함수
abs(-5)          # 5
round(3.7)       # 4
pow(2, 3)        # 8
max(1, 5, 3)     # 5
min(1, 5, 3)     # 1
sum([1, 2, 3])   # 6

# 시퀀스 함수
len([1, 2, 3])   # 3
sorted([3, 1, 2]) # [1, 2, 3]
reversed([1, 2, 3]) # 역순 반복자
all([True, True, False])  # False
any([True, False, False]) # True

# 객체/타입 확인
type(42)         # <class 'int'>
isinstance(42, int)  # True
dir(object)      # 객체의 속성 목록
help(print)      # 함수 도움말
```
