#主成分分析をしよう

# Carパッケージをインストール（インストール済みの場合は実行不要）
#install.packages("car")
# Carパッケージを読み込み
library("car")
#身長や体重のデータを持ってくる
data(Davis) 
davis<-Davis
davis$height<-davis$height/100
plot(davis[,2:3])

#多分エラー
davis[davis$weight>160,]

#除外
davis<-davis[davis$weight<160,]


#目的：身長と体重を線形結合して、体格の指標を作ってみよう。

#まずは本当のBMIを求める
BMI<-davis$weight/((davis$height)^2)
davis$BMI<-BMI
BMI
plot(davis[,2:3]) #身長体重のプロット

pca<-prcomp(davis[,2:3],scale=T) #主成分分析
pca #主成分得点の係数など
head(pca$x) #主成分得点
biplot(pca)

#主成分の軸を書く
line<-function(x){
  return( (pca$rotation[1,1]/pca$rotation[2,1])*x)}

#install.packages("ggplot2")
library(ggplot2)

davis$z_height<-scale(davis$height)
davis$z_weight<-scale(davis$weight)
g <- ggplot(davis, aes(x = z_weight, y = z_height,colour=davis$BMI))
g <- g + geom_point()
g <- g + stat_function(fun=line)
plot(g)

plot(pca$x[,2],davis$BMI)
cor(pca$x[,2],davis$BMI)

#あまりBMIっぽくないな？
davis$lnweight<-log(davis$weight)
davis$lnheight<-log(davis$height)

pca2<-prcomp(data.frame(davis$lnweight,davis$lnheight),scale=T) #主成分分析
pca2 #主成分得点の係数など
head(pca2$x) #主成分得点
var((pca2$x))

biplot(pca2)

#主成分の軸を書く
line2<-function(x){
  return((pca2$rotation[1,1]/pca2$rotation[2,1])*x)}

#install.packages("ggplot2")
library(ggplot2)

davis$z_lnweight<-scale(davis$lnweight)
davis$z_lnheight<-scale(davis$lnheight)
g <- ggplot(davis, aes(x = z_lnweight, y = z_lnheight,colour=davis$BMI))
g <- g + geom_point()
g <- g + stat_function(fun=line2)
plot(g)

plot(pca2$x[,2],davis$BMI)
cor(pca2$x[,2],davis$BMI)
