# 충분통계량 sufficient statistics

```{prf:definition} 충분통계량
:label: ss1

$ X_1, X_2, \cdots, X_n \overset{r.s.}{\sim} f(x;\theta)$일 때, 어떤 통계량 $Y = u(X_1, X_2, \cdots, X_n)$에 대한 $X = (X_1, X_2, \cdots, X_n)$의 조건부 분포가 $\theta$에 의존하지 않을 때, $Y$를 $\theta$에 대한 충분통계량이라고 한다.

```

```{prf:proof} 충분통계량의 성질
:label: ss2

$ X_1, X_2, \cdots, X_n \overset{r.s.}{\sim} f(x;\theta)$일 때, 어떤 통계량 $Y = u(X_1, X_2, \cdots, X_n)$이 $\theta$에 대한 충분통계량이기 위한 필요충분조건은 임의의 통계량 $T$에 대해 $Y=y$일 때에 $T$의 조건부분포가 $\theta$에 의존하지 않는 것이다.

```

통계량의 충분성이란 표본(데이터)이 가지고 있는, 원래 분포에 관한 정보를 모두 가지고 있는지에 대한 문제이다. 이때에 표본이 가지고 있는 모수에 대한 정보를 동등하게 가지고 있는 통계량을 충분통계량이라고 한다. 즉, 충분성은 어느 통계량이 가지고 있는 모분포에 대한 정보량과 표본이 가지고 있는 모분포에 대한 정보량의 크기의 동등성에 관한 문제이다. 

충분성이 보장되는 통계량은 모분포를 추정하는 문제에서 표본을 사용하는 것과 동일한 능력을 가진다. 특히, 표본보다 차원이 낮거나 계산이 간단한 경우 표본을 직접 사용하는 것보다 통계량을 사용하는 것이 모분포를 추정하는 문제를 훨씬 간단하게 만들어줄 수 있다. 이 때문에, 모수를 추정하는 문제에서 특정 통계량이 충분통계량인지의 문제는 모수 추정 과정에서 표본의 정보량을 온전히 사용할 수 있는지에 관련된 문제라고 할 수 있다.

---

# 관련 예제

```{prf:example}
:label: 7-4-1
$(X_1, X_2, \cdots , X_n) \overset{r.s.}{\sim} B(1, \theta)$일 때, $Y = \sum X_i$는 모수 $\theta$에 대한 충분통계량임을 보여라.
```

$X|Y=y$의 조건부 확률밀도함수를 구하면 다음과 같다.

```math
\begin{gathered}

P(X_1 = x_1, X_2 = x_2, \cdots, X_n = x_n | Y=y) \\
\\
= \frac { P(X_1 = x_1, X_2 = x_2, \cdots, X_n = x_n, Y=y) } { P(Y=y) } \\
\\
= \frac {\theta^{\sum x_i}(1-\theta)^{n-\sum x_i}} {\binom n y \theta^y (1-\theta)^{n-y}}\\
\\
= \frac 1 {\binom n y} = \frac{(n-y)! y!}{n!}

\end{gathered}
```

$X|Y=y$의 조건부 확률밀도함수가 $\theta$에 의존하지 않으므로 충분통계량의 정의에 따라 $Y = \sum X_i$는 모수 $\theta$에 대한 충분통계량이다. $\blacksquare$