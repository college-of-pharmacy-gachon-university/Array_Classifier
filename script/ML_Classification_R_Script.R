# Load all library
library(caret)
library(e1071)
library(randomForest)
library(ROCR)

# Random Forest
data = read.csv("nachr_set_1.csv", header = TRUE)
datasplit = data[,-c(1:2)]
intrain <- createDataPartition(y = datasplit$Class, p= 0.7, list = FALSE)
training <- datasplit[intrain,]
control <- trainControl(method="cv", number=10, classProbs=TRUE, summaryFunction=twoClassSummary,savePredictions ="final")
set.seed(2135)
ml_data_rf <- train(Class ~., data = training, method="rf", metric ="ROC", trControl = control)
ml_data_rf
caret::confusionMatrix(ml_data_rf,"none")
prob_rf <- ml_data_rf$pred$Active

# Decision Tree Method
data = read.csv("nachr_set_1.csv", header = TRUE)
datasplit = data[,-c(1:2)]
intrain <- createDataPartition(y = datasplit$Class, p= 0.7, list = FALSE)
training <- datasplit[intrain,]
control <- trainControl(method="cv", number=10, classProbs=TRUE, summaryFunction=twoClassSummary,savePredictions ="final")
set.seed(2135)
ml_data_dt <- train(Class ~., data = training, method="rpart", metric ="ROC", trControl = control, preProcess = c("center","scale"))
ml_data_dt
caret::confusionMatrix(ml_data_dt,"none")
prob_dt <- ml_data_dt$pred$Active

# SVM Method
data = read.csv("nachr_set_1.csv", header = TRUE)
datasplit = data[,-c(1:2)]
intrain <- createDataPartition(y = datasplit$Class, p= 0.7, list = FALSE)
training <- datasplit[intrain,]
control <- trainControl(method="cv", number=10, classProbs=TRUE, summaryFunction=twoClassSummary,savePredictions ="final")
set.seed(2135)
ml_data_svm <- train(Class ~., data = training, method="svmLinear", metric ="ROC", trControl = control, preProcess = c("center","scale"))
ml_data_svm
caret::confusionMatrix(ml_data_svm,"none")
prob_svm <- ml_data_svm$pred$Active

# KNN Method
data = read.csv("nachr_set_1.csv", header = TRUE)
datasplit = data[,-c(1:2)]
intrain <- createDataPartition(y = datasplit$Class, p= 0.7, list = FALSE)
training <- datasplit[intrain,]
control <- trainControl(method="cv", number=10, classProbs=TRUE, summaryFunction=twoClassSummary,savePredictions ="final")
set.seed(2135)
ml_data_knn <- train(Class ~., data = training, method="knn", metric ="ROC", trControl = control, preProcess = c("center","scale"))
ml_data_knn
caret::confusionMatrix(ml_data_knn,"none")
prob_knn <- ml_data_knn$pred$Active

# Ensemble Method
prob_rf <- ml_data_rf$pred$Active
prob_dt <- ml_data_dt$pred$Active
prob_svm <- ml_data_svm$pred$Active
prob_knn <- ml_data_knn$pred$Active
avg_prob <- (prob_rf + prob_dt + prob_svm + prob_knn)/4
ensemble_auc <- performance(prediction(avg_prob,training$Class),"auc")@y.values[[1]]
ensemble_auc

# Prediction on test set
testing <- datasplit[-intrain,]

# Random Forest Method
test_pred_rf <- predict(ml_data_rf, newdata = testing)
test_pred_rf
plot(test_pred_rf)
table(test_pred_rf, testing$Class)

# Decision Tree Method
test_pred_dt <- predict(ml_data_dt, newdata = testing)
test_pred_dt
table(test_pred_dt, testing$Class)

# SVM Method
test_pred_svm <- predict(ml_data_svm, newdata = testing)
test_pred_svm
table(test_pred_svm, testing$Class)

# KNN Method
test_pred_knn <- predict(ml_data_knn, newdata = testing)
test_pred_knn
table(test_pred_knn, testing$Class)

# Save the test prediction in CSV
model_1 <- cbind(test_pred_rf, test_pred_dt, test_pred_svm, test_pred_knn)
write.csv(model_1, 'model_1_test_pred.csv')

# Prediction on External Set (CWA & NPS)
third_set = read.csv("NPS_Test_Set.csv", header = TRUE)
testdata = third_set[,-c(1:3)]
testset_pred_rf <- predict(ml_data_rf, newdata = testdata)
testset_pred_rf
plot(test_pred)
table(test_pred, test$Class)

# Save the external test prediction in CSV
modelthirdset_10 <- cbind(testset_pred_rf, testset_pred_dt, testset_pred_svm, testset_pred_knn)
write.csv(modelthirdset_10, 'model_1_thirdset_test_pred.csv')