a<-1:34
a2<-a/35
x<-qnorm(a2)
y=1:34
plot(x,y)

y<-rnorm(34,0,1)
y2<-sort(y)
plot(x,y2)

y<-runif(34,-1,1)
y3<-sort(y)
plot(x,y3)
hoge<-function(x){y=x}
curve(hoge,add=TRUE)
