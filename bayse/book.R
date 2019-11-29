Y=c(42,32,27,21,17,12,10,10,9,6,4,4,3,3,3,3,2,2,1)

dY=diff(Y)
-dY

data=list(N=length(dY),Y=-dY)
data
library(rstan)
fit<-stan(file = "modelbook.stan",data=data)
fit
