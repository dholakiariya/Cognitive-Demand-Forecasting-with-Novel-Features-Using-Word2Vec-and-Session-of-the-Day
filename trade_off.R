library(data.table)
data<-fread("Train_model_shuffled2.csv")
#install.packages("caTools")
library(caTools)
#install.packages("ISLR")
library(ISLR)
smp_siz = floor(0.9*nrow(data)) # creates a value for dividing the data into train and test. In this case the value is defined as 75% of the number of rows in the dataset
smp_siz  # shows the value of the sample size
train_ind = sample(seq_len(nrow(data)),size = smp_siz, replace = FALSE)  # Randomly identifies therows equal to sample size ( defined in previous instruction) from  all the rows of Smarket dataset and stores the row number in train_ind
train1 =data[train_ind,] #creates the training dataset with row numbers stored in train_ind
test1=data[-train_ind,]  # creates the test dataset excluding the row numbers mentioned in train_ind

summary(data)


library(xgboost)

xgtrain1 <- xgb.DMatrix(data = as.matrix(train[,-1]), label = train$Quantity)
xgtest1 <- xgb.DMatrix(data = as.matrix(test[,-1]), label = test$Quantity)

xgb1 <- xgboost(data = xgtrain1,xgtest1,
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

xgbpred1 <- predict (xgb1,xgtest1)
install.packages("Metrics")
library(Metrics)
rmse(test$Quantity,xgbpred1)  
