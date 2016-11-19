library(rhdf5)
library(pbapply)
library(dplyr)
library(FNN)

################################################################################################################
############################################ FEATURE EXTRACTION ################################################

# training feature
dir.h5 <- './data/data/'
files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))
features.df <- get.features(files.list,dir.h5)
features.df2 <- features.df %>% select(-song)
#saveRDS(features.df, "./output/traning_features.RData")

# traning response
load("./data/lyr.RData")
lyr2 <- lyr %>% select(-1,-2,-3,-6:-30)

# predicting feature
dir.h5 <- './data/TestSongFile100/TestSongFile100/'
files.list <- as.matrix(list.files(dir.h5, recursive = TRUE))
features.df.test <- get.features(files.list,dir.h5)
features.df.test2 <- features.df.test %>% select(-song)
#saveRDS(features.df.test, "./output/predicting_features.RData")

############################################ FEATURE EXTRACTION #################################################
################################################################################################################


################################################################################################################
############################################ Training & Prediction #############################################

# model: KNN Regression

X <- features.df2
Y <- lyr2
X_pre <- features.df.test2
#t <- proc.time()
rank_pre <- knn_reg(X,Y,X_pre)
write.csv(rank_pre, "./output/rank.csv")
#(proc.time()-t)[3]

############################################ Training & Prediction #############################################
################################################################################################################
