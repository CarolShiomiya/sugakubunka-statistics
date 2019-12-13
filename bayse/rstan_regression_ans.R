## 2.線形回帰をベイズ推論してみよう（演習の解答）
#YはXの1次関数でモデル化できるようなデータがあるとする。<br>

library(rstan)

#tree dataを読み込む。
df<-trees

pairs(df)
#Girth(直径)とHeight（高さ）からVolume（体積）を求めよう。

#モデルはどうするべきか？
#Vol∝h*G^2なのでは？

#data
yData<-list(N=length(df$Volume),H=df$Height,G=df$Girth,V=df$Volume)

# Stanコード。別ファイル（.stan）にdata{から書いてもよし。
#インデントを気にしない言語ではあるがちゃんとインデントしよう。
model <- "
data {
int N;
vector[N] H;
vector[N] G;
vector[N] V;
}
parameters { 
real c;
real<lower=0> sigma;
}
model { 
for (i in 1:N)
V[i] ~ normal(c*H[i]*G[i]*G[i],sigma);
}"


library(rstan) 
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