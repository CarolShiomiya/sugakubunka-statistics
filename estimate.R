#区間推定を行う。
#母集団は[0,4]の一様分布とする。

#サンプルサイズ30の区間推定
n<-30
samp<-runif(n,0,4)
mean(samp)
sd(samp)

#95%信頼区間は
ep_left<-mean(samp)+qt(0.025,n-1)*(sd(samp)/sqrt(n))
ep_right<-mean(samp)+qt(0.975,n-1)*(sd(samp)/sqrt(n))
ep_left
ep_right


#95%信頼区間とは、得られたサンプルが「よくある95%」から発生したものと
#判断できるような母平均の区間である。
#それを検証するために、実際に区間内の値を母平均として1000回ずつサンプルを生成する。
samplemean<-c()
for (i in 1:1000){
  samptest<-runif(n,ep_left-2,ep_left+2)
  samplemean<-c(samplemean,mean(samptest))
}
hist(samplemean)
sum(samplemean<mean(samp))/length(samplemean)
