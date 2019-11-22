RealMu<-300
measure<-rnorm(1000,RealMu,30)
Observed<-c()
for(i in 1:1000){
  Observed[i]<-rnorm(1,measure[i],3)}
Observed
Observed<-list(Observed=as.numeric(Observed),n=length(Observed))


Observed
set.seed(1)


localLevelModel_1<-"
  data{
int n;
vector[n] Observed;
}
parameters{
real mu;
real<lower=0> val;
vector[n] theta;
}
model{
for(i in 1:n)
  theta[i]~normal(mu,val);
for(i in 1:n)
  Observed[i]~normal(theta[i],3);

}
"
model<-stan(
  model_code = localLevelModel_1,
  data=Observed,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)


model
traceplot(model)
stan_hist(model,"val",binwidth=2)
