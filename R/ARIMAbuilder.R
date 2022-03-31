#' @title ARIMA/SARIMA model builder
#'
#' @description Lists the top 5 estimated ARIMA/SARIMA models of the form: ARIMA(p,d,q)x(P,D,Q), based on specified parameter values and ranges
#'
#' @param TS The time series to build the models upon (remember to transform before using this function!)
#' @param date The date vector
#' @param p The maximum AR value, estimated from plot analysis
#' @param d The fixed differencing, often 0, 1 or 2
#' @param q The maximum MA value, estimated from plot analysis
#' @param P The maximum seasonal AR value, estimated from plot analysis
#' @param D The fixed seasonal differencing, often 0, 1 or 2
#' @param Q The mazimum seasonal MA value, estimated from plot analysis
#' @param S The seasonality/period of the seasonal differencing
#' @return list of top 5 ARIMA/SARIMA models
#' @export

ARIMAbuilder <- function(TS,date,p=1,d=1,q=1,P=1,D=1,Q=1,S=12) {

# build ARIMA(p,d,q)x(P,D,Q)_S library:
arimalib_aic=array(dim=c(p+2,q+2,P+2,Q+2))
for(pp in 0:p){
  for(qq in 0:q){
    for(PP in 0:P){
      for(QQ in 0:Q){
        arimalib_aic[pp+1,qq+1,PP+1,QQ+1]=
          arima(TS,c(pp,d,qq),seasonal=list(order=c(PP,D,QQ),period=S))$nobs*
          log(arima(TS,c(pp,d,qq),seasonal=list(order=c(PP,D,QQ),period=S))$
                sigma2)+
          log(arima(TS,c(pp,d,qq),seasonal=list(order=c(PP,D,QQ),period=S))$
                nobs)*(pp+qq+PP+QQ+d+D)
        print(c(pp,d,qq,PP,D,QQ))

      }}}}
# five lowest AIC (edited to BIC)
arimalib_aic1=arimalib_aic[1:(p+1),1:(q+1),1:(P+1),1:(Q+1)]
AIC1=c()

order1_1=which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)-1
AIC1[1]=arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]
arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]=100000
order1_2=which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)-1
AIC1[2]=arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]
arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]=100000
order1_3=which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)-1
AIC1[3]=arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]
arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]=100000
order1_4=which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)-1
AIC1[4]=arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]
arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]=100000
order1_5=which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)-1
AIC1[5]=arimalib_aic1[which(arimalib_aic1==min(arimalib_aic1),arr.ind = TRUE)]
BIC1=AIC1

ORDERS=list("#1(p,q,P,Q)"=order1_1,"BIC1"=AIC1[1],"#2(p,q,P,Q)"=order1_2,"BIC2"=AIC1[2],"#3(p,q,P,Q)"=order1_3,"BIC3"=AIC1[3],"#4(p,q,P,Q)"=order1_4,"BIC4"=AIC1[4],"#5(p,q,P,Q)"=order1_5,"BIC5"=AIC1[5])

library(forecast) # Load forecasting package for illustration
forecasting=forecast(arima(TS,c(order1_1[1],d,order1_1[2]),seasonal=list(order=c(order1_1[3],D,order1_1[4]),period=S)),round(length(TS)/10))
forecasting_lower=forecasting$lower[,2]
forecasting_upper=forecasting$upper[,2]

plot(date,TS,ylim=c(min(TS,forecasting_lower,fitted(Arima(TS,c(order1_1[1],d,order1_1[2]),seasonal=list(order=c(order1_1[3],D,order1_1[4]),period=S)))[1:(length(TS)-round(length(TS)/10))]),max(TS,forecasting_upper,fitted(Arima(TS,c(order1_1[1],d,order1_1[2]),seasonal=list(order=c(order1_1[3],D,order1_1[4]),period=S)))[1:(length(TS)-round(length(TS)/10))])))
lines(date[1:(length(TS)-round(length(TS)/10))],fitted(Arima(TS,c(order1_1[1],d,order1_1[2]),seasonal=list(order=c(order1_1[3],D,order1_1[4]),period=S)))[1:(length(TS)-round(length(TS)/10))],col="red")
title("TS:Red, #1model:Black, Pred:Blue, 95% Conf.: Green")
forecasting_mean=forecasting$mean
abline(v=date[length(TS)-round(length(TS)/10)],col="red",lty=2)
lines(date[((length(TS)-round(length(TS)/10))+1):length(TS)],forecasting_mean,col="blue")
lines(date[((length(TS)-round(length(TS)/10))+1):length(TS)],forecasting_upper,col="green")
lines(date[((length(TS)-round(length(TS)/10))+1):length(TS)],forecasting_lower,col="green")
#legend(date[1], max(TS,forecasting_upper,fitted(Arima(TS,c(order1_1[1],d,order1_1[2]),seasonal=list(order=c(order1_1[3],D,order1_1[4]),period=S)))[1:(length(TS)-round(length(TS)/10))]), legend=c( "Limit of training data",
#                              "Predicted value","95% Prediction interval"),
#       col=c( "red","blue","green"),pch=c(NA,NA,NA),lty=c(2,1,1),
#       cex=0.8)





return(ORDERS)
}
