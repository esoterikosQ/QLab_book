# 누적분포함수

## 정의

```{prf:definition} 누적분포함수 cumulative density function / cdf

확률변수 $X$의 누적분포함수는 다음과 같이 정의한다. 누적분포함수는 분포함수라고도 한다.

$$ F(x) = P(X \leq x) $$

```

누적분포함수는 다음과 같은 성질을 개념 요소로 가진다. 즉, 아래의 세 가지 요건을 만족하는 함수는 누적분포함수로 간주할 수 있다.

```{prf:definition} 누적분포함수의 개념적 성질

1. $x_1 \leq x_2$이면 $F(x_1) \leq F(x_2)$이다. 즉, 누적분포함수는 비감소함수이다.

2. $F(\infty) = lim_{x \to \infty} F(x) = 1$이고, $F(-\infty) = \lim_{x \to - \infty} F(x) = 0$이다.

3. $\lim_{h \to 0^+} F(x + h) = F(x)$이다. 즉, 누적분포함수는 우연속함수이다.

```

## 성질

```{prf:property} 누적분포함수의 성질

4. $0 \leq F(x) \leq 1$이다. 이는 1, 2로부터 자명하다.

5. $\lim_{h \to 0^-} F(x + h) = P( X < x )$이다. 즉, 누적분포함수는 좌연속함수가 아닐 수 있다.

6. $P(X = a) = F(a) - F(a^-)$이다.

7. $P(a < X \leq b) = F(b) - F(a)$이다. 

```

## 누적분포함수와 확률밀도함수의 관계

확률변수 $X$의 확률밀도함수가 존재할 때, 확률밀도함수와 누적분포함수는 다음과 같은 관계를 가진다.

```{math}
F(x) = \begin{cases} \sum_{t \leq x} f(t), \ \text{이산형} \\ 
\int_{-\infty}^x f(t) dt, \ \text{연속형} \end{cases}
```

위 관계로부터 확률밀도함수를 다음과 같이 구할 수 있다.

```{math}
f(x) = \begin{cases} F(x) - F(x^-), \text{이산형} \\

\frac d {dx} F(x), \text{연속형} \end{cases}

```

## 파생개념

### 백분위수

```{prf:definition} 백분위수 100p-th percentile

확률변수 $X$의 제100p 백분위수 또는 차수 p의 분위수 $\xi_p$는 다음을 만족하는 $x$이다. 

$$ P(X \leq x) \geq p \ \ \& \ \ P(X \geq x) \geq 1-p $$

```

백분위수에 대한 개념은 표준화되지 않았다. $P(X \leq x) \geq p$를 만족하는 최솟값을 분위수로 정의하기도 하고, 중앙값의 경우에는 두 조건을 만족하는 값의 중간값으로 정의하기도 한다.

### 중앙값

```{prf:definition} 중앙값 median

확률변수 $X$의 중앙값은 다음을 만족하는 $x$이다. 

$$ P(X \leq x) \geq \frac 1 2 \ \ \& \ \ P(X \geq x) \geq \frac 1 2 $$

```

중앙값은 백분위수의 특수 사례이다.