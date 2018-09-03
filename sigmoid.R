library(ggplot2)
library(dplyr)
sigmoid<-function(x){1/(1+exp(-x))}
ggplot(data=data_frame(z=-5:5),mapping=aes(x=z))+stat_function(fun=sigmoid)

logistic<-function(x,beta_0=0,beta_1=1){1/(1+exp(-(beta_0+beta_1*x)))}
ggplot(data=data_frame(z=-5:5),mapping=aes(x=z))+stat_function(fun=logistic)

#beta1を大きく
ggplot(data=data_frame(z=-5:5),mapping=aes(x=z))+stat_function(fun=logistic,color="blue",args=list(beta_0=0,beta_1=2))

#beta0を大きく
ggplot(data=data_frame(z=-5:5),mapping=aes(x=z))+stat_function(fun=logistic,color="red",args=list(beta_0=1,beta_1=1))

#重ねて書くと
ggplot(data=data_frame(z=-5:5),mapping=aes(x=z))+stat_function(fun=logistic,color="blue",args=list(beta_0=0,beta_1=2))+stat_function(fun=logistic,color="red",args=list(beta_0=1,beta_1=1))+stat_function(fun=logistic)


library(purrr)
datasize<-100
x<-10*runif(n=datasize)
x
rbernoulli(n=10,p=0.5)
