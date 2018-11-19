# 능력단위 실습 2번

# 1-1

# 분석한 상위 명사 20개를 보면 text, mining, analysis, information, data 등으로
# 텍스트 마이닝, 조사, 정보, 데이터에 관련된 내용에 대한 설명등의 내용이라고 생각해 볼 수 있다.
# 자세한 내용을 알고싶다면, text, mining, analysis, information, data, software, business, copyright 등의 형식적인 단어들의 불용어 처리를 한다면 조금 더 상세한 내용을 알아볼 수 있을 거라고 생각한다.

# 2-3  말뭉치 전환하기

rm(list=ls())
textData <- readLines("C:/Users/ktm/Desktop/빅데이터/텍스트마이닝과제/05_텍스트마이닝데이터분석_DATA_REF_60h/data/wikiTextming.txt")
textData

# install.packages("tm")
library(tm)


# 변경전 구조를 보는건가?
print(textData)
str(textData)


# 텍스트에서 말뭉치(Corpus)로 변경하기

textData1 <- VectorSource(textData)
textData1

corpus <- Corpus(textData1)
corpus

str(corpus)
strwrap(corpus[[1]])
inspect(corpus)

# 2-4 불용어 처리 (텍스트 전처리), 단어 문서 행렬을 작성하기


#corpus <- tm_map(corpus, removePunctuation)
#corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, tolower)

#corpus <- tm_map(corpus, PlainTextDocument)

#stopword <- c(stopwords('en'), "and", "but")
#corpus <- tm_map(corpus, removeWords, stopword)

# strwrap(corpus[[13]])   # bound 밖에 잇다?
strwrap(corpus[[1]])
strwrap(corpus[[2]])

.libPaths()

corpus <- tm_map(corpus, removeWords, stopwords("english"))
strwrap(corpus[[1]])


# 2-5 발생빈도 상위 명사 20개 확인 

tdm <- TermDocumentMatrix(corpus, control=list(tokenize="scan", wordLengths=c(2,7)))
inspect(tdm)
nTerms(tdm)

dtm <- DocumentTermMatrix(corpus)
dtm



dtm2 <- as.matrix(dtm)
dtm2



print(frequency)


frequency <- colSums(dtm2) 
frequency <- sort(frequency, decreasing=T) 
frequency[1:20]

# 4-4 시각화 해보기 

barplot(frequency[1:20], las=3)

#install.packages("RColorBrewer")
library(RColorBrewer)

#install.packages("wordcloud")
library(wordcloud)

#col <- brewer.pal(7,"Set3")
palete <- brewer.pal(8,"Set3")
wordcloud(names(frequency),freq=frequency,scale=c(5,1),rot.per=0.25,min.freq=3,random.order=F,random.color=T,colors=palete)


