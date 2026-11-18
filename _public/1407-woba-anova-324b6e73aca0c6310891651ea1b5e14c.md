---
title: 핫코너가 말아주는 분산분석
---

# 핫코너는 존재하는가?

코너 야수가 센터라인 야수보다 과연 더 높은 공격력을 가지고 있을까? 13주차에 소개한 내용을 R실습으로 구성했습니다.

2026년 메이저리그 규정타석(502타석)을 채운 타자를 대상으로 주 포지션별로 wOBA를 비교합니다.

## 1. 데이터 개요 & 데이터 가져오기

FanGraphs에서 규정타석을 채운 타자들의 wOBA 기록을 `baseballr::fg_batter_leaders()`로 가져오고(`qualified`), 멀티 포지션을 소화한 선수들의 주 포지션을 결정하기 위해 `baseballr::mlb_stats()`로 포지션별 선수의 타격 기록을 가져옵니다(`splits`).

```{code-block} r
# 설치한 라이브러리 로딩
library(baseballr)
library(dplyr)

# 타격 순위 리더보드에서 wOBA 가져오기
qualified <- fg_batter_leaders(
  startseason = 2026, endseason = 2026, lg = "all", qual = "502", ind = "0"
) %>%
  select(player_id = xMLBAMID, player = PlayerName, PA, wOBA)

# 멀티포지션 출장 타석 수 가져오기
position_codes <- c(
  p2 = "C", p3 = "1B", p4 = "2B", p5 = "3B", p6 = "SS",
  p7 = "LF", p8 = "CF", p9 = "RF", pD = "DH"
)

splits <- mlb_stats(
  stat_type = "statSplits", stat_group = "hitting", player_pool = "QUALIFIED",
  game_type = "R", season = 2026, sport_ids = 1,
  sit_codes = names(position_codes)
)
```

## 2. 데이터 정제 : 주 포지션 결정 및 wOBA와 결합

`splits`의 PA값을 기준으로 주표지션을 결정한 데이터 `primary_positions`를 생성합니다.

```{code-block} r
primary_positions <- splits %>%
  semi_join(qualified, by = "player_id") %>%
  filter(split_code %in% names(position_codes), plate_appearances > 0) %>%
  mutate(position = factor(
    unname(position_codes[split_code]), levels = unname(position_codes)
  )) %>%
  arrange(player_id, desc(plate_appearances), position) %>%
  distinct(player_id, .keep_all = TRUE) %>%
  select(player_id, position)
```
`qualified`와 `primary_positions`를 결합하여 각 선수의 주 포지션과 wOBA를 정리한 최종 데이터를 완성합니다.

```{code-block} r
players <- qualified %>%
  left_join(primary_positions, by = "player_id")
```

## 3. 데이터 탐색

`players`의 요약 통계를 확인합니다.

```{code-block} r
# 요약통계량 계산
position_summary <- players %>%
  group_by(position) %>%
  summarise(n = n(), mean_wOBA = mean(wOBA), sd_wOBA = sd(wOBA), .groups = "drop")

print(as.data.frame(position_summary), row.names = FALSE)

# 상자그림 확인
boxplot(wOBA ~ position, data = players, xlab = "Position", ylab = "wOBA")
```

## 4. 분산분석

포지션별 각 선수들의 wOBA 평균에 유의미한 차이가 있는지를 일원분산분석을 통해 검정합니다.

```{code-block} r
fit <- aov(wOBA ~ position, data = players)
anova_table <- summary(fit)
print(anova_table)
```

분산분석에서 효과를 보고자 하는 변수가 다수준인 경우, 유의확률을 과대평가하게 됩니다. 이를 보정하는 여러 방법이 있는데, 가장 엄격한 방법으로 알려진 튜키(Tukey) 사후비교를 통해 쌍별 비교 결과를 검정할 수 있습니다.

```{code-block} r
p_value <- anova_table[[1L]][["Pr(>F)"]][1L]
if (p_value < 0.05) {
  tukey <- as.data.frame(TukeyHSD(fit, "position")$position)
  print(tukey[tukey[["p adj"]] < 0.05, , drop = FALSE])
}
```

## 5. 번외 : 핫코너와 센터라인

이번에는 1루수·3루수·좌익수·우익수를 `hot_corner = 1`, 포수·2루수·유격수·중견수를 `hot_corner = 0`으로 묶어 두 집단의 wOBA를 비교해보겠습니다. 주 포지션이 지명타자(DH)인 선수는 제외합니다.

```{code-block} r
hot_corner_players <- players %>%
  filter(position != "DH") %>%
  mutate(hot_corner = factor(
    as.integer(position %in% c("1B", "3B", "LF", "RF")), levels = 0:1
  ))

hot_corner_summary <- hot_corner_players %>%
  group_by(hot_corner) %>%
  summarise(n = n(), mean_wOBA = mean(wOBA), sd_wOBA = sd(wOBA), .groups = "drop")
print(as.data.frame(hot_corner_summary), row.names = FALSE)

hot_corner_fit <- aov(wOBA ~ hot_corner, data = hot_corner_players)
print(summary(hot_corner_fit))
```

참고로, 일원분산분석에서 효과 변수가 이항 변수인 경우 분산분석은 등분산을 가정하는 이표본 양측 t검정과 동일한 결과를 가집니다.

```{code-block} r
hot_corner_test <- with(hot_corner_players, t.test(
  x = wOBA[hot_corner == "1"], y = wOBA[hot_corner == "0"],
  var.equal = TRUE, alternative = "two.sided"
))
print(hot_corner_test)
```

등분산 이표본 t 검정의 통계량과 두 집단 ANOVA의 통계량 사이에는 다음 같은 관계가 있습니다.

$$
t=\frac{\bar y_1-\bar y_0}{s_p\sqrt{1/n_1+1/n_0}},
\qquad
F=\frac{\dfrac{n_0n_1}{n_0+n_1}(\bar y_1-\bar y_0)^2}{s_p^2}=t^2.
$$

이때, t검정의 자유도는 $n_0+n_1-2=123$, ANOVA의 분자·분모 자유도는 각각 1과 123입니다.