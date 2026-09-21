# 적률생성함수

(mgf-def)=
## 정의

적률생성함수(moment generating function, mgf)는 **적률**(moment)을 만들어주는 생성함수이다. 

[적률생성함수는 $u(X) = e^{tx}$의 기댓값](mgf-exp)으로 정의할 수 있다. 따라서, 분포의 수학적인 특성상 적률생성함수가 정의되지 않는 분포도 존재한다.

```math
M_X(t) = \mathbb E [ e^{tX} ] = \int \exp(tx) f(x) dx
```
---

(mgf-moment)=
## 적률

$m \in \mathbb Z$에 대해 $\mathbb E(X^m)$을 확률변수 $X$의 $m$차 적률이라고 정의한다. 

적률은 물리학의 **모먼트(moment)** 개념을 통계학에 그대로 가져온 개념으로, 확률변수의 분포를 확률변수를 밑으로 하는 지수값 기저에 투영시켰을 때에 각 기저의 **중심**을 보여준다. 어떤 물체의 질량이 하나의 축 위에 퍼져있을 때 무게중심, 관성 모먼트 등으로 요약하는 것처럼 분포의 중심을 다양한 기저를 바탕으로 평가해서 보여주는 것이 통계학에서 말하는 적률이라고 이해할 수 있다.

적률은 차수에 따라 적절한 조작을 거쳐 의미있는 통계량이 된다.

1차 적률은 평균이다. 다른 수리적 가공이 없는 분포함수에서 각 값이 가지는 확률값을 가중했을 때의 중심값이라고 이해할 수 있다. 

2차 중심적률은 분산이다. 각각의 분포값이 중심에서 떨어져있는 거리를 거듭제곱함으로써 부호를 없애고 순수하게 중심(평균)에서 멀리 퍼져있는 정도를 보여준다.

3차 표준중심적률은 왜도이다. 1차 적률과 마찬가지로 평균을 중심으로 좌, 우 부호는 보존되지만 1차 적률보다 평균에서 떨어져있는 정도를 더 가중해서 보여주기 때문에 중심에서 좌/우 방향으로 치우친 정도를 좀 더 강조해서 보여줄 수 있다.

4차 표준중심적률은 첨도이다. 2차 중심적률과 마찬가지로 부호는 사라지지만 극단값으로 퍼져있을 때의 가중치가 더 커져 극단값으로 퍼져있는 정도를 더 강조해서 보여줄 수 있다.

---

## 성질

(mgf-uniqueness)=
### 유일성

```{prf:definition} 적률생성함수의 유일성 정리

두 확률변수 $X$, $Y$의 mgf가 $t=0$ 근처의 열린 구간에서 존재하고 서로 같다면, $X$, $Y$는 동일한 분포를 가진다.

$$ M_X(t) = M_Y(t), \forall t \in (-\epsilon, \epsilon) \ \Rightarrow \ F_X(x) = F_Y(x), \ \forall x $$

```

적률생성함수의 유일성(uniqueness)은 분포함수와 적률생성함수가 [**라플라스 변환**(Laplace transformation)](laplace-mgf)의 관계를 가지기 때문에 생기는 속성이다.

### 적률의 차수

mgf를 $t=0$에서 테일러 전개하면 다음과 같다.

```{math}
\begin{aligned}
M(t) &= M(0) + \frac {M'(0)}{1!}t + \frac {M''(0)}{2!}t^2 + \cdots + \frac {M^{(m)}(0)}{m!}t^m + \cdots \\

&= 1 + \frac {\mathbb E(X)}{1!}t + \frac {\mathbb E(X^2)}{2!}t^2 + \cdots + \frac {\mathbb E(X^m)}{m!}t^m + \cdots 

\end{aligned}
```

따라서, $\frac{t^m}{m!}$의 계수가 $\mathbb E(X^m)$이 되고, 역으로 모든 차수의 적률을 알고 있다면 mgf를 구할 수 있다.

### 주요 차수별 적률

#### 1차 적률 : 평균


#### 2차 중심적률 : 분산

#### 3차 표준중심적률 : 왜도

#### 4차 표준중심적률 : 첨도

---

## 누율생성함수

적률생성함수에 자연로그를 취한 함수를 **누율생성함수**(cumulant generating function, cgf)라고 한다.

**r차 누율**(cumulant)은 누율생성함수의 테일러 전개식에서 $\frac {t^r}{r!}$의 계수로 정의한다.

```math
\kappa_r = \frac {d^r}{d t^r} \ln \mathbb E(e^{tX})|_{t=0}
```

### 누율과 중심적률


적률생성함수를 테일러전개하면 다음과 같다.

```math
M_X(t) = 1 + \mathbb E(X)t + \mathbb E(X^2) \frac{t^2}{2!} + \cdots
```

이때, 확률변수 $X$의 $r$차 원점적률을 $\mu_r' = \mathbb E(X^r)$라고 표기하면,

```math
M_X(t) = 1 + \sum_r \mu_r' \frac {t^r}{r!}
```
와 같다. 누율생성함수는 적률생성함수를 자연로그 변환한 함수이므로,

```math
K_X(t) = \ln M_X(t) = \ln \big( 1 + \sum_r \mu_r' \frac {t^r}{r!} \big)
```

확률변수 $X = \mu + (X - \mu)$로 표기하면,

```math
M_X(t) = \mathbb E(e^{tX}) = \mathbb E(e^{t(X-\mu}e^{t\mu}) = e^{t\mu} \mathbb E(e^{t(X-\mu}) = e^{t\mu} M_{X-\mu}(t)
```

이다. 양변에 자연로그를 취하면 누율생성함수와 중심적률생성함수의 관계는 다음과 같다.

```math
K_X(t) = \ln e^{t\mu} M_{X-\mu}(t) = t\mu + K_{X-\mu}(t)
```

한편, $r$차 중심적률을 $\mu_r = \mathbb E[(X-\mu)^r]$이라고 표기하면 중심적률생성함수의 테일러 전개를 다음과 같이 표기할 수 있다.

```math
\begin{aligned}

M_{X-\mu}(t) &= 1 + \mathbb E(X-\mu)t + \mathbb E[(X-\mu)^2] \frac {t^2}{2!} + \cdots \\

&= 1 + 0 + \mu_2 \frac{t^2}{2!} + \mu_3 \frac{t^3}{3!} + \cdots
\end{aligned}
```

위 식에 자연로그를 취한 $K_{X-\mu}(t)$를 식(9)에 대입하면,

```math
K_X(t) = t\mu + \ln[ 1 + \mu_2 \frac{t^2}{2!} + \mu_3 \frac{t^3}{3!} + \cdots]
```

자연로그 전개 $\ln (1 + x) = x + \frac {x^2}{2!} + \frac {x^3}{3!} + \cdots$를 이용하면 누율생성함수는 다음과 같이 정리할 수 있다.

```math
\begin{aligned}

K_X(t) &= \sum \kappa_r \frac{t^r}{r!} \\
\\
&= t\mu + \big( \sum \mu_r \frac{t^r}{r!} \big) + \big( \sum \mu_r \frac{t^r}{r!} \big)^2 \frac 1 2 + \cdots \\
\\
&= t\mu + \mu_2 \frac{t^2}{2!} + \mu_3 \frac{t^3}{3!} + (\mu_4 - 3\mu_2^2) \frac{t^4}{4!} + \cdots

\end{aligned}
```
이다. $\kappa_r$의 정의에 따라 각 항을 비교하면 다음과 같은 관계가 성립함을 확인할 수 있다.

```math
\kappa_1 = \mu \\
\\
\kappa_2 = \mu_2 \\
\\
\kappa_3 = \mu_3 \\ 
\\
\kappa_4 = \mu_4 - 3\mu_2^2
```

따라서, 1차 누율은 1차 적률(평균), 2차 누율은 2차 중심적률(분산), 3차 누율은 3차 중심적률(왜도의 비표준화값), 4차 누율은 초과첨도의 비표준화값이 된다.
