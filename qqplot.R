a<-1:34
a2<-a/35
x<-qnorm(a2)
y=1:34
plot(x,y)

y<-rnorm(34,0,1)
y2<-sort(y)
plot(x,y2)
