# 2.2. 수리통계 소개

수리통계학은 확률 이론을 기반으로 데이터를 수집, 분석, 해석하는 수학 분야입니다.

## 2.2.1. 기술 통계

데이터의 특성을 요약하는 통계량입니다.

### Python 3.13

```python
import numpy as np
import scipy.stats as stats

data = np.array([2, 4, 4, 4, 5, 5, 7, 9])

# 중심 경향
print(f"평균: {np.mean(data):.2f}")       # 5.00
print(f"중앙값: {np.median(data):.2f}")   # 4.50
mode_result = stats.mode(data, keepdims=True)
print(f"최빈값: {mode_result.mode[0]}")   # 4

# 산포도
print(f"분산: {np.var(data, ddof=1):.2f}")  # 4.00
print(f"표준편차: {np.std(data, ddof=1):.2f}")  # 2.00
print(f"범위: {np.ptp(data)}")             # 7

# 분위수
print(f"25%: {np.percentile(data, 25)}")
print(f"75%: {np.percentile(data, 75)}")
```

### R 4.25.4

```r
data <- c(2, 4, 4, 4, 5, 5, 7, 9)

# 중심 경향
mean(data)
median(data)
table(data)  # 빈도

# 산포도
var(data)
sd(data)
range(data)

# 사분위수
quantile(data, c(0.25, 0.75))

# 요약
summary(data)
```

## 2.2.2. 확률 분포

### 정규분포

```python
# Python
from scipy.stats import norm

# PDF (확률밀도함수)
x = np.linspace(-3, 3, 100)
pdf = norm.pdf(x, loc=0, scale=1)

# CDF (누적분포함수)
cdf = norm.cdf(x, loc=0, scale=1)

# 역함수
quantile = norm.ppf(0.975, loc=0, scale=1)  # 1.96

# 랜덤 샘플
samples = norm.rvs(loc=0, scale=1, size=1000)
```

```r
# R
# PDF
x <- seq(-3, 3, length=100)
pdf <- dnorm(x, mean=0, sd=1)

# CDF
cdf <- pnorm(x, mean=0, sd=1)

# 역함수
qnorm(0.975, mean=0, sd=1)  # 1.96

# 랜덤 샘플
samples <- rnorm(1000, mean=0, sd=1)
```

## 2.2.3. 가설 검정

### t-test

```python
# Python
from scipy.stats import ttest_ind

group1 = [72, 81, 68, 75, 79]
group2 = [65, 70, 63, 68, 72]

t_stat, p_value = ttest_ind(group1, group2)
print(f"t-statistic: {t_stat:.4f}")
print(f"p-value: {p_value:.4f}")

if p_value < 0.05:
    print("통계적으로 유의한 차이 존재")
```

```r
# R
group1 <- c(72, 81, 68, 75, 79)
group2 <- c(65, 70, 63, 68, 72)

result <- t.test(group1, group2)
print(result)
```

## 2.2.4. 상관관계

- 피어슨 상관계수: 선형 관계
- 스피어만 상관계수: 순위 기반
- 켄달 상관계수: 순서쌍 일치도

```python
# Python
x = [1, 2, 3, 4, 5]
y = [2, 4, 5, 4, 5]

# 피어슨
pearson_r, p_value = stats.pearsonr(x, y)
print(f"Pearson r: {pearson_r:.4f}")

# 스피어만
spearman_r, p_value = stats.spearmanr(x, y)
print(f"Spearman r: {spearman_r:.4f}")
```

```r
# R
x <- c(1, 2, 3, 4, 5)
y <- c(2, 4, 5, 4, 5)

# 피어슨
cor(x, y, method="pearson")

# 스피어만
cor(x, y, method="spearman")
```
