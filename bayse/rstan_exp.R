## 1.指数分布の母数をベイズ推論してみよう
#Yはλ=5の指数分布に従うとする。

library(rstan)
y=rexp(100,rate = 5)
y

#データYを元に母数を推定してみよう。

# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるがちゃんとインデントしよう。
model <- "
data {
  int N;
  vector[N] Y;
}
parameters { 
  real <lower=0>lambda ;
}
model { 
  for (i in 1:N)
    Y[i] ~ exponential(lambda);
}"

yData<-list(N=length(y),Y=y)
#yData<-list(N=length(y),X=x,Y=y,new_N=5,new_X=c(5,10,15,20,25))
library(rstan)
fit<-stan(
  model_code = model,
  data=yData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)
traceplot(fit)
stan_hist(fit)
fit