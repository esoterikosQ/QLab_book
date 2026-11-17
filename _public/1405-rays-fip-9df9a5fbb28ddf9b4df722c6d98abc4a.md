# 가을의 투수를 찾아라 : 탬파베이 레이스 2026 포스트시즌 FIP

8주차 수업에서 소개한 FIP를 이용하여 정규시즌과 포스트시즌 투수의 FIP를 비교하는 R코드입니다.
2026년 포스트시즌에 진출하여 현재 ALCS 5차전까지 치른 템파베이 레이스의 투수 기록을 이용하여 정규시즌과 포스트시즌의 FIP를 비교합니다.

## 1. FIP 계산

[FIP(Fielding Independent Pitching)](https://library.fangraphs.com/pitching/fip/) 계산식은 아래와 같습니다.

$$
\mathrm{FIP}=\frac{13HR+3(BB+HBP)-2K}{IP}+C
$$

데이터를 호출하여 FIP를 구하기 위해서는 `C`가 필요합니다. `C`는 리그 평균 FIP가 평균자책점과 같은 척도가 되도록 맞추는 시즌별 상수로, `baseballr` 패키지의 `fg_guts()` 함수를 이용하여 조회할 수 있습니다.  2026년 상수값은 **`C = 3.100`**입니다. [FanGraphs의 시즌별 상수](https://www.fangraphs.com/tools/guts?type=cn), [baseballr의 `fg_guts()` 문서](https://billpetti.github.io/baseballr/reference/fg_guts.html)


## 2. 정규시즌과 포스트시즌 기록 가져오기

`baseballr::mlb_stats()`에서 레이스의 팀 ID는 `139`입니다.

아래에서는 반복 코드를 입력해야하는 부분을 `get_rays_pitching()` 이라는 명칭의 사용자 정의 함수로 묶어서 사용했습니다.

```{code-block} r
library(baseballr)
library(dplyr)

# 데이터 호출을 위해 필요한 문자값 정의
season <- 2026L
rays_id <- 139L

# 2026년 정규시즌 FIP 상수를 조회해 두 기간에 공통으로 사용
guts <- fg_guts()
fip_constant <- guts %>%
  filter(.data$season == .env$season) %>%
  pull(cFIP)

# 탬파베이 레이스 투수 기록을 가져오는 함수 정의 / game_type에 따라 정규시즌 또는 포스트시즌 기록을 가져옴
get_rays_pitching <- function(game_type, period) {
  raw <- mlb_stats(
    stat_type = "season",
    stat_group = "pitching",
    season = season,
    team_id = rays_id,
    sport_ids = 1L,
    game_type = game_type,
    player_pool = "All",
    limit = 1000L
  ) %>% filter(position_type == "Pitcher") %>%
    transmute(
      player_id,
      pitcher = player_full_name,
      period = period,
      outs,
      HR = home_runs,
      BB = base_on_balls,
      HBP = hit_by_pitch,
      K = strike_outs
    ) %>%
    filter(!is.na(outs), outs > 0) %>%
    mutate(
      IP = outs / 3,
      FIP = (13 * HR + 3 * (BB + HBP) - 2 * K) / IP + fip_constant # FIP 계산식
    ) %>%
    arrange(FIP, pitcher)
}

regular <- get_rays_pitching("R", "정규시즌")
postseason <- get_rays_pitching("P", "포스트시즌")
```

## 3. 투수의 기간별 FIP

정규시즌 전체 투수, 포스트시즌 전체 투수의 기록을 먼저 추출합니다. 

```{code-block} r
regular %>%
  transmute(pitcher, IP = round(IP, 2), HR, BB, HBP, K,
            FIP = round(FIP, 2)) %>%
  print(n = Inf)

postseason %>%
  transmute(pitcher, IP = round(IP, 2), HR, BB, HBP, K,
            FIP = round(FIP, 2)) %>%
  print(n = Inf)
```

`player_id`로 두 표를 `inner_join()`하면 정규시즌과 포스트시즌에 모두 기록을 가지고 있는 투수만 남길 수 있습니다.

```{code-block} r
# 같은 투수의 정규시즌과 포스트시즌 기록을 비교하는 데이터프레임 생성
comparison <- regular %>%
  select(player_id, pitcher, regular_ip = IP, regular_fip = FIP) %>%
  inner_join(
    postseason %>%
      select(player_id, postseason_ip = IP, postseason_fip = FIP),
    by = "player_id"
  ) %>%
  mutate(delta_fip = postseason_fip - regular_fip) %>%
  arrange(delta_fip)

# 투수별 비교 결과 확인
comparison %>%
  select(-player_id) %>%
  mutate(across(c(regular_ip, regular_fip, postseason_ip,
                  postseason_fip, delta_fip), ~ round(.x, 2))) %>%
  print(n = Inf, width = Inf)
```

위 코드를 실행하면 다음과 같은 표를 얻을 수 있습니다.

| 투수 | 정규시즌 IP | 정규시즌 FIP | 포스트시즌 IP | 포스트시즌 FIP | 차이 |
| --- | ---: | ---: | ---: | ---: | ---: |
| Steven Matz | 80.33 | 5.02 | 2.00 | 1.10 | -3.92 |
| Tyler Wells | 18.00 | 3.27 | 2.67 | -0.65 | -3.92 |
| Nick Martinez | 180.00 | 3.96 | 9.00 | 2.77 | -1.19 |
| Bryan Baker | 62.33 | 3.07 | 6.00 | 2.10 | -0.97 |
| Drew Rasmussen | 172.00 | 2.82 | 21.00 | 2.58 | -0.24 |
| Ian Seymour | 132.67 | 4.09 | 7.33 | 3.92 | -0.18 |
| Cam Booser | 41.00 | 2.93 | 3.00 | 2.77 | -0.16 |
| Freddy Peralta | 55.33 | 3.93 | 11.33 | 3.98 | 0.05 |
| Kevin Kelly | 73.67 | 3.02 | 2.00 | 3.60 | 0.58 |
| Cole Sulser | 56.33 | 3.63 | 0.67 | 4.60 | 0.97 |
| Griffin Jax | 112.33 | 3.76 | 6.00 | 4.77 | 1.01 |


## 4. 팀 합산 FIP

FIP 공식은 선수 단위가 아니라 팀 단위로도 계산할 수 있습니다.

```{code-block} r
team_comparison <- bind_rows(regular, postseason) %>%
  group_by(period) %>%
  summarise(
    IP = sum(outs) / 3,
    HR = sum(HR), BB = sum(BB), HBP = sum(HBP), K = sum(K),
    FIP = (13 * HR + 3 * (BB + HBP) - 2 * K) / IP + fip_constant,
    .groups = "drop"
  ) %>%
  mutate(period = factor(period, levels = c("정규시즌", "포스트시즌"))) %>%
  arrange(period)

team_comparison %>%
  mutate(IP = round(IP, 2), FIP = round(FIP, 2)) %>%
  print()
```

코드를 실행하면 다음과 같은 표를 얻을 수 있습니다. 정규시즌 투수진의 FIP는 **4.03**, 포스트시즌 누적 FIP는 **3.00**로, 포스트시즌에서 투수들의 성적이 매우 뛰어났다고 평가할 수 있습니다.

| 기간 | IP | HR | BB | HBP | K | FIP |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 2026 정규시즌 | 1438.00 | 200 | 408 | 52 | 1322 | 4.03 |
| 2026 포스트시즌 누적 | 71.00 | 6 | 18 | 1 | 71 | 3.00 |


## 5. IP 대비 FIP 차이 산점도

포스트시즌의 선수 FIP는 IP가 많아질수록 정규시즌 FIP에 가까워질 가능성이 높습니다. 앞서 진행한 투수별 FIP를 시각화해보겠습니다.

- **x축:** 정규시즌 투구 이닝(`regular_ip`)
- **y축:** 포스트시즌 FIP − 정규시즌 FIP(`delta_fip`)
- **점의 크기:** 포스트시즌 투구 이닝(`postseason_ip`)
- **점의 색:** FIP 차이가 음수면 파란색, 양수면 주황색

```{code-block} r
library(ggplot2)

fip_scatter <- ggplot(
  comparison,
  aes(x = regular_ip, y = delta_fip)
) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  geom_point(aes(size = postseason_ip, color = delta_fip), alpha = 0.85) +
  geom_text(
    aes(label = pitcher),
    nudge_x = 3, hjust = 0, size = 3, color = "grey20"
  ) +
  scale_color_gradient2(
    low = "#2166ac", mid = "grey75", high = "#d95f02", midpoint = 0
  ) +
  scale_size_area(max_size = 9) +
  scale_x_continuous(expand = expansion(mult = c(0.05, 0.30))) +
  scale_y_continuous(expand = expansion(mult = 0.10)) +
  labs(
    title = sprintf("%d Tampa Bay Rays: IP vs. FIP difference", season),
    subtitle = paste("Data retrieved:"),
    x = "Regular-season IP",
    y = "Postseason FIP - regular-season FIP",
    size = "Postseason IP",
    color = "FIP difference"
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

print(fip_scatter)
```

코드를 실행하면 아래와 같은 그림을 얻을 수 있습니다.

```{figure} assets/1405-IP-FIP.png
:name: IP-FIP-scatter
:width: 600px
:align: center

2026 Tampa Bay Rays 투수들의 정규시즌 대비 포스트시즌 IP vs. FIP 차이 산점도
```