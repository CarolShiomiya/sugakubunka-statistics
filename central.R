#中心極限定理を確認しよう。

#母集団は平均30 分散25　の正規分布
#n=10,100,1000,10000,100000のサンプルをそれぞれ1000回抽出する。
#当たり前だが1000回標本抽出すると、標本平均は1000個できる。
#標本平均の分布をヒストグラムにした。
par(mfrow = c(2,3))

for (j in 1:5){
  size=10^j
  sampleave<-c()
  samplevar<-c()
  samplevar2<-c()
  for (i in 1:1000){
    sample<-rnorm(size,30,5)
    ave<-mean(sample)
    sampleave[i]<-ave
    var<-sum((sample-ave)^2)/size
    var2<-sum((sample-ave)^2)/(size-1)
    samplevar[i]<-var
    samplevar2[i]<-var2
  }
  mean(sampleave)
  mean(samplevar)
  mean(samplevar2)
  name<-paste("sample size=",10^j)
  hist(sampleave,seq(20,40,1/sqrt(10^(j-1))),main=name)
  legend("topright",paste("sd=",round(sd(sampleave),3)))
  #正規分布を決めるのは平均（期待値）とsdである
  mean(sampleave)
  hoge<-function(x){1000*(1/sqrt(10^(j-1)))*dnorm(x,mean(sampleave),sd(sampleave))}
  curve(hoge,from=26,to=34,add=TRUE,col="red") #正規分布のグラフを重ねて描く
}

#0.3の確率で１、0.7の確率で０となる母集団

par(mfrow = c(2,3))

for (j in 1:5){
  size=10^j
  sampleave<-c()
  samplevar<-c()
  samplevar2<-c()
  for (i in 1:1000){
    sample<-(runif(size,0,1)<0.3)*1
    ave<-mean(sample)
    sampleave[i]<-ave
    var<-sum((sample-ave)^2)/size
    var2<-sum((sample-ave)^2)/(size-1)
    samplevar[i]<-var
    samplevar2[i]<-var2
  }
  mean(sampleave)
  mean(samplevar)
  mean(samplevar2)
  name<-paste("sample size=",10^j)
  hist(sampleave,main=name)
  legend("topright",paste("sd=",round(sd(sampleave),3)))
  #正規分布を決めるのは平均（期待値）とsdである
  mean(sampleave)
  hoge<-function(x){1000*(1/sqrt(10^(j-1)))*dnorm(x,mean(sampleave),sd(sampleave))}
  curve(hoge,from=26,to=34,add=TRUE,col="red") #正規分布のグラフを重ねて描く
}
