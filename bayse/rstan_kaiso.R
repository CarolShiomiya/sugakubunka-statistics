#被説明変数がしたがう分布の母数が、説明変数に依存的な分布に従っているモデルを「階層モデル」という。

#例：各社員がもらう退職金金額を被説明変数として、
#各社員に説明変数として会社A,B,C,Dのいずれかと、勤続年数が与えられているとする。


#社員の退職金は、勤続年数の1次関数に個人固有の値を足したものであるが、1次関数の切片と係数は会社固有の値である。
#個人固有の値（いわゆる残差）はND(0,4^2)に従う。
kinzoku<-runif(100,5,20)
kaisha<-c(rep("A",25),rep("B",25),rep("C",25),rep("D",25))

#会社固有の回帰係数はND(10,1^2)に、会社固有の切片はND(20,5^2)に従う。
kaisha_keisu<-rnorm(4,10,1)
kaisha_seppen<-rnorm(4,20,5)

A_shain<-kinzoku[kaisha=="A"]*kaisha_keisu[1]+kaisha_seppen[1]+rnorm(25,0,4)
B_shain<-kinzoku[kaisha=="B"]*kaisha_keisu[2]+kaisha_seppen[2]+rnorm(25,0,4)
C_shain<-kinzoku[kaisha=="C"]*kaisha_keisu[3]+kaisha_seppen[3]+rnorm(25,0,4)
D_shain<-kinzoku[kaisha=="D"]*kaisha_keisu[4]+kaisha_seppen[4]+rnorm(25,0,4)
taishokukin<-c(A_shain,B_shain,C_shain,D_shain)

df<-data.frame(kinzoku,kaisha,taishokukin)
df

#このように会社固有の母数があり、それに基づき個々のデータポイントの被説明変数が分布しているとき、
#階層モデルを想定することになる。
#今回は”モデルづくり”を意識してもらうために、対話形式の教材を用意してみた。

#階層モデルを立案する過程で、データサイエンティストの太郎くんと花子さんは以下のような会話をしたであろう。
#新センター試験の数学でもこの対話形式の問題が多く採用されていて、名前は太郎&花子なので、
#本教材でもオマージュとして登場人物の名前を太郎くんと花子さんにした。「外伝で描かれる10年後」というやつだ。

#太郎くん「退職金金額がどのようなプロセスで生成されているかを考えてみましょう。」
#花子さん「まずはデータを見て、シンプルなモデルを考えるところから始めるのでしたね。データを見るには…」


##実際にやってみよう！
library(ggplot2)
qplot(data=df,x=kinzoku,y=taishokukin,colour=kaisha,geom="point")

#太郎くん「どうやら線形性があるようですね。まずは退職金は勤続年数の1次関数に個人固有の値が足されたものとして
#モデルを作ってみましょう。この場合、stanで母数を推定すると…」

##前回の復習となるが、stanコードを書いて母数を推定してみよう。

library(rstan)

yData<-list() #埋めてみよ
model <- "
data{
  real Kinzoku[100];
  real Taishoku[100];
}
parameters{
  real a1;
  real b;
  real<lower=0> sigma;
}
transformed parameters{
  real mu[100];
  for (i in 1:100)
    mu[i]=a1*Kinzoku[i]+b
}
model{
  for (j in 1:100)
    Taishoku[j]~normal(mu[j],sigma)
}

" #埋めてみよ

fit<-stan(
  model_code = model,
  data=yData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)
traceplot(fit)
stan_hist(fit)
fit


#花子さん「なかなか良い予測に思えます。次は会社の効果も勘案してみましょう。
#太郎くん「まずは会社ごとに散布図を描くところからですね」

##実際にやってみよう！


#花子さん「回帰係数が会社によって異なっているようですね。」
#太郎くん「退職金システムは会社によって分布していると言うことですね。つまり、階層モデルを想定するのが
#　良いかと思います。」
#花子さん「回帰係数が従うのはとりあえず正規分布と仮定しましょうか。
#　今回は4社しかないので、母数分布をあれこれ考えても仕方がないですが、将来的に会社数が増えれば
#　かなり有用なモデルが作れそうです、」
#太郎くん「そうですね、会社数が増えたらその時にモデルを再検討しましょう。」
#花子さん「どのようにしてstanコードを書きましょう」
#太郎くん「まずは回帰係数8つ（2個*4社）と個人固有の残差の標準偏差σの合計9つを推定するモデルを作ります」
#花子さん「一旦各社員の回帰係数のベクトルを作ると良さそうですね。」
#太郎くん「ええ、先にホワイトボード・コーディングをしてから書き始めるのが良いですね」

##実際にやってみよう。コンパイルはまだしなくてよい。以下の空欄を埋めよう。

parameters{
  real a1;
  real a2;
  real b1;
  real b2;
}

model{
  //A社分
  
  //B社分
}

kaisha<-c(rep(1,25),rep(2,25),rep(3,25),rep(4,25))
kaisha

#花子さん「できましたね。ここでx1,x2がそれぞれ正規分布から取り出されていることをmodelに付け加えれば良いのですね」
#太郎くん「各社のそれぞれの回帰係数を4次元ベクトルにしたものを vector[4] x1;,vector[4] x2;で定義しましょう。」
#花子さん「x1とx2が従う正規分布の母数はそれぞれmu1,sigma1,mu2,sigma2としましょう。これも書かないとですね」
model<-
"data{
  int N;
  real Kinzoku[N];
  real Taishokukin[N];
  int Kaisha_ID[N];
}
parameters{
  real mu1;
  real mu2;
  real<lower=0> sigma1;
  real<lower=0> sigma2;
  real a[4];
  real b[4];
  real<lower=0> kojin_sigma;
}
model{
  for (i in 1:4)
    a[i]~normal(mu1,sigma1);
  for (i in 1:4)
    b[i]~normal(mu2,sigma2);
  for (j in 1:N)
    Taishokukin[j]~normal(a[Kaisha_ID[j]]*Kinzoku[j]+b[Kaisha_ID[j]],kojin_sigma);
}"


#太郎くん「では、早速モデルをコンパイルして母数を推定してみましょう。」

##適切な形でデータを渡してMCMCを走らせてみよ。前回までの教材を参照しよう。
kaishaid=rep(1:4,each=25)
kaishaid
yData=list("N"=100,"Kinzoku"=df$kinzoku,"Taishokukin"=df$taishokukin,"Kaisha_ID"=kaishaid)


fit<-stan(
  model_code = model,
  data=yData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)
traceplot(fit)
stan_hist(fit)
fit






#演習

#通販サイトのユーザー1〜100がいる。ユーザーがどのような間隔でサービスを使うかを調査しよう。
#それぞれのユーザーの購入間隔は、ユーザー固有の母数λ（ユーザー）を持つ指数分布に従うというモデルを考える。
#λはgamma(2,0.5)に従うとする。

#問1　この仮定に従うデータを作成せよ。
#Y 購入間隔。各ユーザーにつき10件、合計1000件。
#X ユーザーid。1,2,3...100がそれぞれ10回ずつ繰り返される。
#これらが実際に観測されるデータである。

lamda=rgamma(100,2,0.5)
kankaku=c()
userid=c()
for (user in 1:100){
  kankaku=c(kankaku,rexp(10,lamda[user]))
  userid=c(userid,rep(user,10))
}
rep(1:10,each=10)
lamdahat<-c()

library(dplyr)
df <- group_by(, Species)

#問2　母数を推定し、1で使用した母数と一致しているかを確認しよう。
model<-"
data{
  real Kankaku[1000];
  int Userid[1000];
}
parameters{
  real <lower=0> alpha;
  real <lower=0> beta;
}
model{
  real lamda[100];
  for (i in 1:100)
    lamda[i]~gamma(alpha,beta);
  for(j in 1:1000)
    Kankaku[j]~exponential(lamda[Userid[j]]);
}"
yData<-list("Kankaku"=kankaku,"Userid"=userid) #埋めてみよ
library(rstan)
fit<-stan(
  model_code = model,
  data=yData,
  iter=1100,
  warmup=100,
  thin=1,
  chains=3)
traceplot(fit)
stan_hist(fit)
fit




#元ネタ：この問はパレートNBDモデルを簡単にしたものだ。
#パレートNBDモデルでは、客が買い物の度に一定の確率p（ユーザー）で「もう使わんわこのサービス」となることを勘案している。
#皆さんも心当たりがあるだろうが、月額会費がない通販サービスの場合、二度と使わないと決意してもアカウントを消して
#サービスを去ることは少ないだろう。したがって、サービスをやめたことを観測者は知れないのだ。
#その上で、ユーザーがどのくらいの期間継続利用してくれるかを推定する目的で構築されるモデルだ。