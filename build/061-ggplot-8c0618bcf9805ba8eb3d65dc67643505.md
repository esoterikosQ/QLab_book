# 1.6.2. ggplot2 (R)

ggplot2는 "Grammar of Graphics"에 기반한 R의 강력한 시각화 패키지입니다.

## 1.6.2.1. 기본 구조

```r
library(ggplot2)

# 기본 템플릿
ggplot(data = <DATA>) +
    <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# 예제
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point()
```

## 1.6.2.2. 산점도

```r
# 기본 산점도
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    labs(title = "Weight vs MPG", x = "Weight (1000 lbs)", y = "Miles per Gallon")

# 색상과 크기 매핑
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl), size = hp)) +
    geom_point(alpha = 0.6) +
    theme_minimal()

# 추세선 추가
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    geom_smooth(method = "lm", se = TRUE) +
    theme_bw()
```

## 1.6.2.3. 막대 차트

```r
# 카운트 막대 차트
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar() +
    labs(x = "Cylinders", y = "Count")

# 그룹별 막대 차트
ggplot(mtcars, aes(x = factor(cyl), fill = factor(gear))) +
    geom_bar(position = "dodge") +
    scale_fill_brewer(palette = "Set2")

# 수평 막대 차트
ggplot(mtcars, aes(x = reorder(rownames(mtcars), mpg), y = mpg)) +
    geom_col() +
    coord_flip() +
    labs(x = "Car Model", y = "MPG")
```

## 1.6.2.4. 히스토그램과 밀도 플롯

```r
# 히스토그램
ggplot(iris, aes(x = Sepal.Length)) +
    geom_histogram(bins = 30, fill = "steelblue", color = "white") +
    theme_minimal()

# 밀도 플롯
ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
    geom_density(alpha = 0.5) +
    theme_minimal()

# 박스플롯
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
    geom_boxplot() +
    theme_classic()
```

## 1.6.2.5. Facet (면 분할)

```r
# 행으로 분할
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_wrap(~ cyl)

# 행과 열로 분할
ggplot(mtcars, aes(x = wt, y = mpg)) +
    geom_point() +
    facet_grid(cyl ~ gear)
```

## 1.6.2.6. 테마와 스타일

```r
library(ggthemes)

# 내장 테마
p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
p + theme_minimal()
p + theme_classic()
p + theme_bw()

# 확장 테마
p + theme_economist()
p + theme_fivethirtyeight()
```

## 1.6.2.7. 저장

```r
# 기본 저장
ggsave("plot.png", width = 8, height = 6, dpi = 300)

# 특정 플롯 저장
p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
ggsave("scatter.pdf", plot = p, width = 10, height = 8)
```
