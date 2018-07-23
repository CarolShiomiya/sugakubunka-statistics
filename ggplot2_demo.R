#install.packages("ggplot2")
library(ggplot2)

data(mpg)
mpg
#ggplot 関数で軸を描いて、geom_barで棒を描いて、最後に調整
ggplot(data=mpg,mapping=aes(x=class,y=displ))+
  geom_bar(stat="summary",fun.y="mean")+ #statでデータを整形
  labs(x="車種",y="排気量平均")+
  ggtitle("車種の比較")　#+theme_gray(base_family = "HirakakuProN-W3") マック向


#各車種（class）ごとに排気量（displ）のヒストグラムを書きたい
ggplot(data=mpg,mapping=aes(x=displ,fill=class))+
  geom_histogram(binwidth=0.5)

#積み上げ型でないヒストグラムを作ろう
ggplot(data=mpg,mapping=aes(x=displ,color=class))+geom_histogram(binwidth=0.5)+facet_wrap(~class)


#geometry関数
#棒グラフ geom_bar x:離散y:連続
#ヒストグラム geom_histgram x:連続
#箱ひげ図 geom_boxplot x:離散　y:連続
ggplot(data=mpg,mapping=aes(x="",y=displ))+geom_boxplot()
#散布図　geom_point x:連続　y:連続
ggplot(data=mpg,mapping=aes(x=cty,y=displ))+geom_point()
#折れ線グラフ　geom_line x:連続　y:連続
#曲線当てはめ　geom_smooth x:連続　y:連続


#周辺パッケージ
#install.packages("plotly")　
library(plotly)　#ggplotでプロットしたものをオブジェクトにして、ggplotly(hoge)を実行。グラフにカーソルを合わせると…
hoge<-ggplot(data=mpg,mapping=aes(x=cty,y=displ))+geom_point()
ggplotly(hoge)

#install.packages("ggfortify")
library(ggfortify)
x<-1:20
y<-0.1*x+rnorm(20,0,1)
res<-lm(y~x)
plot(x,y)
abline(res)

fortify(res) #回帰モデルの予測値
str(res)

ggplot(data=fortify(res),aes(x=x,y=.fitted))+geom_line() #回帰直線のみを引く
ggplot(data=fortify(res),aes(x=x,y=.fitted))+geom_line()+geom_point(aes(x=x,y=y),colour="red") #さらに散布図のレイヤー