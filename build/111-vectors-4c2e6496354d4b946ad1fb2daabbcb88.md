# 2.1.2. 벡터

벡터는 크기와 방향을 가진 양으로, 데이터 포인트나 특징을 표현하는 데 사용됩니다.

## 2.1.2.1. 벡터 기본 (Python 3.13)

```python
import numpy as np

# 벡터 생성
v = np.array([1, 2, 3])
w = np.array([4, 5, 6])

# 벡터 덧셈/뺄셈
print(v + w)  # [5, 7, 9]
print(v - w)  # [-3, -3, -3]

# 스칼라 곱
print(2 * v)  # [2, 4, 6]

# 내적 (dot product)
dot = np.dot(v, w)  # 1*4 + 2*5 + 3*6 = 32
# 또는
dot = v @ w

# 노름 (길이)
norm = np.linalg.norm(v)  # sqrt(1^2 + 2^2 + 3^2) = 3.74

# 정규화 (단위 벡터)
v_normalized = v / np.linalg.norm(v)
```

## 2.1.2.2. 코사인 유사도

```python
def cosine_similarity(v, w):
    """두 벡터 간 코사인 유사도"""
    return np.dot(v, w) / (np.linalg.norm(v) * np.linalg.norm(w))

v = np.array([1, 2, 3])
w = np.array([4, 5, 6])
sim = cosine_similarity(v, w)
print(f"Cosine Similarity: {sim:.4f}")
```

## 2.1.2.3. 외적 (3D 벡터)

```python
# 외적 (cross product)
v = np.array([1, 0, 0])
w = np.array([0, 1, 0])
cross = np.cross(v, w)  # [0, 0, 1]
```

## 2.1.2.4. R에서의 벡터

```r
# 벡터 생성
v <- c(1, 2, 3)
w <- c(4, 5, 6)

# 연산
v + w
v - w
2 * v

# 내적
sum(v * w)  # 32

# 노름
sqrt(sum(v^2))

# 정규화
v / sqrt(sum(v^2))
```

## 2.1.2.5. 벡터 투영

```python
def vector_projection(v, w):
    """v를 w에 투영"""
    return (np.dot(v, w) / np.dot(w, w)) * w

v = np.array([3, 4])
w = np.array([1, 0])
proj = vector_projection(v, w)
print(proj)  # [3, 0]
```
