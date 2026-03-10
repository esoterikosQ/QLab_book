# 1.6.3. matplotlib (Python)

matplotlib은 Python의 기본 시각화 라이브러리로, 세밀한 커스터마이징이 가능합니다.

## 1.6.3.1. 기본 사용 (Python 3.13)

```python
import matplotlib.pyplot as plt
import numpy as np

# 선 그래프
x = np.linspace(0, 2*np.pi, 100)
y = np.sin(x)

plt.figure(figsize=(8, 6))
plt.plot(x, y, label='sin(x)')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Sine Wave')
plt.legend()
plt.grid(True, alpha=0.3)
plt.savefig('sine.png', dpi=150, bbox_inches='tight')
plt.show()
```

## 1.6.3.2. 산점도

```python
# 기본 산점도
x = np.random.randn(100)
y = 2*x + np.random.randn(100)*0.5

plt.scatter(x, y, alpha=0.6, c='steelblue')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Scatter Plot')
plt.show()

# 색상과 크기 매핑
sizes = np.abs(np.random.randn(100)) * 100
colors = np.random.rand(100)

plt.scatter(x, y, s=sizes, c=colors, alpha=0.6, cmap='viridis')
plt.colorbar(label='Color Value')
plt.show()
```

## 1.6.3.3. 막대 차트

```python
# 막대 차트
categories = ['A', 'B', 'C', 'D']
values = [23, 45, 56, 78]

plt.bar(categories, values, color='steelblue')
plt.xlabel('Category')
plt.ylabel('Value')
plt.title('Bar Chart')
plt.show()

# 수평 막대 차트
plt.barh(categories, values)
plt.show()

# 그룹별 막대 차트
x = np.arange(len(categories))
values1 = [23, 45, 56, 78]
values2 = [35, 42, 48, 65]
width = 0.35

plt.bar(x - width/2, values1, width, label='Group 1')
plt.bar(x + width/2, values2, width, label='Group 2')
plt.xticks(x, categories)
plt.legend()
plt.show()
```

## 1.6.3.4. 히스토그램

```python
data = np.random.randn(1000)

plt.hist(data, bins=30, color='steelblue', edgecolor='white', alpha=0.7)
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.title('Histogram')
plt.show()

# 여러 그룹 비교
data1 = np.random.randn(1000)
data2 = np.random.randn(1000) + 1

plt.hist(data1, bins=30, alpha=0.5, label='Group 1')
plt.hist(data2, bins=30, alpha=0.5, label='Group 2')
plt.legend()
plt.show()
```

## 1.6.3.5. 서브플롯

```python
fig, axes = plt.subplots(2, 2, figsize=(10, 8))

# 좌상: 선 그래프
axes[0, 0].plot(x, y)
axes[0, 0].set_title('Line Plot')

# 우상: 산점도
axes[0, 1].scatter(x, y)
axes[0, 1].set_title('Scatter Plot')

# 좌하: 막대 차트
axes[1, 0].bar(categories, values)
axes[1, 0].set_title('Bar Chart')

# 우하: 히스토그램
axes[1, 1].hist(data, bins=30)
axes[1, 1].set_title('Histogram')

plt.tight_layout()
plt.show()
```

## 1.6.3.6. 스타일

```python
# 사용 가능한 스타일
print(plt.style.available)

# 스타일 적용
plt.style.use('seaborn-v0_8-darkgrid')
plt.style.use('ggplot')
plt.style.use('bmh')

# 기본 스타일로 복원
plt.style.use('default')
```

## 1.6.3.7. 3D 플롯

```python
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

x = np.random.randn(100)
y = np.random.randn(100)
z = np.random.randn(100)

ax.scatter(x, y, z, c='steelblue', marker='o')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
plt.show()
```
