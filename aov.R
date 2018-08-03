#分散分析をしてみよう。
a<-c(64,72,68,77,56,95)
b<-c(75,93,78,65,55)
c<-c(78,91,97,82,82,78,95)
mean(a)
mean(b)
mean(c)

#群内平方和
a_gunnai<-sum((a-mean(a))^2)
b_gunnai<-sum((b-mean(b))^2)
c_gunnai<-sum((c-mean(c))^2)
sq_gunnai<-a_gunnai+b_gunnai+c_gunnai
df_gunnai<-(length(a)-1)+(length(b)-1)+(length(c)-1)
var_gunnai<-sq_gunnai/df_gunnai

#群間平方和
zentai<-mean(c(a,b,c))
sq_gunkan<-(mean(a)-zentai)^2*length(a)+(mean(b)-zentai)^2*length(b)+(mean(c)-zentai)^2*length(c)
df_gunkan<-2
var_gunkan<-sq_gunkan/df_gunkan

#F検定統計量
f<-var_gunkan/var_gunnai

#fの帰無分布
h0_dist<-function(x){df(x,df_gunkan,df_gunnai)}
curve(h0_dist,from=0,to=10)

#p値
1-pf(f,df_gunkan,df_gunnai)

#帰無仮説は棄却されない。