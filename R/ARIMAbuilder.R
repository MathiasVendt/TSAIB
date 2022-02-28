#' @title ARIMA/SARIMA model builder
#'
#' @description Lists the top 5 estimated ARIMA/SARIMA models of the form: ARIMA(p,d,q)x(P,D,Q), based on specified parameter values and ranges
#'
#' @param TS The time series to build the models upon (remember to transform before using this function!)
#' @param p The maximum AR value, estimated from plot analysis
#' @param d The fixed differencing, often 0, 1 or 2
#' @param q The maximum MA value, estimated from plot analysis
#' @param P The maximum seasonal AR value, estimated from plot analysis
#' @param D The fixed seasonal differencing, often 0, 1 or 2
#' @param Q The mazimum seasonal MA value, estimated from plot analysis
#' @param S The seasonality/period of the seasonal differencing
#' @return list of top 5 ARIMA/SARIMA models
#' @export

ARIMAbuilder <- function(TS,p,d,q,P,D,Q,S) {

# build ARIMA(p,1,q)x(P,1,Q)_7 library: max 1,8,1,1
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

ORDERS=list("#1(p,q,P,Q)"=order1_1,"AIC1"=AIC1[1],"#2(p,q,P,Q)"=order1_2,"AIC2"=AIC1[2],"#3(p,q,P,Q)"=order1_3,"AIC3"=AIC1[3],"#4(p,q,P,Q)"=order1_4,"AIC4"=AIC1[4],"#5(p,q,P,Q)"=order1_5,"AIC5"=AIC1[5])
#ORDERS=list(order1_1,"AIC1"=AIC1[1],order1_2,"AIC2"=AIC1[2],order1_3,"AIC3"=AIC1[3],order1_4,"AIC4"=AIC1[4],order1_5,"AIC5"=AIC1[5])
return(ORDERS)
}
