# 2.1.3. 행렬

행렬은 2차원 숫자 배열로, 데이터셋이나 선형 변환을 표현합니다.

## 2.1.3.1. 행렬 생성 (Python 3.13)

```python
import numpy as np

# 행렬 생성
A = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])

# 특수 행렬
zeros = np.zeros((3, 3))
ones = np.ones((3, 3))
identity = np.eye(3)  # 단위 행렬
diag = np.diag([1, 2, 3])  # 대각 행렬

# 랜덤 행렬
random = np.random.rand(3, 3)
randn = np.random.randn(3, 3)  # 정규분포
```

## 2.1.3.2. 행렬 인덱싱

```python
A = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])

# 요소 접근
print(A[0, 0])  # 1
print(A[1, 2])  # 6

# 행/열 추출
print(A[0, :])  # 첫 행: [1, 2, 3]
print(A[:, 1])  # 둘째 열: [2, 5, 8]

# 슬라이싱
print(A[0:2, 1:3])  # 부분 행렬
```

## 2.1.3.3. 행렬 연산

```python
A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])

# 요소별 연산
print(A + B)
print(A - B)
print(A * B)  # 요소별 곱 (Hadamard product)

# 행렬 곱
print(A @ B)      # 권장
print(np.dot(A, B))
print(np.matmul(A, B))

# 전치 (transpose)
print(A.T)

# 대각합 (trace)
print(np.trace(A))  # 1 + 4 = 5
```

## 2.1.3.4. 역행렬과 행렬식

```python
A = np.array([[1, 2], [3, 4]])

# 행렬식 (determinant)
det = np.linalg.det(A)  # -2

# 역행렬
A_inv = np.linalg.inv(A)

# 검증
print(A @ A_inv)  # 단위 행렬 (근사)
```

## 2.1.3.5. 행렬 분해

```python
# LU 분해
from scipy.linalg import lu
P, L, U = lu(A)

# QR 분해
Q, R = np.linalg.qr(A)

# 특이값 분해 (SVD)
U, S, Vt = np.linalg.svd(A)
```

## 2.1.3.6. R에서의 행렬

```r
# 행렬 생성
A <- matrix(c(1, 2, 3, 4), nrow=2, ncol=2)

# 전치
t(A)

# 행렬 곱
A %*% A

# 역행렬
solve(A)

# 행렬식
det(A)

# 대각합
sum(diag(A))

# 고유값 분해
eigen(A)

# SVD
svd(A)
```

## 2.1.3.7. 선형 연립방정식

```python
# Ax = b 풀기
A = np.array([[2, 1], [5, 7]])
b = np.array([11, 13])

x = np.linalg.solve(A, b)
print(x)  # [7.11, -3.22]

# 검증
print(A @ x)  # b와 거의 같음
```
