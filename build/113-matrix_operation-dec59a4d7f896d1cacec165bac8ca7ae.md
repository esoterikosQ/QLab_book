# 2.1.4. 행렬 연산

## 2.1.4.1. 행렬 곱 (Python 3.13)

```python
import numpy as np

A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])

# 행렬 곱 (A의 열 = B의 행)
C = A @ B
print(C)
# [[19, 22],
#  [43, 50]]

# 계산: C[0,0] = 1*5 + 2*7 = 19
#      C[0,1] = 1*6 + 2*8 = 22
```

## 2.1.4.2. 벡터-행렬 곱

```python
A = np.array([[1, 2, 3],
              [4, 5, 6]])
x = np.array([1, 2, 3])

# Ax (2x3 @ 3x1 = 2x1)
y = A @ x
print(y)  # [14, 32]
```

## 2.1.4.3. 행렬 거듭제곱

```python
A = np.array([[1, 2], [3, 4]])

# A^2
A2 = np.linalg.matrix_power(A, 2)
print(A2)

# A^(-1) (역행렬)
A_inv = np.linalg.matrix_power(A, -1)
```

## 2.1.4.4. 크로네커 곱

```python
A = np.array([[1, 2], [3, 4]])
B = np.array([[0, 5], [6, 7]])

kron = np.kron(A, B)
print(kron)
```

## 2.1.4.5. 행렬 노름

```python
A = np.array([[1, 2], [3, 4]])

# Frobenius norm
frob = np.linalg.norm(A, 'fro')

# 2-norm (spectral norm)
spec = np.linalg.norm(A, 2)

# 무한대 노름
inf = np.linalg.norm(A, np.inf)
```

## 2.1.4.6. R에서의 행렬 연산

```r
A <- matrix(c(1, 2, 3, 4), nrow=2)
B <- matrix(c(5, 6, 7, 8), nrow=2)

# 행렬 곱
C <- A %*% B

# 요소별 곱
H <- A * B

# 크로네커 곱
kron <- kronecker(A, B)

# 행렬 거듭제곱
library(expm)
A2 <- A %^% 2
```

## 2.1.4.7. 블록 행렬 연산

```python
# 블록 행렬 생성
A11 = np.array([[1, 2], [3, 4]])
A12 = np.array([[5, 6], [7, 8]])
A21 = np.array([[9, 10], [11, 12]])
A22 = np.array([[13, 14], [15, 16]])

# 블록 결합
A = np.block([[A11, A12],
              [A21, A22]])
```
