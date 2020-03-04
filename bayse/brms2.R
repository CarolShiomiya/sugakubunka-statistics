#brmsでポアソン回帰をしよう
library(brms)

#データ読み込み
fish<-read.csv("3-8-1-fish-num-1.csv")
head(fish)

library(ggplot2)
ggplot(data = fish,
       mapping = aes(x = temperature, y = fish_num) )+ 
      geom_point(aes(color = weather))


#fish_num（釣れた魚の数）を、天気と気温を用いて予測しよう

#brmsで回帰
fit_brm <- brm(fish_num ~ weather + temperature, #回帰式。wtとamとwt*amの3つの係数と定数項
               family = "poisson", #εの分布がND
               data = fish, #使うデータ
               iter = 2000,
               warmup = 1000,
               chain = 2)

fit_brm
summary(fit_brm)

#信用区間
eff <- conditional_effects(fit_brm, effects= "temperature:weather")
plot(eff,points = TRUE)

#stanコードを見る
make_stancode(fish_num ~ weather + temperature,
              data = fish,
              family = "poisson"
              )

#回帰の結果を見る
conditional_effects(fit_brm)
mcmc_plot(fit_brm)
#MCMCサンプリングのヒストグラム
plot(fit_brm)

#brmsで作ったモデルを用いた予測
testdata<-data.frame("weather"=c("cloudy","sunny"),"temperature"=c(1,20))
testdata
fitted(fit_brm,testdata)
#predict(fit_brm,testdata)



#ロジスティック回帰
