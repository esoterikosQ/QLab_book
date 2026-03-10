---
title: "Knot Selection for Regression Splines via the LASSO"
authors: 
  - name: "M. R. Osborne, et. al."
exports:
  - format: pdf
    template: lapreprint-typst
    output: exports/osborne.pdf
---

# 1. 목적

논문에서 제시하는 알고리즘은 LASSO 회귀를 이용하여 회귀 스플라인의 매듭점(knot)을 자동으로 선택할 수 있는 방법입니다. 전체 데이터셋에 (n-1)개의 매듭점 후보변수를 추가한 후, LASSO 회귀의 방법을 변형하여 최적의 매듭점 집합을 선택하는 방법입니다.

# 2. 알고리즘의 기반이 되는 LASSO 회귀모형 분석

LASSO 회귀의 최적화 문제는 다음과 같습니다.

```{math}
\begin{aligned}
\text{argmin}_{\beta \in \mathbb{R}^m}  f(\boldsymbol \beta) &= \frac{1}{2} (\boldsymbol y - \boldsymbol {X\beta})^T (\boldsymbol y - \boldsymbol {X\beta}) \\
\text{s. t. } g(\boldsymbol \beta) &= t - \| \boldsymbol \beta \|_1 \geq 0
\end{aligned}
```

m은 변수의 수를 의미합니다. 위 식(1)의 해를 구하기 위해 라그랑주 승수법을 이용하는데, 해당 식의 해에서는 다음과 같은 조건이 성립합니다.

```{math}
\nabla f(\boldsymbol \beta) + \lambda \nabla \| \boldsymbol \beta \|_1 = 0
```

식(2)의 초항은 다음과 같이 나타낼 수 있습니다.

```{math}
\nabla f(\boldsymbol \beta) = - \boldsymbol {X}^T (\boldsymbol y - \boldsymbol {X\beta}) = - \boldsymbol {X}^T \boldsymbol r
```
식(3)에서 $\boldsymbol r = \boldsymbol y - \boldsymbol {X\beta}$는 잔차 벡터(residual vector)를 의미합니다.

식(2)의 후항에서는 미분이 불가능한 $\| \boldsymbol \beta \|_1$를 대신하여, $\beta_i$의 부호에 따라 다음과 같은 값을 가지는 $v_i$를 원소로 가지는 하위구배벡터(subgradient vector) $\boldsymbol v \in \mathbb R^m$으로 나타낼 수 있습니다.

```{math}
:enumerated: false
\begin{aligned}
v_i = \begin{cases}

\text{sign}(\beta_i), & \beta_i \neq 0 \\
[-1, 1], & \beta_i = 0

\end{cases}
\end{aligned}
```

따라서, 식(2)는 다음과 같이 다시 쓸 수 있습니다.

```{math}
\boldsymbol {X}^T \boldsymbol r = \lambda \boldsymbol v
```

식(5)는 LASSO 회귀모형의 핵심을 이루는 지표로, 논문에서 제시하는 알고리즘을 통해 선택한 매듭점 후보 변수의 집합이 적절한 집합인지를 판단하는 기준으로 사용합니다. 위 식(4)의 좌변은 각 변수 벡터와 잔차 벡터의 내적을 원소로 가지는 벡터이고, 우변은 라그랑주 승수를 기준으로 설정한 변수-잔차 상관관계의 임계값을 의미합니다. LASSO 모형을 통해 선택한 변수 $\beta_i$는 $v_i$가 $\pm 1$을 가지기 때문에 $\pm \lambda$의 내적값을 가지고, 선택하지 않은 변수는 $[-\lambda, \lambda]$의 내적값을 가집니다. 즉, LASSO 모형은 잔차와 벡터의 상관관계가 절댓값 기준으로 $\lambda$ 이상인 변수를 선택하는 모형으로 이해할 수 있습니다.

한편, 식(1)의 모형에서 디자인 매트릭스 $\boldsymbol{X}$를 원래 데이터에 p차 스플라인의 매듭점 후보에 해당하는 데이터를 추가하여 다음과 같이 구성합니다. 이 디자인 매트릭스는 ($n \times (n + p - 1)$) 차원입니다. (p는 스플라인의 차수, n은 관측치의 수)

```{math}
:enumerated: false
\boldsymbol{X} = \begin{bmatrix}\boldsymbol{1}, \boldsymbol{x}, \ | \ (\boldsymbol{x} - \boldsymbol{x_2})^p_+ , (\boldsymbol{x} - \kappa_2)^p_+ , \ldots , (\boldsymbol{x} - \kappa_{n-1})^p_+ \end{bmatrix}
```

# 3. 논문이 제안하는 알고리즘

논문에서는 (1) LASSO 모형을 이용한 변수 및 매듭점 선택, (2) 최적의 LASSO 파라미터 t 선택을 구분하여 제시합니다.

## 3.1. LASSO 모형을 이용한 변수 및 매듭점 선택

```{raw} typst
#block(
  fill: luma(240),
  stroke: 1pt + luma(180),
  radius: 4pt,
  inset: 12pt,
  width: 100%,
)[
  #text(weight: "bold", size: 11pt)[Algorithm]
  #v(8pt)
```

(1) 선택한 변수의 벡터 집합을 초기화. 초기집합은 $\boldsymbol \beta = \boldsymbol 0$, 선택한 변수의 인덱스는 $\sigma = \emptyset$

(2) 아래의 식을 만족하는 $\boldsymbol h$를 구함.

```{math}
\begin{aligned}
\text{argmin}_{\boldsymbol h \in \mathbb{R}^{(n + p - 1)}} f(\boldsymbol {\beta + h}) \\

s. t. \theta^T_{\sigma} (\boldsymbol {\beta_{\sigma} + h_{\sigma}}) \leq t
\end{aligned}
```
여기서, $\theta_{\sigma}$는 $\sigma$에 포함된 변수의 부호 벡터입니다. 식(5)의 조건을 만족하는 $\boldsymbol {\tilde \beta} = \boldsymbol {\beta + h}$가 새로운 해가 됩니다.

(3) 새롭게 갱신한 $\boldsymbol {\tilde \beta}$의 부호벡터가 $\theta_{\sigma}$와 다르면(sign feasibility), 다음의 과정을 거쳐 $\sigma$를 갱신

(3.1) $\gamma = \{ \min \gamma_k : \beta_k + \gamma_k h_k = 0, \forall k \in \sigma, \ 0 < \gamma_k < 1 \}$를 계산

(3.2) $\theta$의 부호를 반전시키고, $\beta = \beta + \gamma h$로 갱신하여 2의 조건을 만족하면 4로 이동

(3.3) k를 $\sigma$에서 제거하고, $\beta = \beta + \gamma h$로 갱신하여 2로 이동

(4) LASSO 조건을 만족하는지 확인. 이는 $\boldsymbol {\tilde \beta}$를 기준으로 계산한 변수-잔차 에 대해 다음의 과정을 통해 확인

```{math}
\boldsymbol {\tilde v} = \frac {\boldsymbol {X^T \tilde r}} {\| \boldsymbol {X^T \tilde r} \|_{\infty}} = \boldsymbol P^T \begin{pmatrix} \boldsymbol {\tilde v_1} \\ \boldsymbol {\tilde v_2} \end{pmatrix}
```


(5) ${{\tilde v}_2}^i$가 최대값인 i를 찾아서 해당 변수를 $\sigma$에 추가하고 2로 이동.

```{raw} typst
]
``` 

식(8)에서 $\boldsymbol P$는 변수 벡터를 선택한 변수를 앞으로 두고, 선택하지 않은 변수를 뒤로 옮기는 방식으로 재배열하는 행렬입니다. $\boldsymbol {\tilde v_1}$은 선택한 변수에 대한 내적값, $\boldsymbol {\tilde v_2}$는 선택하지 않은 변수에 대한 내적값을 의미합니다. 식(6)의 분자는 변수값과 잔차 벡터의 내적값이고, 분모는 이 값들의 절댓값 중 최댓값입니다. 즉, $\boldsymbol {\tilde v}$는 변수-잔차의 내적값을 최댓값을 기준으로 정규화한 벡터입니다. 이 벡터 중 $|\boldsymbol {\tilde v_1}| = |\theta_{\sigma}|$이고, $\boldsymbol {|\tilde v_2|} \leq 1$이면 $\sigma$는 LASSO 조건을 만족하는 집합입니다. 만일 이를 만족하지 않으면 5로 넘어갑니다.

식(8)의 분자는 변수값과 잔차 벡터의 내적값이고, 분모는 이 값들의 절댓값 중 최댓값입니다. 즉, $\boldsymbol {\tilde v}$는 변수-잔차의 내적값을 최댓값을 기준으로 정규화한 벡터입니다. 이 벡터 중 $|\boldsymbol {\tilde v_1}| = |\theta_{\sigma}|$이고, $\boldsymbol {|\tilde v_2|} \leq 1$이면 $\sigma$는 LASSO 조건을 만족하는 집합입니다. 만일 이를 만족하지 않으면 5로 넘어갑니다.

## 3.2. 최적의 LASSO 파라미터 t 선택

LASSO 파라미터인 t는 3.1.에서 선택한 매듭점의 집합만을 이용하여 LASSO 제약없이 회귀계수를 추정하고, 이 회귀계수를 이용하여 계산한 잔차제곱합에 AIC, BIC 등 방법으로 벌점화한 점수를 기준으로 최적의 t를 선택하는 방법으로 이루어집니다. 즉, 가장 처음에는 t=0으로 시작하여 점차 t를 늘려가며 (1)을 반복적으로 구행하고, 각 t에 대해 (2)의 방법으로 점수를 계산하여 최적의 t를 선택합니다.

이 과정은 LASSO 모형을 무한정의 범위에서 반복하기 때문에 연산량이 많을 수 있지만, QR 분해를 이용하여 구한 R 행렬을 $\sigma$가 바뀔 때마다 부분적으로 갱신하는 방법을 통해 연산량을 줄일 수 있습니다.

# 4. 수치적 실험 및 결론

논문에서는 Silverman(1985)의 mortocycle dataset, Donoho el. al.(1994, 1995)의 blocks function과 doppler function을 이용하여 제안한 알고리즘의 성능을 평가합니다. 제안한 알고리즘을 이용하여 회귀곡선을 추정하는 실험을 수행했으며, LASSO 방식으로 회귀계수를 축소하여 RSS를 구했을 때의 회귀곡선, 축소하지 않고 RSS를 구했을 때의 회귀곡선, t의 구간을 추정하기 위해 minimum bracket을 이용한 방법, AIC/BIC 비교 등 다양한 비교를 수행했습니다.

결론에서는 다변량 데이터, p의 차원 탐색 등의 방법에서 일반화 가능성을 언급하며 제안한 알고리즘의 활용 영역을 확장하는 방안을 제시하고 있습니다.





브로콜리지만사랑받고싶어