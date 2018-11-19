# 능력단위 실습 3번

# 3-1, 3-2 패키지 설치 및 실행하기

install.packages("ggvis")
library(ggvis)
install.packages("class")
library(class)
install.packages("gmodels")
library(gmodels)



# 3-3 ggvis로 iris 데이터 셋 시각화하기

iris
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill=~Species) %>% layer_points()
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill=~Species) %>% layer_points()


# 3-4 str, table, summary 확인 후 간단하게 설명하기 
str(iris)
table(iris)
table(iris$Species)
summary(iris)

# iris의 구조를 보면 5행 150열이고 Species는 Factor로 3가지 종류가 있다.
# Sepal과 petal의 길이와 너비는 numeric으로 되어있고, table에서 빈도수를
# 보면 모두 50으로 동일하다. summary를 보면 평균값등이 보여진다.




# 3-5 정규화함수(normalize)를 만들고 수치값을 정규화 시켜서 저장하기

normalize <- function(x) { 
  num <- x-min(x)
  denom <- max(x)-min(x)
  return (num/denom)
}

iris_norm <- as.data.frame(lapply(iris[1:4], normalize))



# 3-6 훈련 데이터와 테스트 데이터로 분류하기 ( 훈련 75%, 테스트 25%)
set.seed(1234)

ind <- sample(2, nrow(iris_norm), replace=TRUE, prob=c(0.75, 0.25))

iris.training <- iris_norm[ind==1, 1:4]
iris.test <- iris_norm[ind==2, 1:4]


iris.trainLabels <- iris[ind==1, 5]
iris.testLabels <- iris[ind==2, 5]



# 3-7 knn 분류 모델 생성 및 데이터 셋을 이용하여 예측값 구하기
# (여기서 k는 iris의 일 경우는 3이고, 다른 데이터 셋의 경우는 해당 범주의 개수만큼 지정하기)

iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k =3)


iris_pred

# 3-8 CrossTable을 이용하여 모델의 예측값과 test 데이터 셋의 데이터 비교후, 요약정리하기


CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)


# 3-9 위의 내용을 문서화하기


