install.packages("data.table")
install.packages("h2o")
install.packages("stringr")
library(data.table)
data<-fread("Train_model_shuffled.csv")
data2<-fread("test data for last month.csv")
install.packages("caTools")
library(caTools)
install.packages("ISLR")
library(ISLR)
smp_siz = floor(0.9*nrow(data)) # creates a value for dividing the data into train and test. In this case the value is defined as 75% of the number of rows in the dataset
smp_siz  # shows the value of the sample size
train_ind = sample(seq_len(nrow(data)),size = smp_siz, replace = FALSE)  # Randomly identifies therows equal to sample size ( defined in previous instruction) from  all the rows of Smarket dataset and stores the row number in train_ind
train =data[train_ind,] #creates the training dataset with row numbers stored in train_ind
test=data[-train_ind,]  # creates the test dataset excluding the row numbers mentioned in train_ind

summary(data)

library(h2o)
h2o.init()
train.h2o<-as.h2o(train)
train.h2o$StockCode<-as.factor(train.h2o$StockCode)

install.packages("caret")
library(caret)

modelRandom <- train(Quantity~., 
                     data = train,
                     method = "svmRadial",
)
#install.packages('h2o')
install.packages('xgboost')
library(xgboost)

xgtrain1 <- xgb.DMatrix(data = as.matrix(train[,-1]), label = train$Quantity)
xgtest2<- xgb.DMatrix(data = as.matrix(test[,-1]), label = test$Quantity)
xgpredict <- xgb.DMatrix(data = as.matrix(data2[,-1]), label = data2$Quantity)

xgb <- xgboost(data = xgtrain1,xgtest2,
               eta = 0.1,
               max_depth = 25, 
               nround=100, 
               subsample = 0.5,
               colsample_bytree = 0.5,
               seed = 1,
               eval_metric = "rmse",
               early_stopping_rounds = 20,
               objective = "reg:linear",
               nthread = 3
) 

xgbpred <- predict (xgb,xgtest2)
xgpred2 <- predict(xgb,xgpredict)
install.packages("Metrics")
library(Metrics)
nmare(data2$Quantity,xgpred2)
df <- as.data.frame(xgpred2)

write.csv(df, file = "predictedmonth.csv")


#########################################################Trade-off#################################################################

install.packages('lightgbm')
