#Example taken from https://github.com/lgreski/datasciencectacontent/blob/master/markdown/pml-randomForestPerformance.md
library(mlbench)
data(Sonar)
library(caret)
set.seed(95014)

# create training & testing data sets
inTraining <- createDataPartition(Sonar$Class, p = .75, list=FALSE)
training <- Sonar[inTraining,]
testing <- Sonar[-inTraining,]

# set up training run for x / y syntax because model format performs poorly
x <- training[,-61]
y <- training[,61]

#Serial mode
fitControl <- trainControl(method = "cv",
                           number = 25,
                           allowParallel = FALSE)

stime <- system.time(fit <- train(x,y, method="rf",data=Sonar,trControl = fitControl))



#Parallel mode
library(parallel)
library(doParallel)
cluster <- makeCluster(5) 
registerDoParallel(cluster)

fitControl <- trainControl(method = "cv",
                           number = 25,
                           allowParallel = TRUE)

ptime <- system.time(fit <- train(x,y, method="rf",data=Sonar,trControl = fitControl))

stopCluster(cluster)
registerDoSEQ()

fit
fit$resample
confusionMatrix.train(fit)

#Timings
timing <- rbind(sequential = stime, parallel = ptime)
timing

#Profiling
# Nr. cores    Timing(sec)
#   4          29.62 
#   3          36.94
#   2          51.83
#   1          88.20
