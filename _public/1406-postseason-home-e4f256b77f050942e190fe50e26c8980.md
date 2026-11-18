---
title: 포스트시즌에서 홈런을 치면 기대승률보다 더 많이 이길까?
description: 2015~2025 MLB 포스트시즌의 경기별 홈런과 팀별 피타고리안 승률을 비교하는 R 실습
---

# 포스트시즌에서 홈런을 치면 기대승률보다 더 많이 이길까?

2015~2025년 메이저리그 포스트시즌에서 **해당 경기에서 홈런을 1개 이상 친 팀의 실제 승률이, 그 팀의 해당 연도 포스트시즌 전체 득점·실점으로 계산한 피타고리안 승률보다 높은지** 검정한다.

기존 실습과 같이 `baseballr`로 FanGraphs의 날짜별 팀 타격·투수 기록을 수집하고, 피타고리안 승률 계산, 단측 가설검정, 민감도 분석, 그래프 작성을 차례로 수행한다. 아래 R 코드 블록을 위에서부터 실행하거나 [전체 R 스크립트](examples/mlb_postseason_hr/analysis.R)를 실행하면 된다. 작업 디렉터리는 이 문서와 `myst.yml`이 있는 Book 프로젝트 최상위 폴더로 설정한다.

## 1. 분석 질문과 자료의 단위

| 항목 | 정의 |
| --- | --- |
| 기간 | 2015~2025년, 양 끝 연도 포함 |
| 포함 경기 | 와일드카드, 디비전시리즈, 챔피언십시리즈, 월드시리즈의 실제 종료 경기 |
| 관측 단위 | 팀-경기: 날짜별 팀 타격·투수 기록을 연결한 한 팀의 한 경기 |
| 홈런을 친 팀 | 그 경기에서 팀 홈런이 1개 이상인 팀 |
| 기준승률 | 해당 팀·해당 연도의 포스트시즌 **모든 경기** 득점·실점으로 계산 |
| 주검정 단위 | 같은 연도에 속한 관측을 묶어 만든 연도별 승률 차이, 총 11개 |

양 팀 모두 홈런을 쳤으면 양 팀을 모두 홈런 집단에 포함한다. 홈런을 더 많이 친 팀만 선택하는 분석과는 질문이 다르다. 2020년도 포함하며, 제외했을 때의 결과는 민감도 분석에서 확인한다.

```{important}
여기서 “포스트시즌 전체 기록”은 **팀별·연도별 모든 라운드 기록**을 뜻한다. 홈런을 친 경기만 모아서 기준승률을 계산하지 않는다.

모든 구단의 득점과 실점을 한꺼번에 합치면 전체 득점 = 전체 실점이므로 피타고리안 승률이 항상 0.5가 된다. 팀별 기준승률을 먼저 구한 뒤, 홈런 경기에서 해당 팀이 등장한 횟수에 맞추어 평균해야 한다.
```

## 2. 피타고리안 승률과 가설

팀 $t$의 연도 $y$ 포스트시즌 총득점을 $RS_{ty}$, 총실점을 $RA_{ty}$라고 하자. 기준승률은 다음과 같다. 주분석은 지수 $\gamma=2$로 정하고, $1.83$을 보조적으로 확인한다. [MLB의 피타고리안 승률 정의](https://www.mlb.com/glossary/advanced-stats/pythagorean-winning-percentage)

$$
\widehat p_{ty}=
\frac{RS_{ty}^{\gamma}}{RS_{ty}^{\gamma}+RA_{ty}^{\gamma}}.
$$

팀-경기 $i$의 승리 여부를 $W_i\in\{0,1\}$, 해당 팀·연도의 기준승률을 $\widehat p_i$라고 하면,

$$
e_i=W_i-\widehat p_i
$$

는 그 팀-경기의 기준 대비 차이이다. 연도 $y$에서 홈런을 친 팀-경기 집합을 $\mathcal H_y$, 그 개수를 $n_y$라고 할 때,

$$
D_y=
\underbrace{\frac{1}{n_y}\sum_{i\in\mathcal H_y}W_i}_{\text{홈런 경기 실제 승률}}
-
\underbrace{\frac{1}{n_y}\sum_{i\in\mathcal H_y}\widehat p_i}_{\text{같은 관측들의 평균 기준승률}}
=\frac{1}{n_y}\sum_{i\in\mathcal H_y}e_i.
$$

주검정은 **연도마다 같은 가중치를 주었을 때의 평균 차이** $\mu_D$에 대한 단측 검정이다.

$$
H_0:\mu_D\leq0,\qquad H_1:\mu_D>0.
$$

같은 경기의 양 팀은 한 팀이 이기면 다른 팀이 지며, 같은 팀이 여러 경기에 반복 출전한다. 따라서 모든 팀-경기를 독립 표본으로 넣은 단순 이항검정이나 t 검정을 사용하지 않는다. 연도별로 묶은 $D_y$ 11개에 일표본 t 검정을 적용한다. 연도별 실제 승률과 기준승률의 대응표본 t 검정과 같은 계산이다.

```{note}
이 검정은 시즌 사이의 근사적 독립성과 연도별 차이의 평균에 대한 t 근사를 가정한다. 11개 시즌은 작은 표본이며, 같은 구단이 여러 해 출전하므로 시즌 간 독립성이 완벽하게 보장되지는 않는다. 2015~2025 기록 자체의 차이는 기술통계이고, p값은 이 시즌들을 비교 가능한 시즌 모집단의 관측으로 보는 모형 아래에서 해석한다.
```

## 3. 기존 패키지로 실행

앞선 실습에서 사용한 **`baseballr`, `dplyr`, `ggplot2`만 호출**한다. 추가 패키지 설치 명령은 필요하지 않다. `lapply()`와 `saveRDS()` 등은 R 기본 함수이고, 가설검정은 R 기본 제공 `stats::t.test()`를 사용한다.

RStudio에서 코드 블록을 순서대로 실행하거나, Book 프로젝트 최상위 폴더에서 다음과 같이 전체 스크립트를 실행한다. MyST 문서는 `{code-block} r` 형식으로 작성했으므로 코드 표시를 위해 Jupyter/R 커널을 새로 설치할 필요가 없다.

```{code-block} bash
Rscript examples/mlb_postseason_hr/analysis.R
```

첫 실행에서는 날짜별로 FanGraphs에 조회하므로 시간이 걸린다. 응답은 `examples/mlb_postseason_hr/cache_fangraphs/`에 RDS 형식으로 저장하며, 다음 실행에서는 이 캐시를 재사용한다. 조회 실패로 합계 대조가 중단되거나 공식 기록 정정을 반영하려면 해당 캐시를 삭제한 뒤 다시 실행한다.

```{code-block} r
library(baseballr)
library(dplyr)
library(ggplot2)

years <- 2015:2025
alpha <- 0.05
analysis_dir <- file.path("examples", "mlb_postseason_hr")
cache_dir <- file.path(analysis_dir, "cache_fangraphs")
output_dir <- file.path(analysis_dir, "results_fangraphs")
dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create("assets", showWarnings = FALSE)
```

## 4. baseballr로 FanGraphs 팀 기록 가져오기

팀 타격 기록은 [`fg_team_batter()`](https://billpetti.github.io/baseballr/reference/fg_team_batter.html), 팀 투수 기록은 [`fg_pitcher_leaders()`](https://billpetti.github.io/baseballr/reference/fg_pitcher_leaders.html)에 `team = "0,ts"`를 지정하여 가져온다. 투수 함수의 반환값도 이 옵션에서는 팀 단위이다. 설치된 `baseballr` 2.0.0에서 이 호출 방식을 확인했다.

조회에는 다음 옵션을 공통으로 사용한다.

| 옵션 | 의미 |
| --- | --- |
| `postseason = TRUE` | 포스트시즌 기록 선택 |
| `qual = "0"` | 규정 타석·이닝 제한 없이 포함 |
| `team = "0,ts"` | 팀 단위 집계 |
| `month = "1000"` | 사용자 지정 날짜 범위 적용 |
| `startdate`, `enddate` | 일별 조회는 같은 날짜, 시즌 합계는 해당 연도 1월 1일~12월 31일 |
| `ind = "0"` | 지정한 기간 내 기록을 집계 |

**날짜 범위를 생략하지 않는다.** 현재 조회에서 날짜 없는 포스트시즌 팀 합계가 날짜 지정 조회와 달라지는 사례를 확인했으므로, 시즌 합계에도 연간 날짜 범위를 명시한다. 일별 합계를 별도로 대조하여 오류나 누락이 있으면 검정 전에 중단한다.

팀 타격의 `R`은 득점, 팀 투수의 `R`은 실점이며 **`ER`(자책점)을 실점으로 사용하지 않는다.** 타격·투수 자료의 `G`는 선수 출전 기록이 합산된 값일 수 있으므로 팀 경기 수에는 `TG`를 사용한다. 승패는 팀 투수 자료의 `W`, `L`을 사용하고 `RS > RA`와 일치하는지도 확인한다. 두 표는 같은 날짜의 **FanGraphs `teamid`**로 연결한다.

```{code-block} r
# baseballr만 이용한다. FanGraphs 팀 ID는 MLB 팀 ID와 다르다.
get_fg <- function(year, start, end, kind = c("bat", "pit")) {
  kind <- match.arg(kind)
  cache_file <- file.path(cache_dir, paste0(kind, "_", start, "_", end, ".rds"))
  if (file.exists(cache_file)) return(readRDS(cache_file)$data)
  message("FanGraphs: ", kind, " ", start, " ~ ", end)
  Sys.sleep(0.2)
  args <- list(startseason = as.character(year), endseason = as.character(year),
               startdate = as.character(start), enddate = as.character(end),
               month = "1000", postseason = TRUE, qual = "0", ind = "0",
               team = "0,ts", type = "8", pageitems = "1000")
  # 투수 함수도 team="0,ts"로 조회하면 팀 단위 기록을 반환한다.
  fun <- if (kind == "bat") baseballr::fg_team_batter else baseballr::fg_pitcher_leaders
  x <- suppressMessages(do.call(fun, args))
  # NULL은 휴식일 또는 조회 실패 후보이다. 시즌 합계 대조를 통과해야 사용한다.
  saveRDS(list(data = x, retrieved_at = Sys.time(), query = args), cache_file)
  x
}

check_columns <- function(x, columns, label) {
  if (is.null(x) || !is.data.frame(x) || !nrow(x)) stop(label, ": 자료가 없습니다.")
  missing <- setdiff(columns, names(x))
  if (length(missing)) stop(label, ": 누락된 열: ", paste(missing, collapse = ", "))
  for (name in setdiff(columns, "team_name")) {
    if (!is.numeric(x[[name]]) || anyNA(x[[name]]) || any(!is.finite(x[[name]]))) {
      stop(label, ": 숫자/결측 오류: ", name)
    }
  }
  if (anyDuplicated(x$teamid)) stop(label, ": 팀별 한 행이 아닙니다.")
}

join_fg <- function(bat, pit, label) {
  check_columns(bat, c("teamid", "team_name", "TG", "R", "HR"), label)
  check_columns(pit, c("teamid", "team_name", "TG", "W", "L", "R"), label)
  if (!setequal(bat$teamid, pit$teamid)) stop(label, ": 타격·투수 팀 목록 불일치")
  x <- left_join(
    bat |> transmute(team_id = teamid, team = team_name, G = TG, RS = R, HR),
    pit |> transmute(team_id = teamid, pit_G = TG, W, L, RA = R),
    by = "team_id"
  )
  stopifnot(!anyNA(x), all(x$G == x$pit_G), all(x$G == x$W + x$L),
            all(x$HR >= 0 & x$HR == floor(x$HR)), all(x$HR <= x$RS))
  select(x, -pit_G)
}

get_year <- function(year) {
  # 연간 날짜 범위를 명시하고 포스트시즌만 선택한다. 날짜 지정을 생략하지 않는다.
  start <- as.Date(paste0(year, "-01-01"))
  end <- as.Date(paste0(year, "-12-31"))
  full <- join_fg(get_fg(year, start, end, "bat"),
                  get_fg(year, start, end, "pit"), paste0(year, " season"))
  # 이 범위 밖의 경기가 있으면 아래 시즌 합계 대조에서 중단한다.
  dates <- seq(as.Date(paste0(year, "-09-25")),
               as.Date(paste0(year, "-11-08")), by = "day")
  rows <- lapply(as.character(dates), function(day) {
    bat <- get_fg(year, day, day, "bat")
    if (is.null(bat) || !nrow(bat)) return(NULL)
    pit <- get_fg(year, day, day, "pit")
    x <- join_fg(bat, pit, day)
    if (any(x$G != 1)) stop(day, ": 팀별 1경기가 아닙니다. 경기 구분이 필요합니다.")
    stopifnot(all(x$W %in% 0:1), all(x$W == as.integer(x$RS > x$RA)),
              sum(x$RS) == sum(x$RA), sum(x$W) * 2 == nrow(x))
    mutate(x, season = year, date = as.Date(day), win = as.integer(W), hit_hr = HR >= 1)
  })
  daily <- bind_rows(rows)
  if (!nrow(daily)) stop(year, ": 일별 기록을 수집하지 못했습니다.")
  # 휴식일과 조회 실패를 혼동하여 경기를 누락하지 않도록 모든 팀의 합계를 대조한다.
  annual <- daily |> group_by(team_id) |>
    summarise(G = n(), W = sum(W), L = sum(L), RS = sum(RS), RA = sum(RA),
              HR = sum(HR), .groups = "drop")
  if (!setequal(full$team_id, annual$team_id)) stop(year, ": 시즌·일별 팀 목록 불일치")
  annual <- annual[match(full$team_id, annual$team_id), ]
  for (name in c("G", "W", "L", "RS", "RA", "HR")) {
    if (any(full[[name]] != annual[[name]])) {
      stop(year, ": 시즌 합계와 일별 합계 불일치 (", name,
           "). 날짜 범위 또는 캐시를 확인하세요. 검정은 실행하지 않습니다.")
    }
  }
  list(daily = daily, full = mutate(full, season = year))
}
```

## 5. 일별 기록과 시즌 전체 합계 대조

날짜별 조회 구간은 각 연도 9월 25일~11월 8일이다. 이 구간의 일별 기록을 합친 뒤 **해당 연도 전체 날짜로 조회한 포스트시즌 합계**와 대조한다. 조회 구간 밖에 경기가 있거나 중간 날짜의 조회가 실패하면 팀별 경기 수·승패·득점·실점·홈런 합계가 맞지 않아 중단한다.

경기가 없는 날짜와 조회 실패가 모두 빈 반환값으로 나타날 수 있으므로, 빈 날짜만 보고 “휴식일”로 확정하지 않는다. 모든 팀의 `G`, `W`, `L`, `RS`, `RA`, `HR` 대조를 통과한 자료만 분석한다. 홈런이 누락된 행을 0으로 바꾸지 않으며, 같은 팀이 하루 두 경기를 치른 집계도 그대로 한 경기로 취급하지 않는다.

```{code-block} r
raw_years <- lapply(years, get_year)
team_games <- bind_rows(lapply(raw_years, function(x) x$daily)) |>
  select(season, date, team_id, team, RS, RA, HR, win, hit_hr) |>
  arrange(season, date, team_id)
full_totals <- bind_rows(lapply(raw_years, function(x) x$full))
stopifnot(!anyNA(team_games),
          !anyDuplicated(team_games[c("date", "team_id")]),
          setequal(unique(team_games$season), years))
coverage <- team_games |> group_by(season) |>
  summarise(games = n() / 2, team_games = n(), .groups = "drop")
print(coverage, n = Inf)
write.csv(coverage, file.path(output_dir, "coverage.csv"), row.names = FALSE)
```

## 6. 팀별 포스트시즌 전체 기록으로 기준승률 계산

**먼저 모든 경기로 기준승률을 구한다.** 그 다음에 홈런을 친 경기를 골라낸다. 예를 들어 어떤 팀의 기준승률이 0.60이고 그 팀이 홈런을 친 경기에 8번 등장하면, 비교 기준에도 0.60이 8번 반영된다. 따라서 각 팀의 기준승률을 단순히 한 번씩 평균하는 것과 다르다.

```{code-block} r
# HR=0 경기를 포함한 각 팀·각 연도의 포스트시즌 전체 득실점이다.
# 일별 합산과 일치함을 확인한 FanGraphs 시즌 합계로 기준승률을 계산한다.
team_totals <- full_totals |>
  transmute(season, team_id, team, G, W, RS_total = RS, RA_total = RA)

make_analysis <- function(exponent = 2) {
  baseline <- team_totals |>
    mutate(pyth = RS_total^exponent /
             (RS_total^exponent + RA_total^exponent))
  stopifnot(all(is.finite(baseline$pyth)))
  team_games |>
    left_join(baseline |> select(season, team_id, pyth),
              by = c("season", "team_id")) |>
    mutate(excess = win - pyth)
}
analysis <- make_analysis(exponent = 2)
```

## 7. 홈런 여부와 연도별 승률 비교

`group_summary`는 11년 전체에서 각 팀-경기에 같은 가중치를 준 기술통계이다. `year_summary`는 각 연도의 홈런 경기 승률, 평균 기준승률과 두 값의 차이를 보여준다. 주검정에는 두 번째 표의 연도별 차이를 사용한다.

```{code-block} r
group_summary <- analysis |>
  mutate(hr_group = if_else(hit_hr, "HR >= 1", "HR = 0")) |>
  group_by(hr_group) |>
  summarise(team_games = n(), wins = sum(win),
            observed = mean(win), expected = mean(pyth),
            difference = mean(excess), .groups = "drop")
print(group_summary)

# 같은 시즌 안에서는 HR을 친 팀-경기 한 건마다 같은 가중치를 준다.
summarise_years <- function(x) {
  x |> filter(hit_hr) |> group_by(season) |>
    summarise(n_hr = n(), wins = sum(win),
              observed = mean(win), expected = mean(pyth),
              difference = mean(excess), residual_sum = sum(excess),
              .groups = "drop")
}
year_summary <- summarise_years(analysis)
stopifnot(nrow(year_summary) == length(years),
          all(year_summary$n_hr > 0), !anyNA(year_summary))
print(year_summary, n = Inf)
```

## 8. 주검정: 연도별 평균 차이의 단측 t 검정

11개 연도의 차이를 $D_1,\ldots,D_{11}$이라고 할 때 검정통계량은 다음과 같다.

$$
T=\frac{\overline D}{s_D/\sqrt{11}},\qquad df=10.
$$

[`t.test()`의 `alternative = "greater"`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html)는 평균 차이가 0보다 큰지를 검정한다. 95% 단측 신뢰구간은 $[L,\infty)$ 형태이며, 코드에서는 하한 $L$을 저장한다. 승률 차이에 100을 곱하면 **퍼센트포인트**가 된다.

```{code-block} r
# 주검정: 11개 시즌에 동일 가중치를 주는 단측 일표본 t 검정.
# H0: E(D_year) <= 0; H1: E(D_year) > 0.
primary <- t.test(year_summary$difference, mu = 0,
                  alternative = "greater", conf.level = 1 - alpha)
print(primary)
primary_result <- tibble(
  estimand = "Equal-season mean difference",
  seasons = nrow(year_summary),
  observed = mean(year_summary$observed),
  expected = mean(year_summary$expected),
  difference = mean(year_summary$difference),
  t = unname(primary$statistic), df = unname(primary$parameter),
  p_one_sided = primary$p.value,
  lower_95_one_sided = unname(primary$conf.int[1])
)
print(primary_result, width = Inf)
cat(sprintf("연도 동일 가중 평균 차이: %.2f 퍼센트포인트\n",
            100 * primary_result$difference))
cat(if (primary$p.value < alpha) {
  "귀무가설 기각: 가정 아래에서 홈런 경기 승률이 기준보다 높다는 근거가 있습니다.\n"
} else {
  "귀무가설 기각 못함: 기준보다 높다고 결론내릴 근거가 충분하지 않습니다.\n"
})
```

유의수준은 0.05로 미리 정한다. p값이 0.05 미만이면 가정 아래에서 홈런 경기의 평균 승률이 기준보다 높다는 근거로 해석한다. p값이 크면 “차이가 없다”가 아니라 “높다고 결론내릴 근거가 충분하지 않다”고 해석한다.

### FanGraphs 자료로 실행한 결과

2015~2025년 **440경기, 880개 팀-경기**를 수집했고, 모든 연도에서 일별 기록과 시즌 전체 기록의 합계가 일치했다. 홈런을 친 팀-경기는 **613개**, 승리는 **372회**이다.

| 가중 방식 | 홈런 경기 실제 승률 | 평균 기준승률 | 차이 | 단측 p값 |
| --- | ---: | ---: | ---: | ---: |
| 주분석: 연도별 동일 가중 | 60.92% | 52.72% | +8.21%p | 0.00001523 |
| 보조분석: 팀-경기별 동일 가중 | 60.69% | 52.66% | +8.02%p | 0.00000878 |

주검정의 $t=7.166$, 자유도는 10이고, 차이의 95% 단측 신뢰하한은 **+6.13%p**이다. 이 검정의 가정 아래에서 홈런 경기 승률이 기준보다 높다는 근거가 있다. 홈런의 인과효과를 추정한 결과는 아니다.

[주검정 결과](examples/mlb_postseason_hr/results_fangraphs/primary_test.csv), [연도별 집계](examples/mlb_postseason_hr/results_fangraphs/year_summary.csv), [민감도 분석](examples/mlb_postseason_hr/results_fangraphs/sensitivity.csv)에서 수치를 확인할 수 있다.

## 9. 민감도 분석과 가중치의 차이

전체 기간의 모든 홈런 팀-경기에 같은 가중치를 주는 차이는 다음과 같다.

$$
\widehat\Delta_G=
\frac{\sum_y n_yD_y}{\sum_y n_y}.
$$

이는 주검정의 연도 동일 가중 평균 $\overline D$와 다른 추정대상이다. 경기 수가 많은 시즌이 더 크게 반영된다. 보조 검정에서는 시즌을 군집으로 두고 다음 표준오차를 사용한다. $K$는 시즌 수이다.

$$
\widehat{SE}(\widehat\Delta_G)=
\frac{\sqrt{\dfrac{K}{K-1}\sum_y
\{n_y(D_y-\widehat\Delta_G)\}^2}}{\sum_y n_y}.
$$

이 표준오차와 자유도 $K-1$의 t 분포를 이용한 p값은 **소수 군집에서의 근사치**이다. 주검정과 함께 방향·크기가 일관되는지 확인하는 용도로 사용한다.

추가로 지수를 1.83으로 바꾸고, 2020년을 제외해 본다. 결과를 본 뒤 유의한 조건만 골라 결론내리지 않는다.

```{code-block} r
# 보조 분석: 모든 HR 팀-경기에 동일 가중치. 연도별 군집 표준오차의 근사 t 검정.
game_weighted_test <- function(by_year) {
  K <- nrow(by_year)
  delta <- sum(by_year$residual_sum) / sum(by_year$n_hr)
  score <- by_year$residual_sum - delta * by_year$n_hr
  se <- sqrt(K / (K - 1) * sum(score^2)) / sum(by_year$n_hr)
  stopifnot(K > 1, is.finite(se), se > 0)
  tibble(
    estimand = "Equal-team-game mean difference; season-cluster SE",
    difference = delta, se = se, t = delta / se, df = K - 1,
    p_one_sided = pt(delta / se, df = K - 1, lower.tail = FALSE),
    lower_95_one_sided = delta - qt(1 - alpha, K - 1) * se
  )
}
weighted_result <- game_weighted_test(year_summary)
print(weighted_result, width = Inf)

# 지수와 특수 시즌에 대한 민감도. 주검정은 사전에 지수 2/전체 11시즌으로 고정한다.
run_sensitivity <- function(exponent, exclude_2020) {
  tab <- summarise_years(make_analysis(exponent))
  if (exclude_2020) tab <- filter(tab, season != 2020)
  test <- t.test(tab$difference, mu = 0, alternative = "greater")
  tibble(exponent = exponent, exclude_2020 = exclude_2020,
         seasons = nrow(tab), difference = mean(tab$difference),
         p_one_sided = test$p.value)
}
sensitivity <- bind_rows(
  run_sensitivity(2, FALSE), run_sensitivity(1.83, FALSE),
  run_sensitivity(2, TRUE), run_sensitivity(1.83, TRUE)
)
print(sensitivity)
```

## 10. 시각화와 결과 저장

막대가 0 위에 있으면 그 연도의 홈런 경기 승률이 평균 기준승률보다 높다는 뜻이다. 그래프에는 연도별 점추정치를 표시한다. 각 연도 자체의 유의성을 나타내는 그래프는 아니다.

```{code-block} r
plot <- ggplot(year_summary, aes(x = factor(season), y = 100 * difference)) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_col(fill = "#155e83", width = 0.7) +
  geom_text(aes(label = sprintf("%+.1f", 100 * difference)),
            vjust = -0.4, size = 3.5) +
  scale_y_continuous(expand = expansion(mult = c(0.08, 0.15))) +
  labs(title = "MLB postseason: HR-game wins above Pythagorean benchmark",
       subtitle = "2015-2025 | benchmark: each team's full postseason | exponent = 2",
       x = "Season", y = "Observed minus expected win rate (percentage points)",
       caption = "Source: FanGraphs via baseballr") +
  theme_minimal(base_size = 11)
if (interactive()) print(plot)
ggsave("assets/1406-postseason-homeruns-fangraphs.png", plot, width = 10, height = 5, dpi = 160)

tables <- list(team_games = analysis, team_totals = team_totals,
               group_summary = group_summary, year_summary = year_summary,
               primary_test = primary_result, game_weighted_test = weighted_result,
               sensitivity = sensitivity)
for (name in names(tables)) {
  write.csv(tables[[name]], file.path(output_dir, paste0(name, ".csv")),
            row.names = FALSE)
}
writeLines(capture.output(sessionInfo()), file.path(output_dir, "sessionInfo.txt"))
manifest <- list(
  analysis_run_utc = format(Sys.time(), tz = "UTC", usetz = TRUE),
  source = "FanGraphs via baseballr", baseballr_version = as.character(packageVersion("baseballr")),
  years = years, postseason = TRUE, month = "1000", exponent = 2,
  baseline = "Each team's full postseason RS and RA; verified against daily totals",
  games = nrow(team_games) / 2, team_games = nrow(team_games),
  hr_team_games = sum(team_games$hit_hr),
  cache_mtime_range_utc = format(range(file.info(list.files(cache_dir, full.names = TRUE))$mtime),
                                tz = "UTC", usetz = TRUE)
)
# base R만으로 실행 조건을 기록한다.
dput(manifest, file = file.path(output_dir, "manifest.txt"))
```

```{figure} assets/1406-postseason-homeruns-fangraphs.png
:name: postseason-hr-excess
:width: 900px
:align: center

연도별 홈런 경기 실제 승률과 평균 피타고리안 기준승률의 차이. 단위는 퍼센트포인트이다.
```

결과는 `examples/mlb_postseason_hr/results_fangraphs/`에 저장된다. `team_games.csv`는 FanGraphs 팀-경기 자료와 기준승률, `team_totals.csv`는 포스트시즌 전체 득실점, `year_summary.csv`는 주검정의 입력이다. `primary_test.csv`, `game_weighted_test.csv`, `sensitivity.csv`에는 검정 결과를 저장한다. `manifest.txt`와 `sessionInfo.txt`에는 자료 출처·실행 시점·캐시 파일 시점과 R 환경을 기록한다.

## 11. 해석 범위

이 분석은 **포스트시즌 전체 득실점에서 얻은 기준에 비해 홈런 경기의 승률이 얼마나 높은지**를 평가한다. 다음 사항을 함께 설명해야 한다.

- 홈런 여부는 경기가 끝난 뒤 정해지는 관측 변수이다. 유의한 결과가 나와도 “홈런을 치게 하면 승률이 그만큼 오른다”는 인과효과를 뜻하지 않는다.
- 홈런은 득점에 포함되고, 기준승률에도 분석 대상 경기의 득점·실점이 포함된다. 따라서 기준승률은 고정된 참확률이나 경기 전 예측확률이 아니다. 검정은 이 기준으로 정의한 연도별 차이에 관한 것이다.
- 피타고리안 승률은 상대 팀과 구장 조건을 반영한 개별 맞대결 확률이 아니다. 상대 전력·타선·투수·홈구장·연장전·시리즈 길이 등의 차이를 모두 통제한 분석으로 해석할 수 없다.
- 기간 중 포스트시즌 운영 방식과 진출 팀, 경기 수가 다르다. 그래서 주분석에서는 각 연도에 같은 가중치를 주며, 경기 동일 가중 결과와 2020년 제외 결과를 함께 제시한다.

“홈런을 많이 친 팀이 적게 친 팀보다 강한가”, “정규시즌 기록으로 예측한 승률을 넘는가”, “2015~2025 누적 구단 기록을 기준으로 하는가”는 각각 다른 질문이다. 여기서는 **경기별 홈런 여부와 같은 팀·같은 해의 전체 포스트시즌 기준**을 비교한다.
