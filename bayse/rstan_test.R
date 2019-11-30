## 1.実際に乱数を生成し、その母数を推定する
#pythonで既知の母数を持つ正規乱数を生成し、その結果のみを用いて母数を推定してみよう。<br>
#stanがベイズ推論した母数は、真の母数と一致するだろうか？

y=rnorm(100,30,9) #期待値30、標準偏差9の正規分布に従う乱数を100個生成する
y


# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるがちゃんとインデントしよう。
model <- "
    data {
        int N;
        vector[N] Y;
    }
    parameters { 
        real mu;
        real<lower=0> sigma;
    }
    model { 
        for (i in 1:N)
            Y[i] ~ normal(mu,sigma);
    }
"
yData<-list(N=length(y),Y=y)
library(rstan)
fit<-stan(
  model_code = model,
  data=yData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)
fit


localLevelModel_1<-"
  data{
    int n;
    vector[n] Nile;
  }
  parameters{
    real mu;
    real<lower=0> sigmaV;
  }
  model{
    for(i in 1:n){
      Nile[i]~normal(mu,sqrt(sigmaV));
    }
  }
"
Nile
NileData<-list(Nile=as.numeric(Nile),n=length(Nile))
NileData
set.seed(1)
Nilemodel1<-stan(
  model_code = localLevelModel_1,
  data=NileData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)

Nilemodel1
traceplot(Nilemodel1)
stan_hist(Nilemodel1)
