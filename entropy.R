#Yes,Noの確率をベクトルc(x,1-x)で入力する。
#このとき、獲得する情報量の期待値を出力する関数を定義せよ。



entropy<-function(vec){
  jouhou<-log(1/vec,2)
  expectation <-sum(vec*jouhou)
  return(expectation)
}

binary<-function(x){
  vec<-c(x,1-x)
  # return(entropy(vec))
}

plot(seq(0, 1, length=500) ,binary(seq(0.01, 0.99, length=500) ))
