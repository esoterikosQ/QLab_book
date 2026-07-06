# 랜덤포레스트 그리드 서치, 최적 모형 찾은 후 예측값 계산

```R
train = read.csv("data/customer_train.csv")
test = read.csv("data/customer_test.csv")

# 사용자 코딩


# 라이브러리 로딩
library(randomForest) # 랜덤포레스트
library(caret) # 그리드 서치
library(dplyr)

# 환불금액 결측치를 0으로 대치
train %>% mutate(환불금액 = ifelse(is.na(환불금액), 0, 환불금액)) -> train
test %>% mutate(환불금액 = ifelse(is.na(환불금액), 0, 환불금액)) -> test


# 랜덤시드 고정
set.seed(123)

# 교차검증 설정
ctrl <- trainControl(
    method = 'repeatedcv',
    number = 5,
    repeats = 1,
    verboseIter = TRUE)

# 하이퍼파라미터 그리드 
grid <- expand.grid(mtry = c(3, 4))

# 학습

final_model <- train(
    총구매액 ~.,
    data = train,
    method = 'rf',
    trControl = ctrl,
    tuneGrid = grid,
    ntree = 100,
    metric = 'RMSE')

# 결과 확인
print(final_model)

# 예측
test_pred <- predict(final_model, newdata = test)

# 제출파일 저장
write.csv(test_pred, 'result.csv', row.names = FALSE)
```





# 데이터 정제, 요약통계량 계산

```R
df = read.csv("data/employee_performance.csv")

# 사용자 코딩

# 라이브러리 로딩
library(dplyr)
library(tidyr)

# 고객만족도 결측치를 평균값으로 대치
df_rev <- df %>% mutate(고객만족도 = ifelse(is.na(고객만족도), mean(고객만족도, na.rm=TRUE), 고객만족도)) %>%
drop_na(근속연수) # 근속연수가 없는 직원은 삭제

# 고객만족도 3사분위수 계산
print(paste('전체 직원 고객만족도 3사분위수 : ', quantile(df_rev$고객만족도, prob = 0.75)))

# 부서별 평균연봉 계산
df_rev %>% group_by(부서) %>% summarise(평균연봉 = mean(연봉)) %>% arrange(desc(평균연봉))
```


# 등분산 검정, 합동분산 기반 t-검정

```R
df = read.csv("data/bcc.csv")

# 사용자 코딩

# 라이브러리 로딩
library(dplyr)

# 로그 리지스틴 수치 계산
df <- df %>% mutate(LogRes = log(Resistin))
# Classification을 factor로
df <- df %>% mutate_at(vars(Classification), as.factor)

summary(df) # 1: 52 / 2:64

# F검정 통계량 / 분자의 자유도가 분모의 자유도보다 크게 : 환자/정상
var.test(df$LogRes[df$Classification == '2'], df$LogRes[df$Classification == '1']) 

# 검정통계량 : 1.348 / p-value = 0.2719 / 귀무가설 기각 못함 = 등분산

# 합동분산 추정량 계산
pooled_var_df <- df %>% group_by(Classification) %>% summarise(n = n(), var = var(LogRes), .groups = 'drop')

n1 <- pooled_var_df$n[1]
n2 <- pooled_var_df$n[2]
s1_sq <- pooled_var_df$var[1]
s2_sq <- pooled_var_df$var[2]

pooled_var <- ((n1 - 1)*s1_sq + (n2-1)*s2_sq)/(n1+n2-2)

print(paste('pooled variation : ', round(pooled_var, 4)))
# 0.449

# 합동 분산 추정량을 이용한 독립표본 t검정
t_df <- df %>% group_by(Classification) %>% summarise(avg = mean(LogRes), .groups = 'drop')

# 검정통계량 계산
t = (t_df$avg[1] - t_df$avg[2]) / sqrt(pooled_var * (1/n1 + 1/n2))

# 자유도 계산
dof = n1 + n2 - 2

# p-value
# H0 : mean1 = mean2
p_value = 2*(1 - pt(abs(t), dof))

print(paste('p-value of t-test : ', round(p_value, 3))) # 0.003
```
