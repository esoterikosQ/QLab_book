# 상관검정(correlation test)

상관검정은 변수 간의 상관계수가 0인지 여부를 판단하기 위한 검정이다. 아래에서는 피어슨 상관계수를 기준으로 상관검정을 설명한다.

## 1. 표본상관계수

$(X_i, Y_i)$ 차원으로 데이터가 주어졌을 때, 표본상관계수 $r$은 다음과 같다.

```math
r = \dfrac {\sum_{i=1}^n (X_i - \bar X)(Y_i - \bar Y)}{\sqrt {\sum_{i=1}^n (X_i - \bar X)^2 \sum_{i=1}^n (Y_i - \bar Y)^2}}
```

편의를 위해 다음과 같이 표기하면

```math
S_{xx} = \sum_{i=1}^n (X_i-\bar X)^2,\quad  
S_{yy} = \sum_{i=1}^n (Y_i-\bar Y)^2,\quad  
S_{xy} = \sum_{i=1}^n (X_i-\bar X)(Y_i-\bar Y)  
```

표본상관계수는 다음과 같이 표기할 수 있다.

```math
r = \frac{S_{xy}}{\sqrt{S_{xx}S_{yy}}}
```

여기에서 표본상관계수의 분모는 각 변수의 표준편차의 곱, 분자는 두 변수의 공분산으로 이해할 수 있다.

---

## 2. 상관검정

### 2.1. 가설

상관검정의 귀무가설은 "상관계수가 0이다"이며 다음과 같이 표현할 수 있다.

```math
\rho = 0
```

이때, $\rho$는 모집단의 상관계수이다. 


### 2.2. 검정통계량 

상관검정의 검정통계량은 다음과 같다.

```math  
t = \dfrac{r\sqrt{n-2}}{\sqrt{1-r^2}}  
```

이때, $n$ 전체 표본의 수이며, 위 검정통계량은 자유도가 $n-2$인 $t$분포를 따른다. 

```math
t \sim t_{n-2}
```

검정통계량은 아래의 단계를 거쳐 유도할 수 있다.


$$
r = \frac{S_{xy}}{\sqrt{S_{xx}S_{yy}}}  
$$

단순회귀 (Y) on (X) 의 OLS 추정치는  
$$  
\hat\beta_1 = \frac{S_{xy}}{S_{xx}},\quad  
\hat\beta_0 = \bar Y - \hat\beta_1 \bar X  
$$

잔차제곱합(SSE)은  
$$  
\text{SSE} = \sum_{i=1}^n \hat\varepsilon_i^2  
= S_{yy} - \hat\beta_1 S_{xy}  
$$  
인데, (\hat\beta_1 = S_{xy}/S_{xx}) 를 대입하면  
$$  
\text{SSE} = S_{yy} - \frac{S_{xy}^2}{S_{xx}}  
$$

이제 (S_{xy})를 (r)과 (S_{xx}, S_{yy})로 표현하면  
$$  
S_{xy} = r\sqrt{S_{xx}S_{yy}}  
$$  
따라서  
$$  
\frac{S_{xy}^2}{S_{xx}}  
= \frac{r^2 S_{xx}S_{yy}}{S_{xx}}  
= r^2 S_{yy}  
$$  
이므로  
$$  
\text{SSE} = S_{yy} - r^2 S_{yy}  
= S_{yy}(1-r^2)  
$$

그리고 잔차분산의 불편추정량은  
$$  
s^2 = \frac{\text{SSE}}{n-2}  
= \frac{S_{yy}(1-r^2)}{n-2}  
$$



## 세팅: 상관검정 ↔ 회귀계수 검정

표본 ($X_i, Y_i$)이 **모상관계수 ($\rho$)를 가지는 이변량 정규분포**에서 나왔다고 가정합니다.

상관검정에서 자주 쓰는 귀무가설은  
$$  
H_0:\rho = 0  
$$  
이고, 이때는 조건부분포 (Y|X)가  
$$  
Y_i = \beta_0 + 
\beta_1 X_i + \varepsilon_i,\quad \varepsilon_i \sim N(0,\sigma^2), \text{ 독립}  
$$ 
인 **단순선형회귀모형**과 동치가 됩니다.  
게다가  
$$  
H_0:\rho=0 \quad \Longleftrightarrow \quad H_0:\beta_1 = 0  
$$  
이므로

> “상관검정 = 단순회귀에서 기울기 (\beta_1)에 대한 t-검정”
으로 바꿔 생각할 수 있습니다.


## 3\. 회귀계수에 대한 t-검정 통계량

단순회귀에서 기울기 (\beta_1)의 표준오차는  
$$  
\operatorname{SE}(\hat\beta_1) = \frac{s}{\sqrt{S_{xx}}}  
$$

귀무가설 ($H_0:\beta_1=0$) 에 대한 t-검정 통계량은  
```math
t = \frac{\hat \beta_1 - 0}{\operatorname{SE}(\hat \beta_1)}  
= \frac{\hat \beta_1}{s/ \sqrt{S_{xx}}}  
= \frac{\hat \beta_1 \sqrt{S_{xx}}}{s}  
```

여기에 ($\hat \beta_1 = S_{xy}/S_{xx}$) 를 대입하면

```math 
t = \frac{S_{xy}}{S_{xx}} \cdot \frac{\sqrt{S_{xx}}}{s}  
= \frac{S_{xy}}{\sqrt{S_{xx}} \cdot s}  
```

이제 (s^2)와 (S_{xy})를 앞에서 구한 식으로 치환합니다.

```math
(s^2 = \dfrac{S_{yy}(1-r^2)}{n-2}) → (s=\sqrt{\dfrac{S_{yy}(1-r^2)}{n-2}})
\\
(S_{xy} = r\sqrt{S_{xx}S_{yy}})
```

따라서  
```math
t = \frac{r\sqrt{S_{xx}S_{yy}}}{\sqrt{S_{xx}}\sqrt{\\dfrac{S_{yy}(1-r^2)}{n-2}}}  
= \frac{r\sqrt{S_{xx}S_{yy}}}{\sqrt{S_{xx}}\sqrt{S_{yy}}\sqrt{\dfrac{1-r^2}{n-2}}}  
```

분자·분모에서 ($\sqrt{S_{xx}}$), ($\sqrt{S_{yy}}$) 가 약분되어  
```math
t  
= \frac{r}{\sqrt{\dfrac{1-r^2}{n-2}}}  
= \frac{r\sqrt{n-2}}{\sqrt{1-r^2}}  
```
을 얻습니다. 이것이 **상관검정에서 사용하는 t-검정통계량**입니다.

* * *

## 4. 분포: 왜 t 분포를 따르나?

이제 “왜 t 분포인가?” 부분은 회귀이론으로 설명합니다.

- 이변량 정규분포 가정 + $H_0:\rho=0$ 아래에서  
    $\hat \beta_1$은 정규분포를 따르고,
    
- $(n-2)s<sup>2/\sigma</sup>2 = \text{SSE}/\sigma^2$는 자유도 $n-2$인 $\chi^2$ 분포를 따르며,
    
- $\hat\beta_1$과 $s^2$는 서로 독립입니다.
    

그래서  
```math  
t = \frac{\hat\beta_1/\operatorname{SD}(\hat\\beta_1)}{\sqrt{s^2/\sigma^2}}  
```
꼴이 되어, 전형적인  
```math 
\frac{Z}{\sqrt{V/(n-2)}} \quad (Z\sim N(0,1), V\sim \chi^2_{n-2}, Z\perp V)  
```
형태가 되고, 따라서  
```math 
t \sim t_{n-2}  
```
가 됩니다.

* * *

정리하면,

1.  상관검정 $H_0:\rho=0$을 단순회귀에서 기울기 검정으로 바꿔 생각하고,
    
2.  회귀계수 $\hat\beta_1$의 t-통계량을 (r)로 다시 표현한 결과가  
    ```math
    t = \dfrac{r\sqrt{n-2}}{\sqrt{1-r^2}}  
    ```
    로 나온다 — 라는 흐름입니다.
    

필요하면, ($\rho \neq 0$)인 일반 $H_0:\rho=\rho_0$ 에 대한 검정통계량(변형된 t 혹은 Fisher z 변환)도 유도 과정까지 같이 풀어줄게요.