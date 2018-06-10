#母集団は平均30 分散25　の正規分布
#n=10のサンプルをとる。
sampleave<-c()
samplevar<-c()
samplevar2<-c()
for (i in 1:10000){
  sample<-rnorm(10,30,5)
  ave<-mean(sample)
  sampleave[i]<-ave
  var<-sum((sample-ave)^2)/10
  var2<-sum((sample-ave)^2)/9
  samplevar[i]<-var
  samplevar2[i]<-var2
}
mean(sampleave)
mean(samplevar)
mean(samplevar2)

#平均には不偏性あり、分散には不偏性なし、不偏分散には不偏分散には不偏性あり
hist(sampleave)
#標本平均を１0０００回分ヒストグラムにすると、どうやら正規分布っぽいぞ
#正規分布を決めるのは平均（期待値）とsd
mean(sampleave)
sd(sampleave)
hoge<-function(x){10000*dnorm(x,mean(sampleave),sd(sampleave))}
curve(hoge,from=26,to=34,add=TRUE)
