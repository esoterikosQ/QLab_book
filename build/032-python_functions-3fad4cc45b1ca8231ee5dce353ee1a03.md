# 1.3.3. Python 함수

함수는 재사용 가능한 코드 블록으로, 프로그램을 모듈화하고 유지보수를 용이하게 합니다.

## 1.3.3.1. 함수 정의와 호출

```python
# 기본 함수
def greet(name):
    """사용자에게 인사하는 함수"""
    return f"Hello, {name}!"

result = greet("Alice")
print(result)  # Hello, Alice!

# 여러 값 반환
def get_min_max(numbers):
    return min(numbers), max(numbers)

minimum, maximum = get_min_max([1, 5, 3, 9, 2])
print(f"Min: {minimum}, Max: {maximum}")

# 기본 인자
def power(base, exponent=2):
    return base ** exponent

print(power(3))      # 9
print(power(3, 3))   # 27

# 키워드 인자
def create_profile(name, age, city="Seoul"):
    return {"name": name, "age": age, "city": city}

profile = create_profile(name="Alice", age=25)
profile = create_profile("Bob", 30, city="Busan")
```

## 1.3.3.2. 가변 인자

```python
# *args: 가변 위치 인자
def sum_all(*args):
    return sum(args)

print(sum_all(1, 2, 3))        # 6
print(sum_all(1, 2, 3, 4, 5))  # 15

# **kwargs: 가변 키워드 인자
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_info(name="Alice", age=25, city="Seoul")

# 혼합 사용
def mixed_args(a, b, *args, key1="default", **kwargs):
    print(f"a={a}, b={b}")
    print(f"args={args}")
    print(f"key1={key1}")
    print(f"kwargs={kwargs}")

mixed_args(1, 2, 3, 4, 5, key1="value", extra="data")
```

## 1.3.3.3. 람다 함수

```python
# 일반 함수
def square(x):
    return x ** 2

# 람다 함수
square_lambda = lambda x: x ** 2

print(square(5))         # 25
print(square_lambda(5))  # 25

# map, filter, sorted와 함께 사용
numbers = [1, 2, 3, 4, 5]

# map: 각 요소에 함수 적용
squared = list(map(lambda x: x**2, numbers))
print(squared)  # [1, 4, 9, 16, 25]

# filter: 조건에 맞는 요소만 선택
evens = list(filter(lambda x: x % 2 == 0, numbers))
print(evens)  # [2, 4]

# sorted: 정렬 키 지정
students = [('Alice', 85), ('Bob', 92), ('Charlie', 78)]
sorted_students = sorted(students, key=lambda x: x[1], reverse=True)
print(sorted_students)  # [('Bob', 92), ('Alice', 85), ('Charlie', 78)]
```

## 1.3.3.4. 클로저 (Closure)

```python
def outer_function(x):
    def inner_function(y):
        return x + y
    return inner_function

add_5 = outer_function(5)
print(add_5(3))  # 8
print(add_5(7))  # 12

# 실용 예제: 카운터
def make_counter():
    count = 0
    def counter():
        nonlocal count
        count += 1
        return count
    return counter

counter1 = make_counter()
print(counter1())  # 1
print(counter1())  # 2
print(counter1())  # 3

counter2 = make_counter()
print(counter2())  # 1 (독립적인 카운터)
```

## 1.3.3.5. 데코레이터

```python
# 기본 데코레이터
def uppercase_decorator(func):
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        return result.upper()
    return wrapper

@uppercase_decorator
def greet(name):
    return f"hello, {name}"

print(greet("alice"))  # HELLO, ALICE

# 실행 시간 측정 데코레이터
import time
from functools import wraps

def timer(func):
    @wraps(func)  # 원본 함수의 메타데이터 보존
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} 실행시간: {end - start:.4f}초")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
    return "완료"

slow_function()

# 인자를 받는 데코레이터
def repeat(times):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for _ in range(times):
                result = func(*args, **kwargs)
            return result
        return wrapper
    return decorator

@repeat(3)
def say_hello():
    print("Hello!")

say_hello()  # Hello! 3번 출력

# 클래스 데코레이터
class CountCalls:
    def __init__(self, func):
        self.func = func
        self.count = 0
    
    def __call__(self, *args, **kwargs):
        self.count += 1
        print(f"호출 횟수: {self.count}")
        return self.func(*args, **kwargs)

@CountCalls
def process_data():
    print("데이터 처리 중...")

process_data()
process_data()
```

## 1.3.3.6. 제너레이터

```python
# yield를 사용한 제너레이터
def count_up_to(n):
    count = 1
    while count <= n:
        yield count
        count += 1

counter = count_up_to(5)
for num in counter:
    print(num)  # 1 2 3 4 5

# 제너레이터 표현식
squares = (x**2 for x in range(10))
print(next(squares))  # 0
print(next(squares))  # 1

# 실용 예제: 큰 파일 읽기
def read_large_file(file_path):
    """메모리 효율적인 파일 읽기"""
    with open(file_path, 'r') as f:
        for line in f:
            yield line.strip()

# 피보나치 수열
def fibonacci():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

fib = fibonacci()
for _ in range(10):
    print(next(fib), end=' ')  # 0 1 1 2 3 5 8 13 21 34
```

## 1.3.3.7. 재귀 함수

```python
# 팩토리얼
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

print(factorial(5))  # 120

# 피보나치 (비효율적)
def fibonacci_recursive(n):
    if n <= 1:
        return n
    return fibonacci_recursive(n-1) + fibonacci_recursive(n-2)

# 메모이제이션으로 최적화
from functools import lru_cache

@lru_cache(maxsize=None)
def fibonacci_memo(n):
    if n <= 1:
        return n
    return fibonacci_memo(n-1) + fibonacci_memo(n-2)

print(fibonacci_memo(100))  # 빠르게 계산

# 하노이 탑
def hanoi(n, source, target, auxiliary):
    if n == 1:
        print(f"{source} -> {target}")
        return
    hanoi(n-1, source, auxiliary, target)
    print(f"{source} -> {target}")
    hanoi(n-1, auxiliary, target, source)

hanoi(3, 'A', 'C', 'B')
```

## 1.3.3.8. 내장 함수 활용

```python
# map: 모든 요소에 함수 적용
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, numbers))

# filter: 조건을 만족하는 요소만
evens = list(filter(lambda x: x % 2 == 0, numbers))

# reduce: 누적 계산
from functools import reduce
product = reduce(lambda x, y: x * y, numbers)
print(product)  # 120

# zip: 여러 이터러블 묶기
names = ['Alice', 'Bob', 'Charlie']
ages = [25, 30, 35]
combined = list(zip(names, ages))
print(combined)  # [('Alice', 25), ('Bob', 30), ('Charlie', 35)]

# enumerate: 인덱스와 값
for idx, value in enumerate(['a', 'b', 'c'], start=1):
    print(f"{idx}: {value}")

# any, all: 논리 연산
print(any([False, True, False]))   # True
print(all([True, True, False]))    # False

# sorted: 정렬 (원본 유지)
nums = [3, 1, 4, 1, 5, 9]
sorted_nums = sorted(nums)
sorted_desc = sorted(nums, reverse=True)

# min, max with key
students = [('Alice', 85), ('Bob', 92), ('Charlie', 78)]
best_student = max(students, key=lambda x: x[1])
print(best_student)  # ('Bob', 92)
```

## 1.3.3.9. 타입 힌팅 (Python 3.5+)

```python
from typing import List, Dict, Tuple, Optional, Union, Callable

def greet(name: str) -> str:
    return f"Hello, {name}"

def sum_numbers(numbers: List[int]) -> int:
    return sum(numbers)

def get_user(user_id: int) -> Optional[Dict[str, str]]:
    """사용자를 반환하거나 None 반환"""
    if user_id > 0:
        return {"name": "Alice", "email": "alice@example.com"}
    return None

def process_value(value: Union[int, str]) -> str:
    """int 또는 str을 받아 str 반환"""
    return str(value)

def apply_function(func: Callable[[int, int], int], x: int, y: int) -> int:
    """함수를 인자로 받아 실행"""
    return func(x, y)

# Python 3.9+: 내장 타입 직접 사용
def process_items(items: list[str]) -> dict[str, int]:
    return {item: len(item) for item in items}

# Python 3.10+: Union type 간소화
def parse_value(value: int | str | float) -> str:
    return str(value)
```

## 1.3.3.10. 함수형 프로그래밍

```python
from functools import reduce, partial
from operator import add, mul

# partial: 부분 적용
def power(base, exponent):
    return base ** exponent

square = partial(power, exponent=2)
cube = partial(power, exponent=3)

print(square(5))  # 25
print(cube(5))    # 125

# compose: 함수 합성
def compose(*functions):
    def inner(arg):
        result = arg
        for f in reversed(functions):
            result = f(result)
        return result
    return inner

def add_one(x):
    return x + 1

def multiply_two(x):
    return x * 2

f = compose(multiply_two, add_one)
print(f(5))  # (5 + 1) * 2 = 12

# pipe: 파이프라인
def pipe(value, *functions):
    for func in functions:
        value = func(value)
    return value

result = pipe(5, add_one, multiply_two)
print(result)  # (5 + 1) * 2 = 12
```
