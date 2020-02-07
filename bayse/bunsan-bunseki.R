df<-read.csv("3-6-1-beer-sales-3.csv")
head(df)
library(ggplot2)
ggplot(data=df, mapping=aes(x=weather,y=sales))+
  geom_violin() +
  geom_point((aes(color=weather)))

library(brms)
anova <- brm( formula = sales ~ weather,
              family = gaussian(),
              data = df)
anova
eff <- marginal_effects(anova)
eff


lmmodel<-lm(sales~weather,df)
summary(lmmodel)


##
df$odd<-rep(c("Odd","Even"),75)
df
anova2 <- brm( formula = sales ~ weather+odd,
              family = gaussian(),
              data = df)
anova2
eff2 <- marginal_effects(anova2)
eff2


##
anova3 <- brm( formula = sales ~ weather * odd,
               family = gaussian(),
               data = df)
anova3
eff3 <- marginal_effects(anova3)
eff3
