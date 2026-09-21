# 지수족과 완비충분통계량 증명


사진의 표기 그대로 쓰면 다음과 같이 증명할 수 있어. 다만 먼저 한 가지 중요한 점이 있다. 사진의 정리 2는 엄밀하게는 **자연모수벡터**
[
(c_1(\theta),\ldots,c_k(\theta))
]
가 (\mathbb R^k)의 열린집합을 포함한다는 조건이 추가되어야 일반적으로 성립한다. 이 조건이 없으면 다모수·곡선형 지수족에서는 완비성이 깨질 수 있다. 아래에서는 그 조건까지 포함해서 증명하겠다.

사진의 정의에 따라

[
f(x;\theta)
===========

\exp\left{
\sum_{j=1}^{k}c_j(\theta)T_j(x)+d(\theta)+S(x)
\right}I_A(x),
]

이고

[
A={x:f(x;\theta)>0}
]

는 (\theta)에 의존하지 않는다고 하자.

그리고

[
Y=[T_1(X),T_2(X),\ldots,T_k(X)]
]

라 하자.

---

## 1. 먼저 (Y)가 충분통계량임을 보이자

밀도함수를

[
f(x;\theta)
===========

\underbrace{
\exp\left{
\sum_{j=1}^k c_j(\theta)T_j(x)+d(\theta)
\right}
}*{\theta\text{와 }Y\text{에만 의존}}
\underbrace{
e^{S(x)}I_A(x)
}*{\theta\text{에 무관}}
]

로 쓸 수 있다.

즉,

[
f(x;\theta)=g_\theta(Y)h(x)
]

꼴이다.

여기서 중요한 것이 사진의 조건 (ii)이다.

[
A\text{가 }\theta\text{에 의존하지 않는다}.
]

따라서

[
e^{S(x)}I_A(x)
]

전체가 (\theta)와 무관하다.

그러므로 Neyman–Fisher 인수분해정리에 의해

[
\boxed{Y=[T_1(X),\ldots,T_k(X)]}
]

는 (\theta)에 대한 충분통계량이다.

---

# 2. 이제 완비성을 보이자

완비성을 증명하려면 임의의 함수 (g)에 대하여

[
E_\theta[g(Y)]=0
\qquad\text{for every }\theta
]

라고 했을 때

[
P_\theta(g(Y)=0)=1
]

임을 보여야 한다.

(Y)의 밀도 또는 확률질량함수를

[
f_Y(y;\theta)
]

라고 하자.

원래 (X)의 밀도가

[
f(x;\theta)
===========

e^{\sum c_j(\theta)T_j(x)+d(\theta)}
e^{S(x)}I_A(x)
]

이므로 (Y=(T_1(X),\ldots,T_k(X)))의 분포 역시 어떤 (\theta)와 무관한 함수 (H(y))를 이용하여

[
f_Y(y;\theta)
=============

\exp\left{
\sum_{j=1}^k c_j(\theta)y_j+d(\theta)
\right}H(y)
]

꼴로 나타낼 수 있다.

즉,

[
f_Y(y;\theta)
=============

e^{d(\theta)}
e^{\sum_{j=1}^k c_j(\theta)y_j}H(y).
]

---

## 3. 완비성의 가정을 대입

이제

[
E_\theta[g(Y)]=0
]

라고 하자.

그러면

[
\int g(y)f_Y(y;\theta),dy=0.
]

따라서

[
\int
g(y)
e^{d(\theta)}
e^{\sum_{j=1}^kc_j(\theta)y_j}
H(y),dy
=0.
]

(e^{d(\theta)}>0)이므로 나누면

[
\boxed{
\int
g(y)H(y)
\exp\left{
\sum_{j=1}^kc_j(\theta)y_j
\right}
dy
=0
}
\tag{1}
]

가 모든 (\theta)에 대해 성립한다.

여기서 완비성을 만드는 핵심이 나온다.

---

# 4. 한 (\theta_0)를 고정한다

자연모수벡터를

[
c(\theta)
=========

[c_1(\theta),\ldots,c_k(\theta)]
]

라고 하자.

자연모수공간

[
\mathcal C
==========

{
[c_1(\theta),\ldots,c_k(\theta)]:
\theta\in\Theta
}
]

가 (\mathbb R^k)에서 열린집합을 포함한다고 하자.

그 내부에서 하나의 (\theta_0)를 잡는다.

식 (1)을 조금 다르게 쓰기 위해

[
c_j(\theta)
===========

c_j(\theta_0)
+
{c_j(\theta)-c_j(\theta_0)}
]

로 분해한다.

그러면

[
\begin{aligned}
0
&=
\int g(y)H(y)
e^{\sum c_j(\theta)y_j},dy\
&=
\int
g(y)H(y)
e^{\sum c_j(\theta_0)y_j}
e^{\sum[c_j(\theta)-c_j(\theta_0)]y_j}
,dy.
\end{aligned}
]

여기서

[
f_Y(y;\theta_0)
===============

e^{d(\theta_0)}
e^{\sum c_j(\theta_0)y_j}H(y)
]

이므로 상수 (e^{-d(\theta_0)})를 제외하면

[
\boxed{
E_{\theta_0}
\left[
g(Y)
\exp
\left{
\sum_{j=1}^k
[c_j(\theta)-c_j(\theta_0)]Y_j
\right}
\right]
=0.
}
\tag{2}
]

---

# 5. 식 (2)를 적률생성함수와 비교

다음과 같이 놓자.

[
t_j=c_j(\theta)-c_j(\theta_0),
\qquad j=1,\ldots,k.
]

그러면 (2)는

[
E_{\theta_0}
\left[
g(Y)e^{t_1Y_1+\cdots+t_kY_k}
\right]
=0.
]

즉,

[
\boxed{
E_{\theta_0}
[g(Y)e^{t^TY}]=0
}
\tag{3}
]

이다.

그런데 (\mathcal C)가 열린집합을 포함하고 (c(\theta_0))가 그 내부에 있으므로,

[
t=c(\theta)-c(\theta_0)
]

는

[
t=(0,\ldots,0)
]

주변의 어떤 열린영역을 움직일 수 있다.

따라서 (3)은 (t=0)의 근방 전체에서 성립한다.

---

# 6. MGF의 유일성을 적용

이제

[
g(Y)
]

를 가중치로 갖는 signed measure를 생각하면

[
E_{\theta_0}
[g(Y)e^{t^TY}]
]

는 그것의 다변량 MGF/Laplace transform에 해당한다.

그것이 (t=0)의 열린 근방에서 항상 (0)이다.

MGF의 유일성에 의해 그 signed measure 자체가 (0)이어야 하므로

[
g(Y)=0
\qquad P_{\theta_0}\text{-a.s.}
]

가 된다.

그리고 지수족의 조건 (ii)에 의해 모든 (\theta)에서 지지집합이 동일하므로

[
P_\theta(g(Y)=0)=1
\qquad\forall\theta.
]

따라서 완비성의 정의에 의해

[
\boxed{
Y=[T_1(X),\ldots,T_k(X)]
\text{는 완비통계량이다.}
}
]

앞에서 충분성도 보였으므로

[
\boxed{
Y=[T_1(X),\ldots,T_k(X)]
\text{는 완비충분통계량이다.}
}
]

---

# 7. 사진의 (B): 확률표본일 때

이제

[
X_1,\ldots,X_n
]

이 (f(x;\theta))로부터의 확률표본이라고 하자.

각 표본의 밀도는

[
f(x_i;\theta)
=============

\exp\left{
\sum_{j=1}^k c_j(\theta)T_j(x_i)
+d(\theta)+S(x_i)
\right}I_A(x_i).
]

독립이므로 결합밀도는

[
\begin{aligned}
f(\mathbf x;\theta)
&=
\prod_{i=1}^n f(x_i;\theta)\
&=
\exp\left{
\sum_{i=1}^n
\left[
\sum_{j=1}^k c_j(\theta)T_j(x_i)
+d(\theta)+S(x_i)
\right]
\right}
\prod_{i=1}^nI_A(x_i).
\end{aligned}
]

합의 순서를 바꾸면

[
f(\mathbf x;\theta)
===================

\exp\left{
\sum_{j=1}^k
c_j(\theta)
\left(\sum_{i=1}^nT_j(x_i)\right)
+nd(\theta)
+\sum_{i=1}^nS(x_i)
\right}
\prod_{i=1}^nI_A(x_i).
]

따라서 이것 역시 지수족이고 새로운 (T_j) 역할을 하는 것이

[
T_j^*(\mathbf X)
================

\sum_{i=1}^nT_j(X_i).
]

그러므로 위에서 증명한 (A)를 그대로 적용하면

[
\boxed{
Y=
\left[
\sum_{i=1}^nT_1(X_i),
\sum_{i=1}^nT_2(X_i),
\ldots,
\sum_{i=1}^nT_k(X_i)
\right]
}
]

가 완비충분통계량이다.

---

특히 이 교재의 증명 흐름을 아주 압축하면

[
\boxed{
\begin{aligned}
&f(x;\theta)
============

\exp\left{
\sum c_j(\theta)T_j(x)+d(\theta)+S(x)
\right}I_A(x)
[2mm]
&\quad\Downarrow\ \text{인수분해정리}\
&[T_1(X),\ldots,T_k(X)]
\text{ 충분}
[3mm]
&E_\theta[g(Y)]=0
\
&\quad\Downarrow\
&\int g(y)H(y)
e^{\sum c_j(\theta)y_j}dy=0
\
&\quad\Downarrow\ \text{MGF/Laplace 변환의 유일성}\
&g(Y)=0\quad a.s.
\
&\quad\Downarrow\
&[T_1(X),\ldots,T_k(X)]
\text{ 완비}.
\end{aligned}}
]

그리고 사진에서 **(ii) (A)가 (\theta)에 의존하지 않는 조건은 단순한 장식이 아니다.** 충분성에서 (I_A(x))를 (\theta)와 무관한 부분으로 떼어내는 데도 쓰이고, 완비성에서 서로 다른 (\theta)들이 동일한 지지집합을 갖도록 하는 데도 필요하다.

다만 사진의 정리에는 적어도 보이는 부분만 보면 **(c(\theta)=(c_1(\theta),\ldots,c_k(\theta)))의 범위가 열린집합을 포함한다는 조건이 생략되어 있다.** 이 조건 없이 “모든 지수족에서 (T_1,\ldots,T_k)가 완비”라고 하면 일반적으로는 틀리다.



# 자연모수 공간

두 표현은 사실 **같은 기하학적 조건을 서로 다른 좌표에서 말한 것**이다. 핵심은 (c_1(\theta),\dots,c_k(\theta))가 서로 독립적인 방향으로 조금씩 변할 수 있어야 한다는 것이다.

## (1) 자연모수공간이 (\mathbb R^k)에서 열린집합을 포함한다는 의미

교재의 표기를 그대로 쓰면 지수족은

[
f(x;\theta)
===========

\exp\left{
\sum_{j=1}^k c_j(\theta)T_j(x)+d(\theta)+S(x)
\right}I_A(x)
]

이다.

여기서 **자연모수**는 원래 모수 (\theta) 자체가 아니라

[
\boxed{
(c_1(\theta),c_2(\theta),\ldots,c_k(\theta))
}
]

이다.

따라서 자연모수공간을

[
\mathcal C
==========

\left{
(c_1(\theta),\ldots,c_k(\theta)):\theta\in\Theta
\right}
\subset\mathbb R^k
]

라고 한다.

### (k=1)인 경우

자연모수가 (c_1(\theta)) 하나뿐이면

[
\mathcal C\subset\mathbb R.
]

이때 열린집합은 예를 들어

[
(a,b),\qquad (-\infty,b),\qquad (a,\infty),\qquad \mathbb R
]

같은 것이다.

따라서 자연모수공간이

[
\mathcal C=(0,\infty)
]

라면 열린집합이다.

또는

[
\mathcal C=[0,\infty)
]

도 그 자체는 열린집합이 아니지만, 그 안에

[
(0,\infty)
]

라는 열린집합을 포함하므로 **“열린집합을 포함한다”**는 조건은 만족한다.

---

### (k=2)인 경우가 더 중요하다

이제

[
(c_1(\theta),c_2(\theta))\in\mathbb R^2
]

이므로 자연모수공간은 평면 위의 점들의 집합이다.

예를 들어 자연모수공간이

[
\mathcal C=\mathbb R^2
]

이면 당연히 조건을 만족한다.

또

[
\mathcal C
==========

{(c_1,c_2):c_1>0,\ c_2>0}
]

처럼 평면에서 **면적을 가진 영역**이어도 된다.

핵심적으로 어떤 점

[
(c_1(\theta_0),c_2(\theta_0))
]

주변에 작은 원을 하나 그렸을 때 그 원 내부의 점들이 전부 자연모수공간 안에 들어갈 수 있어야 한다.

수학적으로는 어떤 (\epsilon>0)가 존재하여

[
\boxed{
\left{
(c_1,c_2):
\left|
(c_1,c_2)
---------

(c_1(\theta_0),c_2(\theta_0))
\right|<\epsilon
\right}
\subset\mathcal C
}
]

라는 뜻이다.

### 반대로 이런 것은 안 된다

예를 들어

[
c_1(\theta)=\theta,\qquad
c_2(\theta)=\theta^2
]

라고 하자.

그러면

[
\mathcal C
==========

{(\theta,\theta^2):\theta\in\mathbb R}.
]

이건 (\mathbb R^2)에서 포물선 한 줄뿐이다.

즉,

[
\begin{array}{c}
c_2\
\uparrow\
\qquad \cdot\
\quad\cdot\qquad\cdot\
\cdot\qquad\qquad\cdot\
\hline
\qquad\qquad\to c_1
\end{array}
]

어떤 점을 잡아도 그 주변의 **작은 원 전체**가 포물선 안에 들어갈 수 없다.

따라서 이 집합은 (\mathbb R^2)에서 열린집합을 포함하지 않는다.

중요한 차이는

[
\boxed{
\text{2개의 자연모수가 있는데 실제로는 1개의 방향으로만 움직인다}
}
]

는 것이다.

---

# (2) (t)가 ((0,\ldots,0)) 주변의 열린 영역을 움직인다는 의미

이제 앞의 증명에서

[
t_j
===

c_j(\theta)-c_j(\theta_0)
]

라고 정의했다.

벡터로 쓰면

[
\boxed{
t=
(c_1(\theta)-c_1(\theta_0),\ldots,
c_k(\theta)-c_k(\theta_0))
}
]

이다.

즉,

[
t=c(\theta)-c(\theta_0).
]

이건 그냥 **자연모수공간을 (c(\theta_0))만큼 평행이동해서 (c(\theta_0))를 원점으로 옮긴 것**이다.

---

## (k=1)로 보면 아주 간단하다

예를 들어 (c(\theta_0)=3)이고 자연모수공간이 적어도

[
(2,4)
]

를 포함한다고 하자.

그러면

[
t=c(\theta)-3.
]

(c(\theta))가

[
2<c(\theta)<4
]

를 움직일 수 있으므로

[
-1<t<1.
]

즉,

[
\boxed{t\in(-1,1)}
]

이다.

원래 (c(\theta))는 (3) 주변을 움직였는데, (3)을 빼니까 (t)는 (0) 주변을 움직인다.

---

## (k=2)라면

예를 들어

[
c(\theta_0)=(2,3)
]

이라고 하자.

그리고 자연모수공간이 ((2,3))을 중심으로 하는 작은 원판 전체를 포함한다고 하자.

즉,

[
(c_1-2)^2+(c_2-3)^2<\epsilon^2
]

인 모든 ((c_1,c_2))가 가능한 자연모수라고 하자.

이제

[
t_1=c_1-2,\qquad
t_2=c_2-3
]

라고 하면

[
t_1^2+t_2^2<\epsilon^2.
]

즉, (t=(t_1,t_2))는

[
(0,0)
]

주변의 작은 원판 전체를 움직인다.

그래서

[
\boxed{
|t|<\epsilon
}
]

인 모든 작은 (t)가 가능하다.

---

# 왜 굳이 (t)를 이렇게 정의하나?

이게 완비성 증명에서 가장 중요한 부분이다.

우리가 얻은 식이

[
E_{\theta_0}
\left[
g(Y)
\exp\left{
\sum_{j=1}^k
[c_j(\theta)-c_j(\theta_0)]Y_j
\right}
\right]=0
]

이었다.

여기서

[
t_j=c_j(\theta)-c_j(\theta_0)
]

라고 놓으면

[
\boxed{
E_{\theta_0}
\left[
g(Y)e^{t_1Y_1+\cdots+t_kY_k}
\right]=0.
}
]

이 식은 MGF

[
M(t)
====

E[e^{t_1Y_1+\cdots+t_kY_k}]
]

와 똑같은 형태다.

MGF의 유일성 정리는 보통 **(t=(0,\ldots,0))의 어떤 근방에서 MGF가 존재하고 그 값을 알고 있을 때** 적용한다.

그래서 자연모수공간의 열린집합 조건이 필요하다.

[
\boxed{
\begin{array}{c}
c(\theta)\text{가 }c(\theta_0)\text{ 주변의 열린 영역을 움직임}\
\Downarrow\
t=c(\theta)-c(\theta_0)\
\Downarrow\
t\text{가 }0\text{ 주변의 열린 영역을 움직임}\
\Downarrow\
E_{\theta_0}[g(Y)e^{t^TY}]=0
\text{가 }t=0\text{ 근방에서 성립}\
\Downarrow\
\text{MGF/Laplace transform의 유일성 적용 가능}
\end{array}
}
]

---

## 가장 중요한 직관

여기서 **“(t)가 움직인다”**는 표현은 (t)라는 확률변수가 움직인다는 뜻이 아니다.

(t)는 단순히 우리가 선택할 수 있는 **상수 벡터**다.

[
t=(t_1,\ldots,t_k).
]

(\theta)를 여러 값으로 바꾸면

[
c(\theta)
]

가 바뀌고, 따라서

[
t=c(\theta)-c(\theta_0)
]

도 여러 값을 취하게 된다는 뜻이다.

예를 들어 (k=2)에서 열린 영역이라면

[
t=(0.01,0),\quad
(-0.01,0.02),\quad
(0,-0.03),\quad
(0.005,0.004)
]

처럼 **0에 충분히 가까운 모든 방향의 벡터를 선택할 수 있다**는 의미다.

반대로

[
c(\theta)=(\theta,\theta^2)
]

이면

[
t
=

(\theta-\theta_0,\theta^2-\theta_0^2)
]

이고 (t_1,t_2)를 마음대로 독립적으로 고를 수 없다. (t)는 특정 곡선 위에서만 움직인다. 그래서 (0) 주변의 열린 영역을 채우지 못하고, 앞의 MGF 유일성 논리를 그대로 적용할 수 없는 것이다.

결국 두 질문을 한 문장으로 합치면,

[
\boxed{
\text{자연모수 }(c_1,\ldots,c_k)\text{가 한 점 주변에서 모든 방향으로 조금씩 변할 수 있으면,}
}
]

그 점을 원점으로 평행이동한

[
\boxed{
t_j=c_j(\theta)-c_j(\theta_0)
}
]

역시 (0) 주변에서 모든 방향으로 조금씩 변할 수 있다는 의미다.






# 지수족과 자연모수 

여기서 **“유한차원 함수공간”**이라는 표현 때문에 오히려 내용이 어려워 보입니다. 본질은 훨씬 단순합니다.

핵심은 지수족에서는 **(x)에 관한 몇 개의 고정된 함수만 준비해 놓고, 모수가 바뀔 때 그 함수들 앞의 계수만 바뀌어야 한다**는 뜻입니다.

### 1. 먼저 숫자 벡터와 비교해보자

(\mathbb R^2)에서는 두 벡터

[
e_1=(1,0),\qquad e_2=(0,1)
]

만 있으면 모든 벡터를

[
a e_1+b e_2
]

로 표현할 수 있습니다.

예를 들어

[
(3,5)=3e_1+5e_2.
]

그래서 (\mathbb R^2)를 **2차원 공간**이라고 합니다.

함수도 똑같이 생각할 수 있습니다. 예를 들어

[
1,\qquad x,\qquad x^2
]

라는 세 함수를 준비하면,

[
3+2x-7x^2
]

같은 함수는

[
3(1)+2(x)-7(x^2)
]

로 나타낼 수 있습니다.

이때

[
\operatorname{span}{1,x,x^2}
]

는 (1,x,x^2)를 조합해서 만들 수 있는 함수들의 공간이고, 최대 3차원입니다.

---

### 2. 지수족에서 이것이 왜 등장하는가?

지수족을

[
f(x;\theta)
===========

h(x)c(\theta)
\exp\left{
\eta_1(\theta)T_1(x)+\cdots+
\eta_k(\theta)T_k(x)
\right}
]

라고 합시다.

로그를 취하면

[
\log f(x;\theta)
================

\log h(x)+\log c(\theta)
+\eta_1(\theta)T_1(x)+\cdots+
\eta_k(\theta)T_k(x).
]

여기서 중요한 것은

[
\boxed{T_1(x),\ldots,T_k(x)\text{가 고정되어 있다는 것}}
]

입니다.

모수가 바뀌어도 (T_j) 자체는 바뀌지 않습니다. 변하는 건

[
\eta_1(\theta),\ldots,\eta_k(\theta)
]

라는 **계수**뿐입니다.

예를 들어 어떤 지수족이

[
\log f(x;\theta)
=A(\theta)+\eta_1(\theta)x+\eta_2(\theta)x^2
]

형태라면, 모수가 아무리 변해도 (x)에 관한 부분은 항상

[
a x+b x^2
]

꼴입니다.

즉 모든 가능한 (x)-함수들이

[
\operatorname{span}{1,x,x^2}
]

안에 들어 있습니다.

이걸 제가 앞서 **“고정된 유한차원 함수공간에 들어 있어야 한다”**고 표현한 겁니다.

---

## 3. 정규분포를 보면 감각이 잡힌다

예를 들어

[
X\sim N(\mu,\sigma^2)
]

이면

[
\log f(x)
=========

-\frac12\log(2\pi\sigma^2)
-\frac{(x-\mu)^2}{2\sigma^2}.
]

전개하면

# [

A(\mu,\sigma^2)
+\frac{\mu}{\sigma^2}x
-\frac{1}{2\sigma^2}x^2.
]

(x)에 관한 함수는 딱

[
x,\qquad x^2
]

두 개밖에 없습니다.

(\mu,\sigma^2)가 어떻게 바뀌든

[
\frac{\mu}{\sigma^2}x
-\frac1{2\sigma^2}x^2
]

이므로 (x)와 (x^2) 앞의 **계수만 바뀝니다.**

그래서 정규분포는

[
T_1(x)=x,\qquad T_2(x)=x^2
]

라는 고정된 두 함수를 사용하여 지수족으로 나타낼 수 있습니다.

---

# 4. 그런데 4번의 분포는 다르다

문제의 밀도는

[
f(x;\theta_1,\theta_2)
======================

\frac{\theta_1}{\theta_2}
x^{\theta_1-1}
\exp\left(-\frac{x^{\theta_1}}{\theta_2}\right).
]

로그를 취하면

[
\log f
======

\log\theta_1-\log\theta_2
+(\theta_1-1)\log x
-\frac1{\theta_2}x^{\theta_1}.
]

여기서

[
(\theta_1-1)\log x
]

는 괜찮습니다.

고정된 함수

[
T_1(x)=\log x
]

를 잡으면 그 앞의 계수가 (\theta_1-1)일 뿐이니까요.

문제는

[
\boxed{x^{\theta_1}}
]

입니다.

(\theta_1)이 변하면

[
\theta_1=1\quad\Rightarrow\quad x,
]

[
\theta_1=2\quad\Rightarrow\quad x^2,
]

[
\theta_1=3\quad\Rightarrow\quad x^3,
]

[
\theta_1=4\quad\Rightarrow\quad x^4,
]

[
\cdots
]

처럼 **필요한 (x)의 함수 자체가 계속 새로 생깁니다.**

정규분포에서는

[
x,\ x^2
]

두 개만 준비하면 끝이었는데, 여기서는

[
x,\ x^2,\ x^3,\ x^4,\ldots
]

가 끝없이 필요해집니다.

이것이 바로 “유한차원 공간에 들어가지 않는다”는 의미입니다.

---

## 5. 그런데 혹시 (x,x^2,x^3,\ldots)를 몇 개의 함수로 표현할 수 있지 않을까?

이 부분이 엄밀한 핵심입니다.

가령 어떤 고정된 함수

[
T_1(x),\ldots,T_k(x)
]

몇 개만으로 모든 (x^{\theta_1})을 표현할 수 있다고 가정해 봅시다.

그러면 특히

[
x,x^2,x^3,\ldots
]

도 모두

[
T_1,\ldots,T_k
]

의 선형결합이어야 합니다.

그런데

[
x,x^2,x^3,\ldots
]

는 **서로 선형독립**입니다.

예를 들어

[
a_1x+a_2x^2+a_3x^3=0
\qquad\text{모든 }x>0
]

이라고 하면 이 다항식이 모든 (x)에서 0이므로

[
a_1=a_2=a_3=0
]

밖에는 가능하지 않습니다.

마찬가지로

[
x,x^2,\ldots,x^m
]

는 (m)개 모두 선형독립입니다.

따라서 몇 개를 선택하든 항상 그것보다 더 많은 새로운 독립적인 함수

[
x^{m+1},x^{m+2},\ldots
]

가 생깁니다.

그래서 필요한 함수공간의 차원이

[
1,2,3,\ldots
]

계속 커져서 **유한한 (k)로 끝낼 수 없습니다.**

---

## 6. 앞에서 미분했던 이유도 이제 이해할 수 있다

한 가지 미묘한 점이 있습니다.

로그밀도에는 (x^{\theta_1})만 있는 것이 아니라

[
(\theta_1-1)\log x
]

도 같이 있죠.

그래서 “(x^{\theta_1})가 반드시 지수족의 (T_j)들로 표현되어야 한다”는 사실을 엄밀히 분리해낼 필요가 있습니다.

사실 미분보다 더 쉬운 방법이 있습니다.

(\theta_1=a)를 하나 고정하고, (\theta_2=b_1,b_2) 두 값을 생각해 봅시다.

그러면

[
\log f(x;a,b_1)
===============

\log a-\log b_1
+(a-1)\log x
-\frac{x^a}{b_1},
]

[
\log f(x;a,b_2)
===============

\log a-\log b_2
+(a-1)\log x
-\frac{x^a}{b_2}.
]

두 식을 빼면 (\log x) 항이 사라져서

[
\log f(x;a,b_1)-\log f(x;a,b_2)
]

# [

\log\frac{b_2}{b_1}
+
\left(\frac1{b_2}-\frac1{b_1}\right)x^a.
]

즉 여기에는 정확하게

[
\boxed{\text{상수}+C x^a}
]

만 남습니다.

한편 지수족이라면

[
\log f(x;\theta)
================

\log h(x)+A(\theta)
+\sum_{j=1}^k\eta_j(\theta)T_j(x)
]

이므로 두 모수값의 로그밀도를 빼면

[
\log h(x)
]

도 사라져서

[
\text{상수}
+\sum_{j=1}^k c_jT_j(x)
]

꼴이어야 합니다.

따라서

[
x^a
]

가 반드시

[
\boxed{\operatorname{span}{1,T_1,\ldots,T_k}}
]

안에 들어가야 합니다.

그런데 (a>0)는 아무 값이나 가능하므로,

[
x,x^2,x^3,\ldots
]

가 **모두 같은 유한한 함수 집합 (T_1,\ldots,T_k)으로 표현돼야 한다**는 결론이 나옵니다.

그게 불가능한 겁니다.

---

### 한 문장으로 압축하면

지수족에서는

> **모수가 변하면 고정된 (x)-함수들의 계수만 변해야 한다.**

그런데 이 문제에서는

[
x^{\theta_1}
]

때문에

> **모수가 변할 때 (x)-함수 자체가 (x,x^2,x^3,\ldots)처럼 계속 새로 변한다.**

따라서 유한개의 고정된 (T_j(x))로는 표현할 수 없고, 그래서 이 2모수 분포족은 유한차원 지수족이 아닙니다.

특히 **“모수가 지수에 들어가면 무조건 지수족이 아니다”는 뜻은 아닙니다.** 중요한 기준은 그 표현을 변형했을 때 **고정된 유한개의 (T_j(x))**로 분리할 수 있느냐입니다. 여기서는 (x^{\theta_1}) 때문에 그게 불가능한 것입니다.
