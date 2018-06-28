#数式の書き方
2*4
3^2
log(10000,10)
log(300,10)

#文字に対して代入することができる
x<-log(300,10)
y<-32

x+2
z<-x+y

#ベクトルの書き方
c(2,3,4)
c(80,99,90,40,60)

#ベクトルに対しての演算
japanese<-c(60,70,50,80,80,40,60)
japanese
math<-c(70,20,60,80,30,80,90)

#ベクトルの長さ
length(japanese)

#総和
sum(japanese)

#平均
mean(japanese)

#ベクトルの足し算
japanese+math
japanese-math
japanese*2
japanese*2+math

japanese*math
japanese/math

#国語の分散を出す
j_dev<-japanese-mean(japanese) #偏差
mean(j_dev^2)  #偏差の二乗

#3,4,5,6,7点の5人の分散は
class1<-c(3,4,5,6,7)
class2<-c(1,3,5,7,9)

dev1<-class1-mean(class1)
dev2<-class2-mean(class2)

var1<-mean(dev1^2)
var2<-mean(dev2^2)

#標準偏差は√をとる
sd1<-sqrt(var1)
sd2<-sqrt(var2)

#z得点化する
z1<-dev1/sd1
z2<-dev2/sd2

#ｚ得点の平均は必ず0、分散は必ず1になる
mean(z1)
dev_z1<-mean((z1-mean(z1))^2)
mean(z2)
dev_z2<-mean((z2-mean(z2))^2)
