# 이중지수 분포

이중지수(double exponential) 분포는 라플라스(Laplace) 분포라고도 부른다. 정규분포보다 꼬리 확률이 더 높은 분포로, 꼬리 확률이 큰 확률변수를 모델링할 때에 사용한다.

```{admonition} 개관
:class: tip

| 항목 | 내용 |
|------|------|
| 기호 | $X \sim DE(\alpha, \beta)$ |
| 지지 집합 | $\mathbb{R}$ |
| 위치 모수 | $-\infty < \alpha < \infty$ |
| 크기 모수 | $\beta > 0$ |
| 활용 | 이상치가 많은 데이터, 신호처리의 잡음 모델과 같이 꼬리 확률이 큰 경우 |
```

---

## 확률밀도함수 유도

이중지수 분포의 확률밀도함수는 다음과 같다.

```math
f(x) = \frac 1 {2\beta} \exp(- \frac {|x - \alpha|}{\beta})
```


---

## 성질

### 기댓값과 분산

```math
\begin{gathered}
\mathbb E(X) = \alpha \\
Var(X) = 2\beta^2
\end{gathered}
```

---

### 적률생성함수

---

### 지수 분포와의 관계

두 확률변수 $X_1, X_2 \overset{iid}{\sim} \varepsilon(\lambda)$의 차이로 정의하는 확률변수 $Y = X_1 - X_2$는 $DE(0, \lambda)$를 따른다.

확률변수 $X \sim DE(\alpha, \beta)$에서 상수 $\alpha$를 뺀 절대값으로 정의하는 확률변수 $Y = |X-\alpha|$는 $\varepsilon(\beta)$를 따른다.

---

### 모수 추정

최대가능도법을 이용하면 위치 모수 $\alpha$의 추정량은 중간값이고, 크기 모수 $\beta$의 추정량은 $\frac 1 n \sum |x_i - \alpha|$이다.

---

### 난수 생성

연속형 균등 분포를 따르는 두 확률변수 $U, V \overset{iid}{\sim} U(0,1)$의 비율의 로그값으로 정의하는 확률변수 $X = \ln U V$는 $DE(0, 1)$를 따른다.

이때, $U, V$의 비율 크기를 조절하면 크기 모수를 바꿀 수 있다.