logit<-function(x){return(log(x/(1-x)))}
curve(logit,from=0.01,to=0.99)

logit(0.3)
