#stanで線形回帰モデルのベイズ推定をやってくれるパッケージbrms
install.packages("brms")
library(brms)

#mtcarsデータを使用.32台の車のスペックが書かれている
data(mtcars)
mtcars
mtcars$am <- as.factor(mtcars$am)

#Rの組み込みのlm関数で回帰
fit <- lm(mpg ~ wt * am + wt*hp, data = mtcars)
summary(fit)

#brmsで回帰
fit_brm <- brm(mpg ~ wt * am, #回帰式。wtとamとwt*amの3つの係数と定数項
           family = "normal", #εの分布がND
           data = mtcars, #使うデータ
           iter = 2000,
           warmup = 1000,
           chain = 2)

fit_brm
summary(fit_brm)
waic(fit_brm)

#事前分布の変更
get_prior(mpg ~ wt * am *hp, data = mtcars) #modelに対応するデフォルト？
#stanコードを見る
make_stancode(mpg ~ wt * am *hp,
              data = mtcars,
              prior = c(prior(normal(0, 10), class = b),
                        prior(student_t(3, 19, 10), class = Intercept),
                        prior(student_t(3, 0, 10), class = sigma)
              )
)
make_standata(mpg ~ wt * am * hp,mtcars)

#回帰の結果を見る
conditional_effects(fit_brm)
mcmc_plot(fit_brm)
#MCMCサンプリングのヒストグラム
plot(fit_brm)

#brmsで作ったモデルを用いた予測
testdata<-data.frame("wt"=c(3.21,2.22),"am"=c(1,0))
testdata
fitted(fit_brm,testdata)
#predict(fit_brm,testdata)

#実際にサンプリングを行って予測値を計算（generated_quantitiesに相当）しているわけではない
