# 1.3.6. Python 패키지 관리

패키지는 관련된 모듈들을 계층적으로 구성한 디렉토리 구조이며, pip를 통해 외부 패키지를 설치하고 관리할 수 있습니다.

## 1.3.6.1. 패키지 구조

```
mypackage/
├── __init__.py          # 패키지 초기화
├── module1.py
├── module2.py
└── subpackage/
    ├── __init__.py
    ├── module3.py
    └── module4.py
```

### \_\_init\_\_.py

```python
# mypackage/__init__.py
"""mypackage 패키지"""

__version__ = "1.0.0"
__author__ = "Your Name"

# 패키지 레벨에서 export할 항목
from .module1 import function1
from .module2 import MyClass

__all__ = ['function1', 'MyClass']

# 패키지 초기화 코드
print(f"mypackage {__version__} loaded")
```

### 모듈 import

```python
# 절대 import
from mypackage import function1
from mypackage.subpackage import module3

# 상대 import (패키지 내부에서)
from . import module1         # 같은 디렉토리
from .. import module2        # 부모 디렉토리
from ..subpackage import module3
```

## 1.3.6.2. pip - 패키지 설치 도구

### 기본 명령어 (Python 3.13)

```bash
# pip 버전 확인
python3.13 -m pip --version

# pip 업그레이드
python3.13 -m pip install --upgrade pip

# 패키지 설치
python3.13 -m pip install numpy
python3.13 -m pip install pandas==2.2.0  # 특정 버전
python3.13 -m pip install 'scikit-learn>=1.4.0'  # 버전 범위

# 여러 패키지 동시 설치
python3.13 -m pip install numpy pandas matplotlib

# requirements.txt에서 설치
python3.13 -m pip install -r requirements.txt

# 패키지 제거
python3.13 -m pip uninstall numpy

# 설치된 패키지 목록
python3.13 -m pip list
python3.13 -m pip freeze > requirements.txt

# 패키지 정보 확인
python3.13 -m pip show numpy

# 패키지 검색
python3.13 -m pip search requests

# 패키지 업그레이드
python3.13 -m pip install --upgrade numpy

# 개발 모드 설치 (수정사항 즉시 반영)
python3.13 -m pip install -e .
```

### requirements.txt 예제

```text
# 기본 데이터 처리
numpy>=1.26.0
pandas>=2.2.0
scipy>=1.12.0

# 시각화
matplotlib>=3.8.0
seaborn>=0.13.0
plotly>=5.18.0

# 머신러닝
scikit-learn>=1.4.0
tensorflow>=2.15.0
torch>=2.2.0

# 웹 프레임워크
django==5.0.1
flask>=3.0.0

# 테스트
pytest>=7.4.0
coverage>=7.4.0

# 코드 품질
black>=24.1.0
flake8>=7.0.0
mypy>=1.8.0
```

## 1.3.6.3. 가상환경 (Virtual Environment)

### venv (내장 모듈, Python 3.3+)

```bash
# 가상환경 생성
python3.13 -m venv myenv
python3.13 -m venv ~/venvs/project_env

# 활성화
source myenv/bin/activate         # Linux/macOS
myenv\Scripts\activate            # Windows

# 비활성화
deactivate

# 가상환경 삭제
rm -rf myenv
```

### virtualenvwrapper (Linux/macOS)

```bash
# 설치
python3.13 -m pip install virtualenvwrapper

# ~/.bashrc 또는 ~/.zshrc에 추가
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# 가상환경 생성
mkvirtualenv myenv

# 가상환경 활성화
workon myenv

# 가상환경 비활성화
deactivate

# 가상환경 목록
lsvirtualenv

# 가상환경 삭제
rmvirtualenv myenv
```

### conda (Anaconda)

```bash
# 환경 생성
conda create -n myenv python=3.13
conda create -n dataenv python=3.13 numpy pandas matplotlib

# 환경 활성화
conda activate myenv

# 환경 비활성화
conda deactivate

# 패키지 설치
conda install numpy
conda install -c conda-forge scikit-learn

# 환경 목록
conda env list

# 환경 삭제
conda env remove -n myenv

# 환경 export/import
conda env export > environment.yml
conda env create -f environment.yml
```

## 1.3.6.4. 필수 데이터 과학 패키지

### NumPy - 수치 계산

```python
import numpy as np

# 배열 생성
arr = np.array([1, 2, 3, 4, 5])
matrix = np.array([[1, 2, 3], [4, 5, 6]])

# 특수 배열
zeros = np.zeros((3, 3))
ones = np.ones((2, 4))
identity = np.eye(3)
random_arr = np.random.rand(3, 3)

# 배열 연산
print(arr + 10)
print(arr * 2)
print(arr ** 2)
print(np.sqrt(arr))

# 통계 함수
print(arr.mean())
print(arr.std())
print(arr.sum())
print(arr.max())
```

### pandas - 데이터 분석

```python
import pandas as pd

# DataFrame 생성
df = pd.DataFrame({
    'name': ['Alice', 'Bob', 'Charlie'],
    'age': [25, 30, 35],
    'city': ['Seoul', 'Busan', 'Incheon']
})

# 데이터 읽기/쓰기
df = pd.read_csv('data.csv')
df.to_csv('output.csv', index=False)

# 데이터 탐색
print(df.head())
print(df.info())
print(df.describe())

# 필터링
adults = df[df['age'] >= 25]

# 그룹화
grouped = df.groupby('city')['age'].mean()
```

### matplotlib - 시각화

```python
import matplotlib.pyplot as plt

# 선 그래프
x = [1, 2, 3, 4, 5]
y = [1, 4, 9, 16, 25]
plt.plot(x, y)
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Square Numbers')
plt.savefig('plot.png', dpi=150)
plt.show()
```

### scikit-learn - 머신러닝

```python
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

# 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# 모델 학습
model = LinearRegression()
model.fit(X_train, y_train)

# 예측
y_pred = model.predict(X_test)

# 평가
mse = mean_squared_error(y_test, y_pred)
```

### requests - HTTP 통신

```python
import requests

# GET 요청
response = requests.get('https://api.example.com/data')
print(response.status_code)
print(response.json())

# POST 요청
data = {'key': 'value'}
response = requests.post('https://api.example.com/', json=data)

# 헤더 설정
headers = {'Authorization': 'Bearer TOKEN'}
response = requests.get(url, headers=headers)
```

## 1.3.6.5. 패키지 배포

### setup.py 작성

```python
from setuptools import setup, find_packages

setup(
    name='mypackage',
    version='1.0.0',
    author='Your Name',
    author_email='your.email@example.com',
    description='A short description',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    url='https://github.com/yourusername/mypackage',
    packages=find_packages(),
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3.13',
    ],
    python_requires='>=3.13',
    install_requires=[
        'numpy>=1.26.0',
        'pandas>=2.2.0',
    ],
    extras_require={
        'dev': ['pytest>=7.4.0', 'black>=24.1.0'],
    },
)
```

### pyproject.toml (현대적 방식)

```toml
[build-system]
requires = ["setuptools>=68.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "mypackage"
version = "1.0.0"
description = "A short description"
readme = "README.md"
requires-python = ">=3.13"
license = {text = "MIT"}
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]
dependencies = [
    "numpy>=1.26.0",
    "pandas>=2.2.0",
]

[project.optional-dependencies]
dev = ["pytest>=7.4.0", "black>=24.1.0"]

[project.urls]
Homepage = "https://github.com/yourusername/mypackage"
```

### 패키지 빌드 및 배포

```bash
# 빌드 도구 설치
python3.13 -m pip install build twine

# 패키지 빌드
python3.13 -m build

# TestPyPI에 업로드 (테스트)
python3.13 -m twine upload --repository testpypi dist/*

# PyPI에 업로드
python3.13 -m twine upload dist/*
```

## 1.3.6.6. 의존성 관리

### Poetry

```bash
# 설치
curl -sSL https://install.python-poetry.org | python3 -

# 프로젝트 초기화
poetry init
poetry new myproject

# 패키지 추가
poetry add numpy
poetry add pytest --group dev

# 의존성 설치
poetry install

# 가상환경 활성화
poetry shell

# 실행
poetry run python script.py
```

### pipenv

```bash
# 설치
python3.13 -m pip install pipenv

# 가상환경 생성 및 패키지 설치
pipenv install numpy pandas

# 개발 의존성
pipenv install --dev pytest

# 가상환경 활성화
pipenv shell

# 실행
pipenv run python script.py

# 의존성 잠금
pipenv lock
```

## 1.3.6.7. 코드 품질 도구

### Black (코드 포매터)

```bash
# 설치
python3.13 -m pip install black

# 포매팅
black script.py
black src/

# 확인만 (변경 안 함)
black --check script.py
```

### flake8 (린터)

```bash
# 설치
python3.13 -m pip install flake8

# 검사
flake8 script.py
flake8 src/

# 설정 파일 (.flake8)
[flake8]
max-line-length = 88
extend-ignore = E203, W503
exclude = .git,__pycache__,venv
```

### mypy (타입 체커)

```bash
# 설치
python3.13 -m pip install mypy

# 타입 체크
mypy script.py
mypy src/
```

### pytest (테스트)

```bash
# 설치
python3.13 -m pip install pytest

# 테스트 실행
pytest
pytest tests/
pytest -v  # 상세 출력
pytest --cov=src  # 커버리지
```

## 1.3.6.8. 환경 변수 관리

### python-dotenv

```bash
# 설치
python3.13 -m pip install python-dotenv

# .env 파일
API_KEY=your_api_key_here
DATABASE_URL=postgresql://user:pass@localhost/db
DEBUG=True
```

```python
from dotenv import load_dotenv
import os

# .env 파일 로드
load_dotenv()

# 환경 변수 사용
api_key = os.getenv('API_KEY')
database_url = os.getenv('DATABASE_URL')
debug = os.getenv('DEBUG', 'False') == 'True'
```
