#Taken from: http://michael.hahsler.net/SMU/LearnROnYourOwn/code/doMC.html
library(doParallel)
registerDoParallel(cores=8)
getDoParWorkers()

library(caret)
library(MASS)
library(klaR)
library(nnet)
library(e1071)
library(rpart)

data(iris)
x <- iris[sample(1:nrow(iris)),]

x <- cbind(x, useless = rnorm(nrow(x)))
x[,1] <- x[,1] + rnorm(nrow(x))
x[,2] <- x[,2] + rnorm(nrow(x))
x[,3] <- x[,3] + rnorm(nrow(x))

head(x)

posteriorToClass <- function(predicted) {
    colnames(predicted$posterior)[apply(predicted$posterior,
        MARGIN=1, FUN=function(x) which.max(x))]
}

missclassRate <- function(predicted, true) {
    confusionM <- table(true, predicted)
    n <- length(true)

    tp <- sum(diag(confusionM))
    (n - tp)/n
}

evaluation <- function() {
    ## 10% for testing
    testSize <- floor(nrow(x) * 10/100)
    test <- sample(1:nrow(x), testSize)

    train_data <- x[-test,]
    test_data <- x[test, -5]
    test_class <- x[test, 5]

    ## create model
    model_knn3 <- knn3(Species~., data=train_data)
    model_lda <- lda(Species~., data=train_data)
    model_nnet <- nnet(Species~., data=train_data, size=10, trace=FALSE)
    model_nb <- NaiveBayes(Species~., data=train_data)
    model_svm <- svm(Species~., data=train_data)
    model_rpart <- rpart(Species~., data=train_data)

    ## prediction
    predicted_knn3 <- predict(model_knn3 , test_data, type="class")
    predicted_lda <- posteriorToClass(predict(model_lda , test_data))
    predicted_nnet <- predict(model_nnet, test_data, type="class")
    predicted_nb <- posteriorToClass(predict(model_nb, test_data))
    predicted_svm <- predict(model_svm, test_data)
    predicted_rpart <- predict(model_rpart, test_data, type="class")

    predicted <- list(knn3=predicted_knn3, lda=predicted_lda,
        nnet=predicted_nnet, nb=predicted_nb, svm=predicted_svm,
        rpart=predicted_rpart)

    ## calculate missclassifiaction rate
    sapply(predicted, FUN=
        function(x) missclassRate(true= test_class, predicted=x))
}

runs <- 100

stime <- system.time({
        sr <- foreach(1:runs, .combine = rbind) %do% evaluation()
    })


ptime <- system.time({
        pr <- foreach(1:runs, .combine = rbind) %dopar% evaluation()
    })

timing <- rbind(sequential = stime, parallel = ptime)
timing


