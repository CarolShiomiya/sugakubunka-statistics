library(rstan)

#1.データ作成
x=c(rep(1,50),rep(-1,50))
x
y=round(c(runif(50,1960,2010),runif(50,1900,1970)))
df=data.frame(y=y,x=x)
df
plot(x,y)


#2.stanコード
model <- "
functions{ 
real sigmoiddist_log(real x,real a, real b){ 
  real temp;
  real bunbo;
  temp = inv_logit(a*(x-b));
  bunbo =log((1/a)*( log(1+exp(a*(2020-b))) - log(1+exp(a*(1800-b))) ));
  return temp - bunbo;
  }
}
data{
  int Takei[100];
  int Y[100]; 
}
parameters {
real<lower = -1, upper=1> alpha;
real<lower=1900,upper=1990> beta;
}
model{
for (i in 1:40){
  Y[i]~sigmoiddist(Takei[i]*alpha,beta) ;
}
}"


yData<-list(Takei=x,Y=y)
#yData<-list(N=length(y),X=x,Y=y,new_N=5,new_X=c(5,10,15,20,25))
library(rstan)
fit<-stan(
  model_code = model,
  data=yData,
  iter=2000,
  warmup=500,
  thin=1,
  chains=3)
traceplot(fit)
stan_hist(fit)
stan_hist(fit,pars=c("alpha","beta"))

ms=extract(fit)
ms$yhat