a<-1:34
a
a2<-a/35
a2
x<-qnorm(a2) #正規分布していた場合の、ｚ得点（低い順に並べた）
x
y<-scale(1:34) #本当の得点を低い順番に並べたものをz得点化
plot(x,y) #本当の得点が正規分布に近ければ、y=xの直線上に並ぶはずだ。 

y<-rnorm(34,0,1)
y2<-sort(y)
plot(x,y2)

y<-runif(34,-1,1)
y3<-scale(sort(y))
plot(x,y3)
hoge<-function(x){y=x}
curve(hoge,add=TRUE)
