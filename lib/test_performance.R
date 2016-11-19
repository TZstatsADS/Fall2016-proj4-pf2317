library(dplyr)


##############################
#### This file is used to test the performance of different models and different parameters in the models 
#### The metric of performance impliments the formula in evaluation file posted in project4 repo
#### Eventually, I used this metric to select models 
#### 5 models are tested: Knn, knn regression, logit regression, linear regression, random forest 

#features.df2<-load("./output/traning_features2")
#lyr2<-load("./output/predicting_features2")

num_test <- 100
X <- features.df2[c(1:(2350-num_test)),]
Y <- lyr2[c(1:(2350-num_test)),]  
X_pre <- features.df2[c((2350-num_test+1):2350),]  

rank_pre <- knn_reg(X,Y,X_pre)
#rank_pre <- linear_reg(X, Y, X_pre)
#rank_pre <- logit_reg(X, Y, X_pre)
#rank_pre <- random_forest(X, Y, X_pre)

score <- 0
for (i in 1:num_test){
  word.rank <- rank_pre[i,]
  exist.word <- names(Y)[which(lyr2[2350-num_test+i,]!=0)]   
  score <- score + sum(word.rank[exist.word])/length(exist.word)
}
score/num_test 

#### benchmark: sum up all the columns in training set (lyrics words)  
####            rank the sum and every testing song is assigned this rank
#### when test_num, the "score" is 605.8317. After trying different models,
#### only K-nearest-neighbour regression's "score" 594.3739 beat this number (lower) narrawly
#### This is why I chose KNN Regression as my final model 
score.bm <- 0
benchMark.rank <- rank(-colSums(Y),ties.method="last")   
for (i in 1:num_test){
  exist.word <- names(Y)[which(lyr2[2350-num_test+i,]!=0)]   
  score.bm <- score.bm + sum(benchMark.rank[exist.word])/length(exist.word)
}
score.bm/num_test
