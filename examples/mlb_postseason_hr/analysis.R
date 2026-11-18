# 2015--2025 MLB postseason, FanGraphs via baseballr
# Run from the book project root: Rscript examples/mlb_postseason_hr/analysis.R
# This script matches the R code blocks in 1406-postseason-homeruns.md.

# %% setup
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

# %% download-functions
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

# %% collect
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

# %% baseline
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

# %% summaries
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

# %% primary-test
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

# %% sensitivity
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

# %% plot-and-save
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

