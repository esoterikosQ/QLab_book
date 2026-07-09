# 기댓값

## 정의

```{prf:definition} 기댓값 expectation

확률변수 $X$가 확률밀도함수 $f(x)$를 가질 때, $X$의 함수인 $u(X)$의 기댓값은 $\mathbb E [ u(X)]$로 표기하고 다음과 같이 정의한다.

$$ \mathbb E[u(X)] = \begin{cases} \sum_x u(x)f(x), \ \text{이산형} \\ \int_{-\infty}^{\infty} u(x)f(x) dx, \ \text{연속형} \end{cases} $$

```
---

## 기댓값의 종류

### 평균

$u(X) = X$일 때의 기댓값을 **기댓값** 또는 **평균**(mean)이라고 한다. 분포함수의 무게 중심을 나타낸다.

### 분산

$u(X) = (X - \mu)^2$일 때의 기댓값을 **분산**(variance)이라고 한다. 분산의 제곱근을 **표준편차**(standard deviation, s.d.)라고 한다. 표준편차는 원데이터와 단위를 맞추기 위해 사용한다. 

(mgf-exp)=
### 적률생성함수

$u(X) = e^{tX}$일 때의 기댓값을 **[적률생성함수](mgf-def)**(moment generating function, m.g.f.)라고 한다. 적률생성함수는 cdf와 마찬가지로 분포의 고유한 속성과 연결되기 때문에 적률생성함수가 같은 두 확률변수는 동일한 분포를 따른다.

---

## CDF와 기댓값

CDF를 이용하여 기댓값과 분산을 다음과 같이 구할 수 있다.


```{prf:definition} 기댓값과 분산

확률변수 $X$에 대해 다음이 성립한다.

$$ \mathbb E[X] = \int_0^{\infty} [1 - F(x)] dx - \int_{-\infty}^0 F(x) dx $$

$$ Var(X) = \int_0^{\infty} 2x [1 - F(x)] + F(-x) ] dx - \mathbb E (X)^2 $$

```

### 증명1 : 기댓값

기댓값은 [확률변수의 지시함수 적분 표현](idx-rv)을 이용하여 지시함수의 적분 형태로 표현할 수 있다. (지시함수를 쌓아 올려 원래 값을 복원한다는 의미에서 layer cake representation이라고도 부른다.)

0보다 큰 값을 가지는 확률변수 $ X > 0 $에 대해,

```math
X = \int_0^{\infty} \boldsymbol 1_{(X>t)} dt
```
이므로, 

```math
\begin{aligned}

\mathbb E[X] &= \mathbb E[ \int_0^{\infty} \boldsymbol 1_{(X>t)} dt ] \\

&= \overset{\text{Fubini-Tonelli theorem}}{\boxed{ \int_0^{\infty} \mathbb E[ \boldsymbol 1_{(X>t)} ] dt}} \\

&= \int_0^{\infty} \overset{\text{지시함수의 기댓값은 확률이므로}}{\boxed{P( X > t )}} dt \\

&= \int_0^{\infty} [1 - F(t)] dt

\end{aligned}
```
으로 정리할 수 있다.

이를 $X \in \mathbb R$인 확률변수로 확장하면,

```math
X = \int_0^{\infty} \boldsymbol 1_{(X>t)} dt - \int_{-\infty}^0 \boldsymbol 1_{(X \leq t)} dt
```
이므로, 

```math
\begin{aligned}

\mathbb E [ X ] &= \mathbb E [ \int_0^{\infty} \boldsymbol 1_{(X>t)} dt ] - \mathbb E [ \int_{-\infty}^0 \boldsymbol 1_{(X \leq t)} dt ] \\

&= \int_0^{\infty} \mathbb E [ \boldsymbol 1_{(X>t)}] dt -  \int_{-\infty}^0 \mathbb E [ \boldsymbol 1_{(X \leq t)} ] dt \\

&= \int_0^{\infty} P(X > t) dt -  \int_{-\infty}^0 P(X \leq t) dt \\

&= \int_0^{\infty} [1 - F(t)] dt -  \int_{-\infty}^0 F(t) dt \\
\end{aligned}
```

$\blacksquare$

기하학적으로는 기댓값이 $X > 0$에서는 $(F(x), 1)$ 구간, $X < 0$에서는 $(0, F(x))$ 구간을 적분한 값과 동일하다는 의미로 해석할 수 있다.

---

### 증명2 : 분산

분산은 $\mathbb E(X^2)$을 구하여 $Var(X) = E(X^2) - E(X)^2$에 따라 계산할 수 있다.

```math
X^2 = \int_0^{\infty} 2t \{ \boldsymbol 1_{(X > t)} + \boldsymbol 1{(X \leq -t)} dt
```
이므로, 

```math
\begin{aligned}
\mathbb E [X^2] &= \mathbb E [ \int_0^{\infty} 2t \{ \boldsymbol 1_{(X > t)} + \boldsymbol 1{(X \leq -t)} \} dt ] \\

&= \int_0^{\infty} 2t \{ \mathbb E [ \boldsymbol 1_{(X > t)} ] + \mathbb E [ \boldsymbol 1{(X \leq -t)}] \} dt \\

&= \int_0^{\infty} 2t \{ P(X > t) + P(X \leq -t)\} dt \\

&= \int_0^{\infty} 2t \{ 1 - F(t) + F(-t) \} dt \\

\end{aligned}
```

따라서,

```math
Var(X) = \int_0^{\infty} 2t \{ 1 - F(t) + F(-t) \} dt - E(X)^2 \\

```

$\blacksquare$
