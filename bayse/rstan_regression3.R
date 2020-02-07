## 2.重回帰をベイズ推論してみよう
#YはXの1次関数でモデル化できるようなデータがあるとする。<br>
#このとき、y=ax+b+εと書ける。a,b,V[ε]を推定しよう。（εは期待値0の正規分布）
#前回の授業では、a,xは1つの実数であったが、今回は2次元の実数ベクトルとする。
#また、今回はtransformed parametersブロックの使い方も学ぶ。

#まずはデータ作成
library(rstan)
library(MASS)
mu <- c(10, 20)
cov <- matrix(c(2.0, -0.8, -0.8, 1.0), ncol = 2)
data <- mvrnorm(1, mu = mu, Sigma = cov)
colnames(data) <- c('X1', 'X2')

g <- ggplot(as.data.frame(data), aes(x = X1, y = X2))
g <- g + geom_point()
print(g)

data2<-data+c(100,30)
head(data)

#推定値はa1=10,a2=-23,b=-15,V[ε]=15^2となるはずだ。

# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるが、可読性を高めるためちゃんとインデントしよう。
model <- "
data {
vector[2] Y;
matrix[2,2] Cov;
}
parameters { 
vector[2] mu;
}
model { 
Y ~ multi_normal(mu,Cov);}"


yData<-list(Y=data2,Cov=cov)
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

ms=extract(fit)
ms$yhat