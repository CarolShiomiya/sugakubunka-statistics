x<-runif(100,0,10)
y<-x+rnorm(100,0,2)
plot(x,y)
cov(x,y)
cov(x,y)/sqrt(var(x)*var(y))

x1<-10*x
plot(x1,y)
cov(x1,y)
cov(x,y)/sqrt(var(x)*var(y))

x2<--x
plot(x2,y)
cov(x2,y)
plot(x*100,y*100)
cov(x*100,y*100)


y2<-x+rnorm(100,0,90)
plot(x,y2)
cov(x,y)

var(scale(x))

omote<-0:100
kakuritu<-choose(100,omote)*(0.01^omote)*(0.99^(100-omote))
kakuritu
plot(omote,kakuritu)
sum(kakuritu)
