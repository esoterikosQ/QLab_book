# FanGraphs 데이터 수집 가이드: baseballr

R 환경에서 FanGraphs(팬그래프)의 세이버메트릭스 데이터와 리더보드를 손쉽게 불러오기 위해 가장 널리 사용되는 패키지는 **`baseballr`**입니다. 

이 패키지를 이용하면 팬그래프에서 제공하는 데이터를 데이터프레임(`tibble`) 형태로 데이터를 가져올 수 있습니다.

```{note}
FanGraphs는 공식적으로 public REST API를 단독 제공하지 않으며, `baseballr`의 `fg_*` 함수군은 팬그래프의 리더보드 데이터 요청 규격을 R 형식에 맞게 별도로 래핑하여 처리합니다. 따라서, 대량의 데이터를 수집할 때는 서버에 무리가 가지 않도록 요청을 보낼 때마다 일정 딜레이를 주는 것이 좋습니다.
```

---

## 1. baseballr 패키지 설치 및 실행

`baseballr`은 CRAN에 등록되어 있으므로 `install.packages()`로 즉시 설치할 수 있습니다. 콘솔창에 아래 명령어를 입력하고 실행하세요.

```{code-block} r
# CRAN 버전 설치
install.packages("baseballr")

# 데이터 편집 및 시각화용 패키지 설치
install.packages("dplyr")
install.packages("ggplot2")
```


---

## 2. 주요 데이터 수집 함수

`baseballr` 패키지에서 팬그래프 데이터와 관련된 주요 함수는 접두사 `fg_`로 시작합니다.

| 함수명 | 설명 |
| --- | --- |
| `fg_batter_leaders()` | 시즌별/기간별 타자 리더보드 데이터 수집 |
| `fg_pitcher_leaders()` | 시즌별/기간별 투수 리더보드 데이터 수집 |
| `fg_team_batter()` | 팀 단위 타격 통계 지표 수집 |
| `fg_team_pitcher()` | 팀 단위 투구 통계 지표 수집 |
| `fg_park()` | 구장별 파크팩터(Park Factor) 데이터 수집 |

---


## 3. 타자 및 투수 리더보드 수집 예제

다음은 특정 시즌의 규정타석/규정이닝을 충족한 선수들의 세이버메트릭스 지표(wOBA, wRC+, WAR, FIP 등)를 가져오는 기본 예제입니다.

새로운 R 코드 파일을 생성합니다. File -> New File -> R Script를 선택하세요.

스크립트 창에 아래 코드를 입력하고 실행하세요.

```{code-block} r
library(baseballr)
library(dplyr)

# 1. 2026 시즌 타자 리더보드 가져오기
batters_2026 <- fg_batter_leaders(
  startseason = "2026", # 검색을 시작하는 시즌
  endseason = "2026", # 검색을 종료하는 시즌
  qual = "y" # 규정 타석을 충족하는 선수만 검색
)

# 주요 지표 확인
batters_2026 %>%
  select(PlayerName, team_name, G, PA, HR, wOBA, wRC_plus, WAR) %>% # 선수이름, 소속팀, 출장경기 수, 타수, 홈련, wOBA, WRC+, WAR을 출력
  arrange(desc(WAR)) %>% # WAR 내림차순으로 정렬
  head(10) # 상위 10명만 표시

```

```{code-block} r
# 2. 2026 시즌 선발 투수 리더보드 가져오기
pitchers_2026 <- fg_pitcher_leaders(
  startseason = "2026",
  endseason = "2026",
  qual = "y" # 규정 이닝을 충족하는 선수만 검색
)

# 투수 핵심 세이버메트릭스 지표 확인
pitchers_2026 %>%
  select(PlayerName, team_name, IP, ERA, FIP, xFIP, `K_9`, `BB_9`, WAR) %>% # 선수이름, 소속팀, 출장 이닝, 방어율, FIP, xFIP, 9이닝당 삼진, 볼넷, WAR을 출력
  arrange(desc(WAR)) %>%
  head(10)

```

---

## 4. 데이터 활용 및 시각화 예시

위에서 가져온 데이터를 이용하여 산점도를 그리는 예시 코드입니다.

코드를 실행하면 오른쪽 하단의 파일창이 플롯창으로 자동으로 바뀌고 시각화 결과가 표시됩니다.

```{code-block} r
library(ggplot2)

# 타자의 삼진율(K%) 대비 볼넷율(BB%) 및 wRC+ 시각화
batters_2026 %>%
  ggplot(aes(x = BB_pct, y = K_pct, size = WAR, color = wRC_plus)) + # x축은 볼넷율, y축은 삼진율, 점의 크기는 WAR, 점 색깔은 WRC+
  geom_point(alpha = 0.7) + # 점의 크기를 지정
  scale_color_viridis_c() + # 색상은 지표의 크기에 따라 자동으로 배정
  theme_minimal() + # 시각화 스타일
  labs(
    title = "2026 MLB Batter Plate Discipline vs WAR",
    x = "Walk Rate (BB%)",
    y = "Strikeout Rate (K%)",
    color = "wRC+",
    size = "WAR" # 도표에 기재할 텍스트 작성
  )

```

```{tip}
`qual = "0"`으로 설정하면 표본 수가 적은 백업 선수나 벤치 멤버의 기록까지 모두 가져올 수 있으며, `startseason`과 `endseason`의 범위를 다르게 지정하여 여러 시즌을 누적(aggregate) 집계할 수도 있습니다.

```

---

## 5. 특정 선수 조회: Pete Crow-Armstrong

특정 선수의 지표를 조회하는 방법은 크게 두 가지가 있습니다.

### 방법 A: 선수 이름과 일치하는 데이터를 추출

데이터베이스에서 이름에 해당하는 `PlayerName` 컬럼을 이용하여 선수의 이름을 필터링할 수 있습니다.

```{code-block} r
# 이름을 이용하여 필터링
pca_stats <- batters_2026 %>%
  filter(PlayerName == "Pete Crow-Armstrong") %>%
  select(
    PlayerName, team_name, Season, G, PA,
    H, HR, SB, AVG, OBP, SLG
  )

pca_stats
```

### 방법 B: 선수 고유 ID를 이용하여 데이터를 추출

`playerid_lookup()` 함수를 사용해 선수의 MLBAM/FanGraphs 고유 ID를 조회한 뒤 수집에 활용할 수도 있습니다.

```{code-block} r
# 1. 선수 ID 검색
pca_id <- playerid_lookup(last_name = "Crow-Armstrong", first_name = "Pete")

# 2. ID 확인 (fangraphs_id 컬럼 확인)
pca_id %>% 
  select(first_name, last_name, birth_year, mlbam_id, fangraphs_id)

# 3. ID를 이용하여 선수 데이터 필터링
pca_stats_by_id <- batters_2026 %>%
  filter(playerid == pca_id$fangraphs_id) %>%
  select(
    PlayerName, team_name, Season, G, PA,
    H, HR, SB, AVG, OBP, SLG
  )

pca_stats_by_id

```

```{tip}
이름에 하이픈(`-`)이나 특수문자가 들어간 선수는 검색 시 대소문자 및 띄어쓰기를 정확히 맞춰야 필터링됩니다. 스펠링 오타로 인한 혼동이나 선수 개명으로 인한 데이터 오류를 방지할 수 있기 때문에 ID 방식이 더 정확합니다.

```