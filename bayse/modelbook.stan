data{
  int N;
  real Y[N]; //発売日からの日ごとの売上冊数
}

transformed data{
  real Accum[N-1]; 
  Accum[1]=Y[1];
  for (n in 2:(N-1))
    Accum[n]=Accum[n-1]+Y[n-1]; //累積売上冊数（潜在顧客のうち、まだ買ってない人が減少する分である）
}

parameters {
  real<lower=0,upper=1> p; //母数pは区間[0,1]
  real<lower=0,upper=1000> senzai; //潜在顧客数は
}

model{
  Y[1] ~ normal(senzai*p,sqrt(senzai*p*(1-p))); //初日は潜在顧客全員が買う可能性あり
  for (n in 2:N) //2日目以降は潜在顧客からもう買った人を引いた分が買う可能性あり
    Y[n] ~ normal( (senzai-Accum[n-1])*p,sqrt((senzai-Accum[n-1])*p*(1-p)) );
}
