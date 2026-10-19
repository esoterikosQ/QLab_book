# 1.3.5. Python 모듈

모듈은 관련된 함수, 클래스, 변수를 하나의 파일에 모아둔 것입니다.

## 1.3.5.1. 모듈 생성과 import

### 모듈 생성

```python
# math_utils.py
"""수학 유틸리티 모듈"""

PI = 3.14159

def add(a, b):
    """두 수를 더합니다"""
    return a + b

def multiply(a, b):
    """두 수를 곱합니다"""
    return a * b

class Calculator:
    def __init__(self):
        self.result = 0
    
    def add(self, value):
        self.result += value
        return self

# 모듈이 직접 실행될 때만 실행
if __name__ == "__main__":
    print("math_utils 모듈이 직접 실행되었습니다")
    print(f"PI = {PI}")
```

### import 방법

```python
# 1. 전체 모듈 import
import math_utils
result = math_utils.add(3, 5)
print(math_utils.PI)

# 2. 특정 요소만 import
from math_utils import add, PI
result = add(3, 5)
print(PI)

# 3. 별칭 사용
import math_utils as mu
result = mu.add(3, 5)

from math_utils import Calculator as Calc
calc = Calc()

# 4. 모든 요소 import (권장하지 않음)
from math_utils import *

# 5. 하위 모듈 import
import os.path
print(os.path.exists("file.txt"))

from os.path import exists
print(exists("file.txt"))
```

## 1.3.5.2. 표준 라이브러리 모듈

### os - 운영체제 인터페이스

```python
import os

# 현재 디렉토리
print(os.getcwd())

# 디렉토리 변경
os.chdir('/tmp')

# 디렉토리 목록
print(os.listdir('.'))

# 파일/디렉토리 생성
os.mkdir('new_dir')
os.makedirs('path/to/dir', exist_ok=True)

# 파일/디렉토리 삭제
os.remove('file.txt')
os.rmdir('empty_dir')

# 파일 존재 확인
print(os.path.exists('file.txt'))
print(os.path.isfile('file.txt'))
print(os.path.isdir('directory'))

# 경로 조작
path = os.path.join('folder', 'subfolder', 'file.txt')
dirname = os.path.dirname(path)
basename = os.path.basename(path)
filename, ext = os.path.splitext('document.pdf')

# 환경 변수
home = os.environ.get('HOME')
os.environ['MY_VAR'] = 'value'

# 시스템 명령 실행
os.system('ls -la')
```

### pathlib - 객체 지향 경로 (Python 3.4+, 권장)

```python
from pathlib import Path

# 경로 객체 생성
path = Path('folder/subfolder/file.txt')
home = Path.home()
cwd = Path.cwd()

# 경로 조작
new_path = path.parent / 'new_file.txt'
print(path.name)        # file.txt
print(path.stem)        # file
print(path.suffix)      # .txt
print(path.parent)      # folder/subfolder

# 파일 존재 확인
print(path.exists())
print(path.is_file())
print(path.is_dir())

# 파일 읽기/쓰기
path.write_text("Hello, World!", encoding='utf-8')
content = path.read_text(encoding='utf-8')

# 디렉토리 순회
for file in Path('.').glob('*.py'):
    print(file)

for file in Path('.').rglob('*.txt'):  # 재귀 검색
    print(file)

# 디렉토리 생성
Path('new_dir').mkdir(parents=True, exist_ok=True)
```

### sys - 시스템 관련 파라미터와 함수

```python
import sys

# 명령행 인자
print(sys.argv)  # ['script.py', 'arg1', 'arg2']

# Python 버전 정보
print(sys.version)
print(sys.version_info)

# 모듈 경로
print(sys.path)

# 표준 출력/에러
sys.stdout.write("Standard output\n")
sys.stderr.write("Error message\n")

# 프로그램 종료
sys.exit(0)  # 정상 종료
sys.exit(1)  # 오류 종료
```

### datetime - 날짜와 시간

```python
from datetime import datetime, date, time, timedelta

# 현재 날짜/시간
now = datetime.now()
today = date.today()

print(now)   # 2024-03-09 15:30:45.123456
print(today) # 2024-03-09

# 날짜/시간 생성
dt = datetime(2024, 3, 9, 15, 30, 45)
d = date(2024, 3, 9)
t = time(15, 30, 45)

# 포매팅
print(now.strftime("%Y-%m-%d %H:%M:%S"))  # 2024-03-09 15:30:45
print(now.strftime("%Y년 %m월 %d일"))      # 2024년 03월 09일

# 문자열에서 파싱
dt = datetime.strptime("2024-03-09", "%Y-%m-%d")

# 시간 연산
tomorrow = today + timedelta(days=1)
week_ago = now - timedelta(weeks=1)
two_hours_later = now + timedelta(hours=2)

# 날짜 비교
if today > date(2020, 1, 1):
    print("2020년 이후입니다")

# 날짜 차이
diff = date(2024, 12, 31) - today
print(f"{diff.days}일 남았습니다")
```

### json - JSON 처리

```python
import json

# Python 객체 → JSON 문자열
data = {
    "name": "Alice",
    "age": 25,
    "courses": ["Math", "Physics"],
    "is_student": True
}

json_string = json.dumps(data, ensure_ascii=False, indent=2)
print(json_string)

# JSON 문자열 → Python 객체
parsed = json.loads(json_string)

# 파일 저장
with open('data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

# 파일 읽기
with open('data.json', 'r', encoding='utf-8') as f:
    loaded_data = json.load(f)
```

### random - 난수 생성

```python
import random

# 난수 생성
print(random.random())        # 0.0 ~ 1.0
print(random.uniform(1, 10))  # 1.0 ~ 10.0 실수
print(random.randint(1, 100)) # 1 ~ 100 정수
print(random.randrange(0, 100, 5))  # 0 ~ 95, 5씩 증가

# 시퀀스에서 선택
colors = ['red', 'green', 'blue']
print(random.choice(colors))         # 하나 선택
print(random.choices(colors, k=3))   # 중복 허용 3개 선택
print(random.sample(colors, k=2))    # 중복 없이 2개 선택

# 섞기
numbers = [1, 2, 3, 4, 5]
random.shuffle(numbers)
print(numbers)

# 시드 설정 (재현 가능한 난수)
random.seed(42)
print(random.random())  # 항상 같은 값
```

### re - 정규표현식

```python
import re

text = "My email is alice@example.com and phone is 010-1234-5678"

# 패턴 검색
match = re.search(r'\w+@\w+\.\w+', text)
if match:
    print(match.group())  # alice@example.com

# 모든 매치 찾기
emails = re.findall(r'\w+@\w+\.\w+', text)
print(emails)

# 치환
new_text = re.sub(r'\d{3}-\d{4}-\d{4}', '***-****-****', text)
print(new_text)

# 분할
parts = re.split(r'[,\s]+', "apple, banana   cherry")
print(parts)  # ['apple', 'banana', 'cherry']

# 컴파일 (반복 사용시 효율적)
pattern = re.compile(r'\d+')
numbers = pattern.findall("I have 3 apples and 5 oranges")
print(numbers)  # ['3', '5']

# 그룹 캡처
match = re.search(r'(\d{3})-(\d{4})-(\d{4})', text)
if match:
    print(match.group(1))  # 010
    print(match.groups())  # ('010', '1234', '5678')
```

### collections - 특수 컨테이너

```python
from collections import Counter, defaultdict, deque, namedtuple, OrderedDict

# Counter - 빈도 계산
words = ['apple', 'banana', 'apple', 'cherry', 'banana', 'apple']
counter = Counter(words)
print(counter)  # Counter({'apple': 3, 'banana': 2, 'cherry': 1})
print(counter.most_common(2))

# defaultdict - 기본값 설정
dd = defaultdict(int)
for word in words:
    dd[word] += 1

dd_list = defaultdict(list)
dd_list['fruits'].append('apple')

# deque - 양쪽에서 O(1) 추가/제거
dq = deque([1, 2, 3])
dq.appendleft(0)
dq.append(4)
dq.popleft()
dq.pop()

# namedtuple - 필드 이름이 있는 튜플
Point = namedtuple('Point', ['x', 'y'])
p = Point(3, 4)
print(p.x, p.y)
```

### itertools - 반복자 도구

```python
import itertools

# 무한 반복자
for i in itertools.count(10, 2):  # 10, 12, 14, ...
    if i > 20:
        break
    print(i)

# 순열과 조합
items = ['A', 'B', 'C']
print(list(itertools.permutations(items, 2)))    # 순열
print(list(itertools.combinations(items, 2)))    # 조합
print(list(itertools.product(items, repeat=2)))  # 곱집합

# 그룹화
data = [1, 1, 2, 2, 2, 3, 3]
for key, group in itertools.groupby(data):
    print(f"{key}: {list(group)}")

# 체인
list1 = [1, 2, 3]
list2 = [4, 5, 6]
for item in itertools.chain(list1, list2):
    print(item)
```

## 1.3.5.3. 모듈 검색 경로

```python
import sys

# 모듈 검색 경로 확인
print(sys.path)

# 경로 추가
sys.path.append('/path/to/modules')
sys.path.insert(0, '/priority/path')

# 환경 변수로 추가
# export PYTHONPATH=/path/to/modules
```

## 1.3.5.4. \_\_name\_\_ 활용

```python
# module.py
def main():
    print("Main function executed")

if __name__ == "__main__":
    # 직접 실행될 때만 실행
    main()
else:
    # import될 때는 실행 안 됨
    pass
```

## 1.3.5.5. importlib - 동적 import

```python
import importlib

# 동적으로 모듈 import
module_name = "math"
module = importlib.import_module(module_name)
print(module.sqrt(16))

# 모듈 리로드
importlib.reload(module)
```
