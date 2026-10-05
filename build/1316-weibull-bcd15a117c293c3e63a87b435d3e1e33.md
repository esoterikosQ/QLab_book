# 와이블 분포

와이블(Weibull) 분포는 신뢰성 공학 부문에서 수명의 분포를 보여주는 분포로 활용된다. 형상 모수 $\alpha$의 크기에 따라 제품 수명에 따른 욕조 곡선(bathtub curve)의 구간을 표현할 수 있다.

```{admonition} 개관
:class: tip

| 항목 | 내용 |
|------|------|
| 기호 | $X \sim Weibull(\lambda, \alpha)$ |
| 척도 모수 | $\lambda > 0$ |
| 형상 모수 | $\alpha > 0$ |
| 지지집합 | $[0, \infty)$ |
| 평균 | ${\dfrac 1 \lambda}^{\frac 1 \alpha} \Gamma\left(1+\dfrac{1}{\alpha}\right)$ |
| 분산 | ${\dfrac 1 \lambda}^{\frac 2 \alpha} \left[\Gamma \left( 1 + \dfrac{2}{\alpha} \right) - \Gamma \left( 1 + \dfrac{1}{\alpha} \right)^2 \right]$ |
| 활용 | 신뢰성 공학의 수명분석, 고장률이 시간에 따라 변하는 부품의 고장시간 모델링 |
```

---

## 확률밀도함수

```math
\lambda \alpha x^{\alpha -1} \exp(-\lambda x^\alpha)
```

---

## 성질

### 평균과 분산

---

### 욕조 곡선 구간과 형상 모수의 구간

```{figure} assets/1316-1.png
:name: bathtub-curve
:width: 500px
:align: center

이미지 생성 : GPT5.6Sol
```

- $\alpha < 1$ 구간에서는 시간($X$)이 지날수록 확률값이 줄어든다. 즉, 불량제품이 초기에 식별된 후 안정화되는 과정을 보여주는 데에 적합하다.

- $\alpha = 1$ 구간에서는 지수분포와 동일해지고, 시간의 흐름과 무관하게 확률값이 생성된다.(무기억성) 즉, 안정화 이후 제품의 특성이 아니라 외생적 사건 때문에 불량이 발생하는 현상을 보여주는 데에 적합하다.

- $\alpha > 1$ 구간에서는 시간이 지날수록 확률값이 올라간다. 노화나 피로 누적으로 인해 제품의 고장 확률이 올라가는 단계이다. $\alpha = 2$이면 레일리 분포와 같아져 선형으로 확률이 증가하고, $ \alpha \gg 1$이면 정규분포와 비슷해져 특정 평균(확률적으로 집중되는 제품 수명 완료 구간)에 집중된다.

---

### 척도 모수 정의 방법과 확률밀도함수

척도 모수를 역수($\frac 1 \lambda$)로 정의하는 경우, 확률밀도함수는 다음과 같이 바뀐다. 

```math
\dfrac {\alpha x^{\alpha -1}} {\lambda^\alpha} \exp \left( - \left( \dfrac x \lambda \right)^\alpha \right)
```

이 경우 평균과 분산은 다음과 같이 정의된다. 

```math
\mathbb E(X) = \lambda \Gamma\left(1+\dfrac{1}{\alpha}\right) \\

Var(X) = \lambda^2 \left[\Gamma \left( 1 + \dfrac{2}{\alpha} \right) - \Gamma \left( 1 + \dfrac{1}{\alpha} \right)^2 \right]

```

확률밀도함수의 정의와 계산은 복잡해지지만 척도 모수의 해석이 직관과 부합해진다. 즉, 척도 모수가 커지면 제품의 수명이 늘어난다. 이 때문에 $\lambda$로 정의하는 경우 역척도 모수라고 부르기도 한다.

---

### 삼모수 와이블 분포

와이블 분포는 통상 이모수 형태로 활용하는데, 위치 모수 $\gamma$를 추가하여 삼모수 와이블 분포를 활용하기도 한다. 지지 집합은 $x \geq \gamma$로, 수명 분석에서는 $\gamma$를 최소 보장 수명으로 해석한다.

---

### 다른 분포와의 관계

- $X \sim \varepsilon(\lambda)$일 때, $Y = X^{\frac 1 \alpha}$로 정의하는 확률변수는 $Y \sim Weibull (\lambda, \alpha)$ 분포를 따른다.