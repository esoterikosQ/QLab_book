# 1.3.2. Python 자료구조

Python의 기본 자료구조는 효율적인 데이터 저장과 처리의 핵심입니다.

## 1.3.2.1. 리스트 (List)

순서가 있고 변경 가능한(mutable) 시퀀스 자료형입니다.

```python
# 생성
numbers = [1, 2, 3, 4, 5]
mixed = [1, "hello", 3.14, True]
nested = [[1, 2], [3, 4], [5, 6]]
empty = []

# 인덱싱
print(numbers[0])   # 1 (첫 요소)
print(numbers[-1])  # 5 (마지막 요소)

# 슬라이싱
print(numbers[1:4])   # [2, 3, 4]
print(numbers[:3])    # [1, 2, 3]
print(numbers[3:])    # [4, 5]
print(numbers[::2])   # [1, 3, 5] (2칸씩)
print(numbers[::-1])  # [5, 4, 3, 2, 1] (역순)

# 추가/삽입
numbers.append(6)         # [1, 2, 3, 4, 5, 6]
numbers.insert(0, 0)      # [0, 1, 2, 3, 4, 5, 6]
numbers.extend([7, 8])    # [0, 1, 2, 3, 4, 5, 6, 7, 8]

# 삭제
numbers.remove(0)         # 값으로 삭제
popped = numbers.pop()    # 마지막 요소 제거 및 반환
popped = numbers.pop(0)   # 인덱스 0 제거
del numbers[0]            # 인덱스로 삭제
numbers.clear()           # 모두 삭제

# 검색
fruits = ['apple', 'banana', 'cherry']
print('apple' in fruits)       # True
print(fruits.index('banana'))  # 1
print(fruits.count('apple'))   # 1

# 정렬
nums = [3, 1, 4, 1, 5, 9, 2, 6]
nums.sort()                    # 원본 변경
print(nums)                    # [1, 1, 2, 3, 4, 5, 6, 9]

sorted_nums = sorted(nums, reverse=True)  # 새 리스트 반환
print(sorted_nums)             # [9, 6, 5, 4, 3, 2, 1, 1]

# 리스트 컴프리헨션
squares = [x**2 for x in range(10)]
evens = [x for x in range(20) if x % 2 == 0]
matrix = [[i*j for j in range(3)] for i in range(3)]

# 중첩 리스트 평탄화
nested = [[1, 2], [3, 4], [5, 6]]
flat = [item for sublist in nested for item in sublist]
print(flat)  # [1, 2, 3, 4, 5, 6]
```

## 1.3.2.2. 튜플 (Tuple)

순서가 있고 변경 불가능한(immutable) 시퀀스 자료형입니다.

```python
# 생성
point = (3, 4)
single = (1,)      # 단일 요소 튜플은 쉼표 필수
coordinates = (10.0, 20.0, 30.0)

# 언패킹
x, y = point
print(x, y)  # 3 4

# 여러 값 반환
def get_stats(numbers):
    return min(numbers), max(numbers), sum(numbers)

minimum, maximum, total = get_stats([1, 2, 3, 4, 5])

# 스왑
a, b = 10, 20
a, b = b, a  # swap
print(a, b)  # 20 10

# 네임드 튜플
from collections import namedtuple

Point = namedtuple('Point', ['x', 'y'])
p = Point(3, 4)
print(p.x, p.y)  # 3 4
print(p[0], p[1])  # 3 4

Person = namedtuple('Person', 'name age city')
person = Person('Alice', 25, 'Seoul')
print(person.name)  # Alice
```

## 1.3.2.3. 딕셔너리 (Dictionary)

키-값 쌍을 저장하는 변경 가능한 자료형입니다 (Python 3.7+부터 삽입 순서 유지).

```python
# 생성
student = {
    'name': 'Alice',
    'age': 20,
    'grade': 'A',
    'courses': ['Math', 'Physics']
}

# dict() 생성자
person = dict(name='Bob', age=30)

# 접근
print(student['name'])  # Alice
print(student.get('age'))  # 20
print(student.get('email', 'N/A'))  # 없으면 기본값 'N/A'

# 추가/수정
student['email'] = 'alice@example.com'
student['age'] = 21

# 삭제
del student['grade']
email = student.pop('email')  # 제거 및 반환
last_item = student.popitem()  # 마지막 항목 제거

# 키 확인
print('name' in student)  # True

# 순회
for key in student:
    print(f"{key}: {student[key]}")

for key, value in student.items():
    print(f"{key}: {value}")

for key in student.keys():
    print(key)

for value in student.values():
    print(value)

# 병합 (Python 3.9+)
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}
merged = dict1 | dict2  # {'a': 1, 'b': 3, 'c': 4}

# update
dict1.update(dict2)

# 딕셔너리 컴프리헨션
squares = {x: x**2 for x in range(5)}  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}

# DefaultDict (자동 초기화)
from collections import defaultdict

word_count = defaultdict(int)
for word in ['apple', 'banana', 'apple']:
    word_count[word] += 1
print(dict(word_count))  # {'apple': 2, 'banana': 1}

# Counter (빈도 계산)
from collections import Counter

words = ['apple', 'banana', 'apple', 'cherry', 'banana', 'apple']
counter = Counter(words)
print(counter)  # Counter({'apple': 3, 'banana': 2, 'cherry': 1})
print(counter.most_common(2))  # [('apple', 3), ('banana', 2)]
```

## 1.3.2.4. 집합 (Set)

중복을 허용하지 않는 순서 없는 자료형입니다.

```python
# 생성
fruits = {'apple', 'banana', 'cherry'}
nums = set([1, 2, 2, 3, 3, 3])  # {1, 2, 3}
empty = set()  # 빈 집합 ({}는 딕셔너리)

# 추가/삭제
fruits.add('orange')
fruits.remove('banana')  # 없으면 KeyError
fruits.discard('grape')  # 없어도 오류 없음
item = fruits.pop()      # 임의 요소 제거

# 집합 연산
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}

print(a | b)  # 합집합: {1, 2, 3, 4, 5, 6}
print(a & b)  # 교집합: {3, 4}
print(a - b)  # 차집합: {1, 2}
print(a ^ b)  # 대칭차집합: {1, 2, 5, 6}

# 메서드
print(a.union(b))
print(a.intersection(b))
print(a.difference(b))
print(a.symmetric_difference(b))

# 부분집합 확인
print({1, 2}.issubset(a))     # True
print(a.issuperset({1, 2}))   # True
print(a.isdisjoint(b))        # False (공통 요소 있음)

# 중복 제거
numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
unique = list(set(numbers))   # [1, 2, 3, 4]

# frozenset (불변 집합)
frozen = frozenset([1, 2, 3])
# frozen.add(4)  # AttributeError (변경 불가)
```

## 1.3.2.5. 문자열 (String)

문자열은 불변 시퀀스입니다.

```python
# 생성
text = "Hello, World!"
multiline = """여러 줄
문자열"""

# 인덱싱/슬라이싱
print(text[0])      # H
print(text[-1])     # !
print(text[0:5])    # Hello

# 메서드
print(text.lower())            # hello, world!
print(text.upper())            # HELLO, WORLD!
print(text.replace('World', 'Python'))  # Hello, Python!
print(text.split(','))         # ['Hello', ' World!']
print('-'.join(['a', 'b', 'c']))  # a-b-c

# 검색
print('World' in text)         # True
print(text.startswith('Hello'))  # True
print(text.endswith('!'))      # True
print(text.find('World'))      # 7
print(text.index('World'))     # 7

# 공백 제거
text = "  hello  "
print(text.strip())   # "hello"
print(text.lstrip())  # "hello  "
print(text.rstrip())  # "  hello"

# 포매팅
name = "Alice"
age = 25

# f-string (Python 3.6+, 권장)
print(f"{name} is {age} years old")
print(f"{age * 2 = }")  # age * 2 = 50 (Python 3.8+)

# format
print("{} is {} years old".format(name, age))
print("{name} is {age} years old".format(name=name, age=age))

# % 포매팅 (옛날 방식)
print("%s is %d years old" % (name, age))

# 정렬/패딩
print(f"{age:5}")    # "   25"
print(f"{age:05}")   # "00025"
print(f"{3.14159:.2f}")  # "3.14"
```

## 1.3.2.6. 고급 자료구조 (collections 모듈)

### deque (양방향 큐)

```python
from collections import deque

# 생성
dq = deque([1, 2, 3])

# 양쪽에서 추가/제거
dq.append(4)        # 오른쪽에 추가
dq.appendleft(0)    # 왼쪽에 추가
dq.pop()            # 오른쪽에서 제거
dq.popleft()        # 왼쪽에서 제거

# 회전
dq.rotate(1)        # 오른쪽으로 1칸 회전
dq.rotate(-1)       # 왼쪽으로 1칸 회전

print(dq)  # deque([1, 2, 3])
```

### OrderedDict (순서 유지 딕셔너리)

```python
from collections import OrderedDict

# Python 3.7+에서는 일반 dict도 순서 유지
# OrderedDict는 순서 변경 메서드 제공
od = OrderedDict()
od['a'] = 1
od['b'] = 2
od['c'] = 3

# 마지막/처음 항목 이동
od.move_to_end('a')  # a를 맨 끝으로
od.move_to_end('b', last=False)  # b를 맨 앞으로
```

### ChainMap (여러 딕셔너리 연결)

```python
from collections import ChainMap

dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}
chain = ChainMap(dict1, dict2)

print(chain['b'])  # 2 (첫 번째 딕셔너리 우선)
print(list(chain))  # ['b', 'c', 'a']
```

## 1.3.2.7. 시간 복잡도

| 연산 | 리스트 | 튜플 | 딕셔너리 | 집합 |
|------|--------|------|----------|------|
| 인덱싱 | O(1) | O(1) | N/A | N/A |
| 검색 | O(n) | O(n) | O(1) | O(1) |
| 삽입 | O(n) | N/A | O(1) | O(1) |
| 삭제 | O(n) | N/A | O(1) | O(1) |
| append | O(1) | N/A | N/A | N/A |

## 1.3.2.8. 실전 예제

```python
# 단어 빈도 계산
from collections import Counter

text = "apple banana apple cherry banana apple"
words = text.split()
freq = Counter(words)
print(freq.most_common(2))  # [('apple', 3), ('banana', 2)]

# 리스트 중복 제거 (순서 유지)
items = [1, 2, 2, 3, 1, 4, 3, 5]
unique = list(dict.fromkeys(items))  # [1, 2, 3, 4, 5]

# 딕셔너리 키로 정렬
scores = {'Alice': 85, 'Bob': 92, 'Charlie': 78}
sorted_scores = dict(sorted(scores.items(), key=lambda x: x[1], reverse=True))
print(sorted_scores)  # {'Bob': 92, 'Alice': 85, 'Charlie': 78}

# 2차원 리스트 전치
matrix = [[1, 2, 3], [4, 5, 6]]
transposed = list(zip(*matrix))  # [(1, 4), (2, 5), (3, 6)]
transposed = [list(row) for row in zip(*matrix)]  # [[1, 4], [2, 5], [3, 6]]
```
