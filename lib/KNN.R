library(dplyr)

KNN <- function(X, Y, X_pre){
    
    t <- proc.time()  
  
    test_num <- nrow(X_pre)
    obs_num <- nrow(total.df)
    total.df <- rbind(X,X_pre)
    distance <- as.matrix(dist(total.df, "binary")) 
    
    for (i in 1:test_num){
      pre <- lyr2[which.min(distance[obs_num-(i-1),-c(obs_num:obs_num-(test_num-1))]),] 
      pre.rank <- rank(-pre, ties.method ="last")
      
      if(i==1) {res<-pre.rank} else{res <- rbind(res,pre.rank)}
    }
    
    (proc.time()-t)[3]
    
    return(res)
}
