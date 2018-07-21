#時系列データ

x<-c(20,23,25,26,28,31,33,35,40) #単に増えていくだけの時系列データ
plot(x,type="b")
x1<-x[2:length(x)] #１期ずらし
cor(x1,x[1:length(x1)]) 


y<-c(30,10,32,11,33,4,51,15,30)　#高低が交互に来る時系列データ
plot(y,type="b")
y1<-y[2:length(y)]　#１期ずらし
y1
plot(y1,y[1:length(y1)])
cor(y1,y[1:length(y1)])

y2<-y[3:length(y)]　#2期ずらし
y2
plot(y2,y[1:length(y2)])
cor(y2,y[1:length(y2)])


#12期周期の時系列データ
t<-1:100
z<-10*sin(2*pi*t/12)+rnorm(100,mean=0,sd=1.5)
plot(z,type="b")
acf(z)　#コレログラムを描く
z1<-z[13:length(z)]
z
head(z1)
plot(z1,z[1:length(z1)])
cor(z1,z[1:length(z1)])

z2<-z[7:length(z)]
z
head(z2)
plot(z2,z[1:length(z2)])
cor(z2,z[1:length(z2)])

z3<-z[4:length(z)]
z
head(z3)
plot(z3,z[1:length(z3)])
cor(z3,z[1:length(z3)])

z4<-z[10:length(z)]
z
head(z4)
plot(z4,z[1:length(z4)])
cor(z4,z[1:length(z4)])
pacf(z) #偏自己相関プロットを求める。


