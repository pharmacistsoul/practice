# 능력단위 실습 1번


# 1-4, 2-1

rm(list=ls())
# 파일불러오기
setwd("C:/Users/ktm/Desktop/빅데이터/텍스트마이닝과제/한국행정연구원_공직생활에_대한_인식조사_2015")

text <- readLines("한국행정연구원_공직생활에 대한 인식조사_설문지_2015.txt")


#install.packages("KoNLP")
library(KoNLP)

# 사전 불러오기
useSejongDic()

# KoNLP의 명사추출 기능 활용해서 명사 추출하기.리스트명은 순서대로.
aa = sapply(text, extractNoun,USE.NAMES=F)
aa
# 줄로된 추출한 명사들을 unlist로 한문장으로 바꿔줌 
data3 = unlist(aa)
data3

# 2-1
# 형태소 분석하기 
MorphAnalyzer(data3)

# 2-2
# gsub을 이용해서 불용어 제거하기 

#,"SQ10","SQ11","1기혼","2미","해","2개방형","위","당","중","다음","SQ9","3기타","1공개경쟁채용","2경력경쟁채","용","SQ8"
data3 <- gsub("SQ10","",data3)
data3 <- gsub("SQ11","",data3)
data3 <- gsub("1기혼","",data3)
data3 <- gsub("2미","",data3)
data3 <- gsub("해","",data3)
data3 <- gsub("2개방형","",data3)
data3 <- gsub("위","",data3)
data3 <- gsub("당","",data3)
data3 <- gsub("중","",data3)
data3 <- gsub("다음","",data3)
data3 <- gsub("SQ9","",data3)
data3 <- gsub("3기타","",data3)
data3 <- gsub("1공개경쟁채용","",data3)
data3 <- gsub("2경력경쟁채","",data3)
data3 <- gsub("용","",data3)
data3 <- gsub("SQ8","",data3)
data3 <- gsub("SQ7","",data3)
data3 <- gsub("♣","",data3)
data3 <- gsub("▣","",data3)
data3 <- gsub("\\d+","",data3)  # 숫자 불용어 제거
data3 <- gsub("그렇","",data3)
data3

# 한단어짜리 불용어등을 제거 해주기 
data <- Filter(function(x) {nchar(x) >= 2}, data3)

# table() 빈도수 분석해 주는 함수를 활용해서 빈도수 분석 
cnt = table(data)
cnt


# 내림차순으로 30개의 빈도수 상위 명사를 보여주기
head(sort(cnt, decreasing=T),30)


# 3-4

# 파일 만들기
write.csv(cnt,"C:/Users/ktm/Desktop/빅데이터/텍스트마이닝과제/cnt.csv")
