#母集団は平均30 分散25　の正規分布
#n=10,100,1000,10000,100000,1000000のサンプルをとる。

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

  hist(sampleave)
  #正規分布を決めるのは平均（期待値）とsd
  mean(sampleave)
  print(sd(sampleave))
  #hoge<-function(x){10000*dnorm(x,mean(sampleave),sd(sampleave))}
  #curve(hoge,from=26,to=34,add=TRUE)
}
