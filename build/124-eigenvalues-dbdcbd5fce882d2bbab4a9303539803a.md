# 2.1.5. 고유값과 고유벡터

고유값과 고유벡터는 행렬의 본질적 특성을 나타내며, PCA, 페이지랭크 등에 사용됩니다.

## 2.1.5.1. 정의

행렬 $A$, 벡터 $v$, 스칼라 $\lambda$에 대해:
$$Av = \lambda v$$

- $\lambda$: 고유값 (eigenvalue)
- $v$: 고유벡터 (eigenvector)

## 2.1.5.2. 계산 (Python 3.13)

```python
import numpy as np

A = np.array([[4, -2],
              [1,  1]])

# 고유값과 고유벡터 계산
eigenvalues, eigenvectors = np.linalg.eig(A)

print("Eigenvalues:", eigenvalues)   # [3., 2.]
print("Eigenvectors:\n", eigenvectors)

# 검증
v1 = eigenvectors[:, 0]
lambda1 = eigenvalues[0]
print(np.allclose(A @ v1, lambda1 * v1))  # True
```

## 2.1.5.3. 대칭 행렬의 고유값 분해

```python
# 대칭 행렬
A = np.array([[3, 1],
              [1, 3]])

eigenvalues, eigenvectors = np.linalg.eigh(A)  # 대칭 행렬 전용 (더 빠름)

print("Eigenvalues:", eigenvalues)  # [2., 4.]

# 대각화: A = Q Λ Q^T
Q = eigenvectors
Lambda = np.diag(eigenvalues)

A_reconstructed = Q @ Lambda @ Q.T
print(np.allclose(A, A_reconstructed))  # True
```

## 2.1.5.4. 특이값 분해 (SVD)

```python
A = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])

U, S, Vt = np.linalg.svd(A)

print("U shape:", U.shape)    # (3, 3)
print("S shape:", S.shape)    # (3,)
print("Vt shape:", Vt.shape)  # (3, 3)

# 재구성
Sigma = np.zeros_like(A, dtype=float)
Sigma[:S.shape[0], :S.shape[0]] = np.diag(S)
A_reconstructed = U @ Sigma @ Vt

print(np.allclose(A, A_reconstructed))  # True
```

## 2.1.5.5. 주성분 분석 (PCA)

```python
# 데이터 중심화
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
X_centered = X - X.mean(axis=0)

# 공분산 행렬
cov = np.cov(X_centered.T)

# 고유값 분해
eigenvalues, eigenvectors = np.linalg.eig(cov)

# 주성분 (고유값이 큰 순서)
idx = eigenvalues.argsort()[::-1]
eigenvalues = eigenvalues[idx]
eigenvectors = eigenvectors[:, idx]

# 차원 축소 (첫 k개 주성분)
k = 1
PC = eigenvectors[:, :k]
X_reduced = X_centered @ PC
```

## 2.1.5.6. R에서의 고유값

```r
A <- matrix(c(4, -2, 1, 1), nrow=2)

# 고유값 분해
result <- eigen(A)
eigenvalues <- result$values
eigenvectors <- result$vectors

print(eigenvalues)

# SVD
A <- matrix(1:9, nrow=3)
result <- svd(A)
U <- result$u
D <- diag(result$d)
V <- result$v

# PCA
data <- matrix(rnorm(100), ncol=2)
pca <- prcomp(data, center=TRUE, scale=FALSE)
summary(pca)
```

## 2.1.5.7. 행렬의 거듭제곱 (고유값 이용)

```python
def matrix_power_eigen(A, n):
    """고유값 분해를 이용한 행렬 거듭제곱"""
    eigenvalues, eigenvectors = np.linalg.eig(A)
    
    # A^n = Q Λ^n Q^(-1)
    Lambda_n = np.diag(eigenvalues ** n)
    Q = eigenvectors
    Q_inv = np.linalg.inv(Q)
    
    return Q @ Lambda_n @ Q_inv

A = np.array([[2, 1], [1, 2]])
A_10 = matrix_power_eigen(A, 10)
```

## 2.1.5.8. 응용: 페이지랭크

```python
# 간단한 웹 그래프
# 페이지 A -> B, B -> C, C -> A
P = np.array([[0,   1,   0  ],
              [0,   0,   1  ],
              [1,   0,   0  ]])

# 전이 행렬 정규화
P = P / P.sum(axis=0)

# 가장 큰 고유값의 고유벡터 = 페이지랭크
eigenvalues, eigenvectors = np.linalg.eig(P.T)
idx = eigenvalues.argsort()[::-1][0]
pagerank = np.abs(eigenvectors[:, idx])
pagerank = pagerank / pagerank.sum()

print("PageRank:", pagerank)
```
