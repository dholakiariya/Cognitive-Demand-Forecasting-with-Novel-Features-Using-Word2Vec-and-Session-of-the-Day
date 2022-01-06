library(data.table)
train <- fread("label_encoding_2.csv")
library(h2o)
h2o.init(nthreads = 3)
train.h20<-as.h2o(train)
train.h20$StockCode<-as.factor(train.h20$StockCode)

model = h2o.deeplearning(x=c(2,4,5,6,7,8,9,10,11,12,13,14,15),y = 3,
                         training_frame = as.h2o(train.h20),
                         activation = 'Rectifier',
                         hidden = c(110,110),
                         epochs = 100
                         
)
print(model)
print(model)  


library(h2o)
localH2O<-h2o.init(nthreads = 3)


h2o.varimp_plot(model)

