#p=0.1,N=10の二項分布の確率質量関数を描いてみよう。

#確率変数は、アタリの回数なので、０から１０
X<-0:10
X

#4C2はこのようにchoose関数を使って書く。
choose(4,2)

#二項係数
bi<-choose(10,X)
bi

#積の法則
seki<-(0.1^X)*((1-0.1)^(10-X))
seki

#確率質量関数を求める
prob<-bi*seki
plot(X,prob)
help(plot)

sum(prob) #和は１であることを確認


#p,Nを決めれば、二項分布の確率質量関数の形が決まる。
binomplot<-function(p,N){
  #確率変数は、アタリの回数なので、0からN
  X<-0:N
  #二項係数
  bi<-choose(N,X)
  #積の法則
  seki<-(p^X)*((1-p)^(N-X))
  #確率質量関数を求める
  prob<-bi*seki
  plot(X,prob)
  return(prob)
  }

sum(binomplot(1/100000,200000)[1:10])
binomplot(0.3,100)
