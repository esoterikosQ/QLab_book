---
title: 포지션에 따라 평균 wOBA가 다를까?
description: 2026년 MLB 정규시즌 규정타석을 채운 타자의 wOBA를 비교하는 일원분산분석 R 실습
---

# 포지션에 따라 평균 wOBA가 다를까?

2026년 메이저리그 정규시즌에 규정타석을 채운 타자의 시즌 wOBA를 주 포지션별로 비교한다. wOBA(weighted on-base average)는 타격 결과에 득점 기여도에 따른 가중치를 부여한 지표이다. 양대 리그 합산 502타석 이상인 선수를 포함한다. 162경기 정규시즌의 규정타석은 경기당 3.1타석을 적용해 계산한다. [FanGraphs wOBA 설명](https://library.fangraphs.com/offense/woba/) · [MLB 규정타석 기준](https://www.mlb.com/glossary/standard-stats/rate-stats-qualifiers)

관측 단위는 선수 한 명이다. 선수마다 주 포지션 하나와 시즌 전체 wOBA 하나를 사용하며, 포지션별 평균을 계산할 때 선수에게 같은 가중치를 준다. RStudio에서 아래 R 코드 블록을 위에서부터 실행하면 된다. 데이터 조회에는 인터넷 연결이 필요하다.

## 1. FanGraphs에서 규정타석 타자의 wOBA 가져오기

`baseballr`의 `fg_batter_leaders()`로 두 리그를 합산한 시즌 타격 기록을 가져온다. MLB 공식 기록과 연결하기 위해 FanGraphs 응답의 MLBAM 선수 ID(`xMLBAMID`)를 남긴다. [2026년 FanGraphs 타격 리더보드](https://www.fangraphs.com/leaders/major-league?pos=all&stats=bat&lg=all&qual=y&type=8&season=2026&month=0&season1=2026&ind=0) · [`fg_batter_leaders()` 문서](https://billpetti.github.io/baseballr/reference/fg_batter_leaders.html)

```{code-block} r
# 패키지 설치가 필요한 경우 실행
# install.packages(c("baseballr", "dplyr"))
library(baseballr)
library(dplyr)

season <- 2026
min_pa <- round(3.1 * 162)
alpha <- 0.05

batting <- fg_batter_leaders(
  startseason = season, endseason = season, lg = "all",
  qual = as.character(min_pa), ind = "0"
)
if (is.null(batting) || nrow(batting) == 0L) {
  stop("FanGraphs 타격 데이터를 불러오지 못했습니다.")
}

qualified <- batting |>
  filter(PA >= min_pa) |>
  select(player_id = xMLBAMID, player = PlayerName, PA, wOBA)
stopifnot(
  nrow(qualified) > 0L,
  !anyNA(qualified$player_id),
  anyDuplicated(qualified$player_id) == 0L,
  all(is.finite(qualified$wOBA))
)
```

## 2. 포지션별 타석으로 주 포지션 정하기

여러 포지션에서 뛴 선수는 **가장 많은 타석을 기록한 포지션**에 배정한다. 비교할 집단은 포수(C), 1루수(1B), 2루수(2B), 3루수(3B), 유격수(SS), 좌익수(LF), 중견수(CF), 우익수(RF), 지명타자(DH)이다. 타석 수가 같으면 아래 코드에 나열된 순서에서 앞선 포지션을 선택한다. [`mlb_stats()` 문서](https://billpetti.github.io/baseballr/reference/mlb_stats.html) · [MLB 포지션별 타격 조건 코드](https://statsapi.mlb.com/api/v1/situationCodes)

```{code-block} r
position_codes <- c(
  p2 = "C", p3 = "1B", p4 = "2B", p5 = "3B", p6 = "SS",
  p7 = "LF", p8 = "CF", p9 = "RF", pD = "DH"
)
splits <- mlb_stats(
  stat_type = "statSplits", stat_group = "hitting", player_pool = "ALL",
  game_type = "R", season = season, sport_ids = 1,
  sit_codes = names(position_codes), limit = 10000
)
if (is.null(splits) || nrow(splits) == 0L) {
  stop("MLB 포지션별 타석 데이터를 불러오지 못했습니다.")
}
stopifnot(
  nrow(splits) == unique(splits$total_splits),
  anyDuplicated(splits[c("player_id", "split_code")]) == 0L
)

# 선수별로 타석이 많은 포지션부터 정렬한 뒤 첫 행을 선택한다.
primary_positions <- splits |>
  filter(split_code %in% names(position_codes), plate_appearances > 0) |>
  mutate(position = factor(
    unname(position_codes[split_code]), levels = unname(position_codes)
  )) |>
  arrange(player_id, desc(plate_appearances), position) |>
  distinct(player_id, .keep_all = TRUE) |>
  select(player_id, position)

players <- qualified |>
  left_join(primary_positions, by = "player_id")
stopifnot(!anyNA(players$position))
```

## 3. 포지션별 분포와 일원분산분석

포지션별 선수 수, 평균, 표준편차를 구하고 상자그림으로 분포를 비교한다.

```{code-block} r
position_summary <- players |>
  group_by(position) |>
  summarise(n = n(), mean_wOBA = mean(wOBA), sd_wOBA = sd(wOBA), .groups = "drop")
print(as.data.frame(position_summary), row.names = FALSE)

boxplot(wOBA ~ position, data = players, xlab = "Position", ylab = "wOBA")
```

귀무가설 $H_0$는 아홉 포지션의 평균 wOBA가 모두 같다는 것이다. 대립가설 $H_1$은 평균이 서로 다른 포지션이 적어도 한 쌍 있다는 것이다. 일원분산분석의 $F$ 통계량은 포지션 간 평균제곱을 포지션 내 평균제곱으로 나눈 값이다.

```{code-block} r
fit <- aov(wOBA ~ position, data = players)
anova_table <- summary(fit)
print(anova_table)

# 잔차 대 적합값 그래프와 정규 Q-Q 그래프
plot(fit, which = c(1, 2))
```

고전적 $F$ 검정은 관측 간 독립성, 집단 내 오차의 정규성, 집단 간 등분산성을 가정한다. 잔차 대 적합값 그래프에서 포지션에 따라 잔차의 퍼짐이 달라지는지, 정규 Q-Q 그래프에서 점들이 기준 직선을 대체로 따르는지 살핀다.

## 4. 결과와 Tukey 사후비교

2026년 11월 16일 조회 자료의 포지션별 요약은 다음과 같다.

| 포지션 | 선수 수 | 평균 wOBA | 표준편차 |
| --- | ---: | ---: | ---: |
| C | 8 | 0.3422 | 0.0252 |
| 1B | 21 | 0.3454 | 0.0280 |
| 2B | 19 | 0.3190 | 0.0223 |
| 3B | 15 | 0.3322 | 0.0266 |
| SS | 18 | 0.3219 | 0.0294 |
| LF | 17 | 0.3286 | 0.0275 |
| CF | 12 | 0.3311 | 0.0328 |
| RF | 15 | 0.3374 | 0.0250 |
| DH | 10 | 0.3519 | 0.0403 |

135명의 자료에서 $F(8,126)=2.205$, $p=0.0312$였다. 유의수준 0.05에서 모든 포지션의 평균이 같다는 귀무가설을 기각한다. 어느 쌍에서 평균 차이가 관찰되는지 살펴보려면 Tukey 사후비교로 다중비교를 보정한 p값을 확인한다.

```{code-block} r
p_value <- anova_table[[1L]][["Pr(>F)"]][1L]
if (p_value < alpha) {
  tukey <- as.data.frame(TukeyHSD(fit, "position")$position)
  print(tukey[tukey[["p adj"]] < alpha, , drop = FALSE])
}
```

이 자료에서 Tukey 보정 p값이 0.05 미만인 포지션 쌍은 없었다. 전체 $F$ 검정은 아홉 평균이 모두 같은지 한 번에 검정하며, Tukey 검정은 36개 쌍을 함께 고려해 각 차이를 평가한다. p값은 선수별 시즌 wOBA에 적용한 모형에 따른 값이며, 관찰된 평균 차이만으로 포지션의 인과효과를 추정할 수 없다.
