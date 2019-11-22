localLevelModel_1<-"
  data{
    int n;
    vector[n] Nile;
  }
  parameters{
    real mu;
    real<lower=0> sigmaV;
  }
  model{
    for(i in 1:n){
      Nile[i]~normal(mu,sqrt(sigmaV));
    }
  }
"
Nile
NileData<-list(Nile=as.numeric(Nile),n=length(Nile))
NileData
set.seed(1)
Nilemodel1<-stan(
  model_code = localLevelModel_1,
  data=NileData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)

Nilemodel1
traceplot(Nilemodel1)
stan_hist(Nilemodel1)
