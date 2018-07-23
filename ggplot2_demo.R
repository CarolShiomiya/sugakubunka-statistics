#install.packages("ggplot2")
library(ggplot2)

data(mpg)
mpg
#ggplot 関数で軸を描いて、geom_barで棒を描いて、
ggplot(data=mpg,mapping=aes(x=class,y=displ))+
  geom_bar(stat="summary",fun.y="mean")+
  labs(x="車種",y="排気量平均")+
  ggtitle("車種の比較")　#+theme_gray(base_family = "HirakakuProN-W3") マック向


#各車種（class）ごとに排気量（displ）のヒストグラムを書きたい
ggplot(data=mpg,mapping=aes(x=displ,fill=class))+
  geom_histogram(binwidth=0.5)

#積み上げ型でないヒストグラムを作ろう
ggplot(data=mpg,mapping=aes(x=displ,color=class))+geom_histogram(binwidth=0.5)+facet_wrap(~class)
