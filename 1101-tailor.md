# 테일러 정리

```{prf:theorem} 테일러 정리
:label: tailor

함수 $f$가 점 $a$ 근방에서 무한히 미분 가능하고

$$
f(x) = \sum_{k=0}^{\infty} \frac{f^{(k)}(a)}{k!} (x-a)^k
$$

이 성립하기 위한 필요충분조건은, 오차항 $R_n(x)$가 0으로 수렴해야 한다. 즉, $\exist \varepsilon_n \in (a, x)$에 대해,

$$
\lim_{n \to \infty} R_n(x) = \lim_{n \to \infty} \frac {f^{(n+1)}(\varepsilon_n)}{(n+1)!}(x-a)^(n+1) = 0
$$

이어야 한다.

```

## 1. 유한차 테일러 공식 증명

### 1.1. 보조함수 $F$ 정의

$n$차 테일러 다항식을 다음과 같이 정의하자.

```math
P_n(t) = \sum_{k=0}^n \frac{f^{(k)}(a)}{k!}(t-a)^k
```

함수 $f(x)$와 $P_n(x)$의 오차를 다음과 같이 표현한다.

```math
E = f(x) - P_n(x)
```

다음과 같이 $F(a) = F(x) = 0$을 만족하는 보조함수 $F$를 정의한다.

```math
F(t) = f(t) - P_n(t) - E \frac{(t-a)^{(n+1)}}{(x-a)^{(n+1)}}
```

위 보조함수는 $a$에서 모든 도함수값이 0이다. 그 이유는,

```math
P_n(t) = f(a) + f'(a)(t-a) + \frac {f''(a)}{2!}(t-a)^2 + \cdots + \frac {f{(n)}}{n!}(t-a)^n
```

로 표현할 수 있기 때문에 n차 미분하면 $f^{(n)}(a)$값을 제외하고 모든 항이 0이 되고, 

```math
E\frac {(t-a)^{n+1}}{(x-a)^{n+1}}
```
은 $j \leq n$번 미분하고 $t=a$에서 $0$이 되기 때문이다.

---

### 1.2. 잔차항 중간점

$F(a) = 0$, $F(x) = 0$이므로 롤의 정리에 의해 $\exist c_1 \in \mathcal H (a, x), \ F'(c_1) = 0$인 $c_1$이 존재한다. 그런데, $F'(a) = 0$이므로 $\exist c_2 \in \mathcal H (a, c_1), \ F''(c_2)=0$인 $c_2$가 존재한다. 이 과정을 $n$차까지 반복하면 $\exist \xi_n \in \mathcal H (a, x), \ F^{(n+1)}(\xi_n) = 0$을 만족하는 $\xi_n$이 존재한다는 것을 알 수 있다.

---

### 1.3. $F$를 $n+1$번 미분

$F(t)$를 $n+1$번 미분했을 때에 각 항은 다음과 같다.

$f(t)$는 $n+1$계 도함수가 된다.

$P_n(t)$는 $t$에 대한 $n$차 다항식이므로 0이 된다.

$\frac {d^{n+1}}{dt^{n+1}}(t-a)^{n+1} = (n+1)!$이므로 최종적으로는 다음과 같이 정리할 수 있다.

```math
F^{(n+1)}(t) = f^{(n+1)}(t) - E\frac{(n+1)!}{(x-a)^{n+1}}
```

그런데 $\xi_n \in \mathcal H(a,x)$에 대해 $F^{(n+1)}(\xi_n) = 0$이므로

```math
\begin{gathered}
F^{(n+1)}(\xi_n) = f^{(n+1)}(\xi_n) - E\frac{(n+1)!}{(x-a)^{n+1}} = 0 \\

\\

\Rightarrow E = \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1} = f(x) - P_n(x) \\

\\

f(x) = P_n(x) + \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1}\\

\\
\Rightarrow \underset{\text{유한차 테일러 공식}}{\boxed{f(x) = \sum_{k=0}^n \frac{f^{(k)}(a)}{k!}(t-a)^k + \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1}}}
\end{gathered}
```

---

## 2. 충분성 증명

```math
R_n(x) = \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1}
```

라고 표기하고, 

```math
\lim_{n \to \infty}\frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1} = 0
```
이라고 가정하자. 유한차 테일러 공식의 극한을 구하면,

```math
\begin{aligned}
\lim_{n \to \infty} f(x) &= \lim_{n \to \infty}  \sum_{k=0}^n \frac{f^{(k)}(a)}{k!}(x-a)^k + \lim_{n \to \infty}  \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1} \\

&= \sum_{k=0}^\infty \frac{f^{(k)}(a)}{k!}(x-a)^k

\end{aligned}
```

따라서, 

```math
f(x) = \underset{\text{테일러 급수}}{\boxed{\sum_{k=0}^\infty \frac{f^{(k)}(a)}{k!}(x-a)^k}}
```

정리하면, $R_n(x) \to 0 \Rightarrow$ 테일러 급수가 실제 함수값으로 수렴한다.

---

## 3. 필요성 증명

유한차 테일러 급수를 $S_n(x)$로 표기하자. 

```math
S_n(x) = \sum_{k=0}^n \frac{f^{(k)}(a)}{k!}(x-a)^k
```

이제,

```math
f(x) = \lim_{n \to \infty} S_n(x)
```

가 성립한다고 가정하자. 유한차 테일러 공식에서 잔차항의 극한을 구하면,

```math
\begin{aligned}

& R_n(x) = f(x) - S_n(x) \\

&\rightarrow \lim_{n \to \infty} R_n(x) = f(x) - \lim_{n \to \infty} S_n(x) = f(x) - f(x) = 0

\end{aligned}
```

정리하면, $S_n(x) \to f(x) \Rightarrow R_n(x) \to 0$이 성립한다.

---

충분성과 필요성의 증명을 정리하면 아래와 같은 정리가 완성된다.

```math
\lim_{n \to \infty} \frac{f^{(n+1)}(\xi_n)}{(n+1)!}(x-a)^{n+1} = 0 \\

\Leftrightarrow f(x) = \sum_{k=0}^\infty \frac{f^{(k)}(a)}{k!}(x-a)^k
```

$\blacksquare$