#### Code in this file came from initial stage of this project, so most of them was not used 
#### but they can still be meaningful

#### This is my initial endeavour to extract feature through a loop, which later was not used 

library(rhdf5)
library(pbapply)

dir.h5 <- './data/data/'
files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))

# Loop through all the data files, collect results as a list.
features <- pblapply(files.list, 
  function(x, dir){
    file <- paste0(dir,x)
    h5f <- h5dump(file, load = TRUE)
    analysis <- h5f$analysis
    song <- substr(x, start = 12, stop = nchar(x)-3)
                       
    feature <- rep(0,15)
    i <- 1
    for (item in analysis) {
      if (is.numeric(item)){
        feature[i]<-mean(item)
        i <- i+1
      }
    }
                       
    feature <- append(feature, song, after = 0)
      H5close()
      return(feature)
    },
    dir = dir.h5
)



#### This is my initial trail with distance measure, later this method turned out to be a special case 
#### for KNN Regression 

library(dplyr)

K <- 5
test_num<- 50
distance.measure <- c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski")
ties.method <- c("first","last")
score <- 0
scores <- rep(0,12)
time <- rep(0,12)
j <- 1

for (method in ties.method) {
  for (measure in distance.measure){
    distance <- as.matrix(dist(features.df2, measure)) 
    t <- proc.time()
    
    for (i in 1:test_num){
      #pre <- lyr2[which.min(distance[2350-(i-1),-c(2350:2350-(test_num-1))]),]
      dis <- distance[2350-(i-1),-c(2350:(2350-(test_num-1)))] # distance between i and training songs
      pre <- colSums(lyr2[order(dis)[c(1:K)],]) 
      pre.rank <- rank(-pre,ties.method=method)
      
      #distance <- as.matrix(dist(features.df2, meansure)) 
      #pre <- lyr2[which.min(distance[2350,-c(2350)]),]
      #true <- lyr2[2350-(i-1),]
      #diff[i] <- norm((pre-true),type="2")
      #diff[i] <- KL.empirical(pre,true)
      #error[j] <- mean(diff)
      
      true <- lyr2[2350-(i-1),]
      true.rank <- rank(-true,ties.method=method)
      
      exist.word <- names(true)[which(lyr2[2350-(i-1),]!=0)]
      score <- score + sum(pre.rank[exist.word])/length(exist.word)
      
    }
    time[j] <- (proc.time()-t)[3]
    scores[j] <- score/test_num
    score <- 0
    j<-j+1
  }
}


#### This is my endeavour to achieve multiple-response regression using R-package, which evetually failed

library(pls)
X <- as.matrix(song.feature.df2)
Y <- as.matrix(lyr2)
sens.pcr <- pcr(Y ~ X, ncomp = 4, scale = TRUE)
