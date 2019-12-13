## 2.線形回帰をベイズ推論してみよう
#YはXの1次関数でモデル化できるようなデータがあるとする。<br>
#このとき、y=ax+b+εと書ける。a,b,V[ε]を推定しよう。（εは期待値0の正規分布）
library(rstan)
x=runif(100,0,30) 
x
y=10*x+23+rnorm(100,0,15) 
y
plot(x,y)
#推定値はa=10,b=23,V[ε]=15^2となるはずだ。

# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるがちゃんとインデントしよう。
model <- "
data {
  int N;
  vector[N] X;
  vector[N] Y;
}
parameters { 
  real a;
  real b;
  real<lower=0> sigma;
}
model { 
for (i in 1:N)
  Y[i] ~ normal(a*X[i]+b,sigma);
}"

#generated quantitiesブロックで予測もできる
#generated quantities {
#  real yhat[new_N];
#  for (i in 1:new_N)
#    yhat[i] = normal_rng(a*new_x[i]+b, sigma);
#}

yData<-list(N=length(y),X=x,Y=y)
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

#Rの機能で線形回帰（これは古典統計的なの最小二乗法）
reg<-lm(formula = y~x)
summary(reg)


## 演習2　線形回帰をベイズ推論してみよう
#tree dataを読み込む。
df<-trees

pairs(df)
#Girth(直径)とHeight（高さ）からVolume（体積）を求めよう。

#モデルはどうするべきか？