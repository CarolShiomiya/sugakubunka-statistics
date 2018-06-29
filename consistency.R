#母集団は平均30 分散25　の正規分布
#n=10,100,1000,10000,100000,1000000のサンプルをとる。
sampleave<-c()
samplevar<-c()
samplevar2<-c()
for (i in 1:6){
  sample<-rnorm(10^i,30,5)
  ave<-mean(sample)
  sampleave[i]<-ave
  var<-sum((sample-ave)^2)/(10^i)
  var2<-sum((sample-ave)^2)/(10^i-1)
  samplevar[i]<-var
  samplevar2[i]<-var2
}

plot(sampleave)
hoge<-function(x){y=30+x*0}
curve(hoge,from=1,to=6,add=TRUE,col="red")

plot(samplevar)
hoge<-function(x){y=25+x*0}
curve(hoge,from=1,to=6,add=TRUE,col="red")

plot(samplevar2)
curve(hoge,from=1,to=6,add=TRUE,col="red")

#平均には一致性あり、分散には一致性あり、不偏分散には一致性あり