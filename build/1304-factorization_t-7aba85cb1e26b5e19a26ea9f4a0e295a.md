# 분해정리 factorization theorem

```{prf:theorem} 분해정리
:label: fthe

$ X_1, X_2, \cdots, X_n \overset{r.s.}{\sim} f(x;\theta)$일 때, 어떤 통계량 $Y = u(X_1, X_2, \cdots, X_n)$가 $\theta$에 대한 충분통계량이기 위한 필요충분조건은 결합확률밀도함수가 아래와 같이 $\theta$에 의존하는 부분과 의존하지 않는 부분으로 분해할 수 있는 것이다.

$$
f(x_1;\theta)f(x_2;\theta)\cdots f(x_n;\theta) = g[ u(x_1, x_2, \cdots, x_n) ; \theta ]h(x_1, x_2, \cdots, x_n)
$$

```


충분통계량의 성질을 이용하여 증명하는 경우 추정통계량 $Y$의 분포를 직접 대입하여 정리하는 번거로운 과정을 거쳐야 하지만, 분해정리를 이용하는 경우 $Y$의 분포에 대한 정보없이 결합확률밀도함수만을 이용하여 증명할 수 있기 때문에 충분통계량 증명 문제가 간결해진다.

---

# 관련 예제

---

```{prf:example}
:label: 7-4-2
$(X_1, X_2, \cdots , X_n) \overset{r.s.}{\sim} B(1, \theta)$일 때, $Y = \sum X_i$는 모수 $\theta$에 대한 충분통계량임을 보여라.
```

$(X_1, X_2, \cdots , X_n)$의 결합확률밀도함수는 다음과 같다.

```math
\begin{aligned}

\prod_{i=1}^n f(x_i;\theta) &= \prod_{i=1}^n \theta^{x_i} (1-\theta)^{1-x_i} \\

&= \theta^{\sum x_i} (1-\theta)^{n-\sum x_i} \\

&= \underset{ = \theta^{\sum x_i} (1-\theta)^{n-\sum x_i}} {\boxed{g(\sum x_i ; \theta)}} \underset{=1}{\boxed{h(x_1, \cdots, x_n)}}

\end{aligned}
```

따라서, 분해정리에 의해 통계량 $Y = \sum X_i$는 모수 $\theta$에 대한 충분통계량이다. $\blacksquare$
