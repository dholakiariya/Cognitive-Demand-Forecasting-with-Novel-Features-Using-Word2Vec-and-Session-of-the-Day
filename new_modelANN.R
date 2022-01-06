library(data.table)
train <- fread("Train_model.csv")

library(h2o)
h2o.init(nthreads = 3)
train.h20<-as.h2o(train)
train.h20$StockCode<-as.factor(train.h20$StockCode)

model = h2o.deeplearning(x=c(1,3,4,5,6,7,8,9,10,11,12,13,14,15,16),y = 2,
                         training_frame = as.h2o(train.h20),
                         activation = 'Rectifier',
                         hidden = c(110,110),
                         epochs = 100,
                         
                        
)
print(model)

y_pred = as.data.frame(y_pred)
y_pred = h2o.predict(model, newdata = as.h2o(test.h20))

library(h2o)
localH2O<-h2o.init(nthreads = 3)


h2o.varimp_plot(model)


model = h2o.deeplearning(x=c(1,3,4,5,6,7,8,9,10,11,12,13,14,15,16),y = 2,
                         training_frame = as.h2o(train.h20),
                         activation = 'Tanh',
                         hidden = c(110,110),
                         epochs = 100,
                         keep_cross_validation_predictions = TRUE
)
print(model)-----------1



model = h2o.deeplearning(x=c(1,3,4,5,6,7,8,9,10,11,12,13,14,15,16),y = 2,
                         training_frame = as.h2o(train.h20),
                         activation = 'Tanh',
                         hidden = c(100,100),
                         epochs = 100,
                         keep_cross_validation_predictions = TRUE
)
print(model)

model = h2o.deeplearning(x=c(1,3,4,5,6,7,8,9,10,11,12,13,14,15,16),y = 2,
                         training_frame = as.h2o(train.h20),
                         activation = 'Tanh',
                         hidden = c(80,80),
                         epochs = 100,
                         keep_cross_validation_predictions = TRUE
)
print(model)



