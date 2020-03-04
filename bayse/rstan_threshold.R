library(rstan)

#1.データ作成
x=c(rep(1,100),rep(-1,70))
x
y=round(c(runif(100,1960,2010),runif(70,1900,1970)))
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
  bunbo =log((1/a)*( log(1+exp(a*(2100-b))) - log(1+exp(a*(1800-b))) ));
  return temp - bunbo;
  }
}
data{
  int Takei[170];
  int Y[170]; 
}
parameters {
real<lower = -1, upper=1> alpha;
real<lower=1900,upper=1990> beta;
}
model{
for (i in 1:170){
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

#今度は年代を使って、多形があるかどうか予測するロジスティック回帰モデルを作成し、
#年代の回帰係数が大きいものを絞り込む。
library(brms)
fit_brm <- brm(x ~ y , data=df, family="bernoulli",iter=2000,warmup=1000,chain=2)