## 2.重回帰をベイズ推論してみよう
#YはXの1次関数でモデル化できるようなデータがあるとする。<br>
#このとき、y=ax+b+εと書ける。a,b,V[ε]を推定しよう。（εは期待値0の正規分布）
#前回の授業では、a,xは1つの実数であったが、今回は3次元の実数ベクトルとする。
#また、今回はtransformed parametersブロックの使い方も学ぶ。

#まずはデータ作成
library(rstan)
x1=runif(100,0,30) 
x2=runif(100,30,40)

y=10*x1-23*x2-15+rnorm(100,0,15) 

pairs(data.frame(x1,x2,y))
#推定値はa1=10,a2=-23,b=-15,V[ε]=15^2となるはずだ。

# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるが、可読性を高めるためちゃんとインデントしよう。
model <- "
data {
  int N;
  vector[N] X1;
  vector[N] X2;
  vector[N] Y;
}
parameters { 
  real a1;
  real a2;
  real b;
  real<lower=0> sigma;
}
transformed parameters{
  real mu[N]; //長さNの実数ベクトルを作る
  for (i in 1:N)
    mu[i] = a1*X1[i]+a2*X2[i]+b; //for文で、各データポイントに対して期待値muを作成
}
model { 
  for (i in 1:N)
    Y[i] ~ normal(mu[i],sigma);
}"

#generated quantitiesブロックで予測もできる
#generated quantities {
#  real yhat[new_N];
#  for (i in 1:new_N)
#    yhat[i] = normal_rng(a*new_x[i]+b, sigma);
#}

yData<-list(N=length(y),X1=x1,X2=x2,Y=y)
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
stan_hist(fit,pars=c("a1","a2","b"))
fit

#Rの機能で線形回帰（これは古典統計的なの最小二乗法）して回帰係数を確認
reg<-lm(formula = y~x1+x2)
summary(reg)


#演習：stanでロジスティック回帰モデルを作ってみよう。
#まずはデータ作成.yは確率p=sigmoid(a1x1+a2x2+b)で1,1-pで0となるようにする。
library(rstan)
x1<-runif(100,0,30) 
x2<-runif(100,30,40)
z<-0.3*x1-0.2*x2+1
p<-1/(1+exp(-z))
hist(p)
y<-c()
for (i in 1:100){
  y[i]<-rbinom(1,1,p[i])} #Rにはベルヌーイ分布がないので、n=1の二項分布。

#推定値はa1=0.3,a2=-0.2,b=1となるはずだ。

#空欄を補ってStanコードを書いてみよう。
model <- "
data {
  int N;
      //Yの型に注意
}
parameters { 
  real a1;
  real a2;
  real b;
}
transformed parameters{
  real p[N]; //長さNの実数ベクトルを作る
  //hint:sigmoid関数はinv_logit()
}
model { 
  for (i in 1:N)
  Y[i] ~ ;
}"

#data
yData<-list(     )

#実行
fit<-stan(
  model_code = model,
  data=yData,
  iter=2000,
  warmup=1000,
  thin=1,
  chains=3)
traceplot(fit) #定常状態になっているかしっかりチェックせよ
stan_hist(fit)
fit