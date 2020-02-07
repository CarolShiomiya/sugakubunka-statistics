ts<-c(20,15,30)
for (i in 1:1000){
  ts<-c(ts,0.8*rev(ts)[1]-0.3*rev(ts)[2]+0.1*rev(ts)[3]+rnorm(1,0,1))}
ts
plot(ts)
plot(ts[10:100],type = "l")
help(plot)
acf(ts[10:100])
pacf(ts[10:1000])

ts2<-c()
eps<-rnorm(1000,0,1)
for (i in 1:997){
  ts2<-c(ts2,eps[i+2]*10+eps[i+1]*(-5)+eps[i]*7)
}
plot(ts2,type="l")
acf(ts2)
pacf(ts2)
