# 1.6.4. seaborn (Python)

seaborn은 matplotlib 기반의 고급 통계 시각화 라이브러리입니다.

## 1.6.4.1. 기본 사용 (Python 3.13)

```python
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# 테마 설정
sns.set_theme(style="darkgrid")
sns.set_palette("husl")

# 샘플 데이터
df = sns.load_dataset('tips')
```

## 1.6.4.2. 분포 시각화

```python
# 히스토그램 + KDE
sns.histplot(df['total_bill'], kde=True)
plt.show()

# KDE 플롯
sns.kdeplot(data=df, x='total_bill', hue='time', fill=True)
plt.show()

# 박스플롯
sns.boxplot(data=df, x='day', y='total_bill', hue='time')
plt.show()

# 바이올린 플롯
sns.violinplot(data=df, x='day', y='total_bill', hue='sex', split=True)
plt.show()

# 스웜 플롯
sns.swarmplot(data=df, x='day', y='total_bill', hue='sex')
plt.show()
```

## 1.6.4.3. 관계 시각화

```python
# 산점도
sns.scatterplot(data=df, x='total_bill', y='tip', hue='time', size='size')
plt.show()

# 회귀선이 있는 산점도
sns.regplot(data=df, x='total_bill', y='tip')
plt.show()

# lmplot (facet 지원)
sns.lmplot(data=df, x='total_bill', y='tip', hue='time', col='day')
plt.show()

# 페어 플롯 (산점도 행렬)
sns.pairplot(df, hue='time', corner=True)
plt.show()
```

## 1.6.4.4. 범주형 데이터

```python
# 막대 차트
sns.barplot(data=df, x='day', y='total_bill', hue='sex', errorbar='sd')
plt.show()

# 카운트 플롯
sns.countplot(data=df, x='day', hue='sex')
plt.show()

# 포인트 플롯
sns.pointplot(data=df, x='day', y='total_bill', hue='time')
plt.show()
```

## 1.6.4.5. 히트맵

```python
# 상관관계 히트맵
numeric_cols = df.select_dtypes(include=[np.number])
corr = numeric_cols.corr()

sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm', center=0,
            square=True, linewidths=1)
plt.title('Correlation Heatmap')
plt.show()

# 피벗 테이블 히트맵
pivot = df.pivot_table(values='tip', index='day', columns='time', aggfunc='mean')
sns.heatmap(pivot, annot=True, fmt='.1f', cmap='YlGnBu')
plt.show()
```

## 1.6.4.6. FacetGrid

```python
# 조건부 서브플롯
g = sns.FacetGrid(df, col='time', row='sex', hue='smoker')
g.map(sns.scatterplot, 'total_bill', 'tip')
g.add_legend()
plt.show()

# catplot
sns.catplot(data=df, x='day', y='total_bill', hue='sex', col='time', kind='box')
plt.show()
```

## 1.6.4.7. 조인트 플롯

```python
# 산점도 + 분포
sns.jointplot(data=df, x='total_bill', y='tip', kind='scatter', hue='time')
plt.show()

# 육각형 빈
sns.jointplot(data=df, x='total_bill', y='tip', kind='hex')
plt.show()

# KDE
sns.jointplot(data=df, x='total_bill', y='tip', kind='kde')
plt.show()

# 회귀
sns.jointplot(data=df, x='total_bill', y='tip', kind='reg')
plt.show()
```

## 1.6.4.8. 스타일과 색상

```python
# 스타일
sns.set_style("whitegrid")  # whitegrid, darkgrid, white, dark, ticks

# 컨텍스트 (크기 조정)
sns.set_context("paper")  # paper, notebook, talk, poster

# 색상 팔레트
sns.set_palette("husl")
sns.set_palette("Set2")
sns.color_palette("viridis", as_cmap=True)

# 커스텀 팔레트
custom_palette = ["#FF6B6B", "#4ECDC4", "#45B7D1"]
sns.set_palette(custom_palette)
```

## 1.6.4.9. 저장

```python
# 현재 figure 저장
plt.savefig('plot.png', dpi=300, bbox_inches='tight')

# 고해상도 PDF
plt.savefig('plot.pdf', format='pdf', bbox_inches='tight')
```
