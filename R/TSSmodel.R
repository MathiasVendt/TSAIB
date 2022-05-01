#' @title Time Series model (simple constant + trend + sinus + cosine)
#'
#' @description Estimates a simple time series model
#'
#' @param TS The time series for the TSSmodel function
#' @param date The time axis in the time series (dates, seconds, intervals)
#' @param testsize The number of data points to be used for testing the model
#' @param p The period. e.g.: p=12, for 12 months in a year
#' @param t The time steps. e.g.: t=1, for monthly time steps, with period 12
#' @return Simple TS model
#' @export

TSSmodel <- function(TS,date,p=12,t=1,testsize=round(length(date)/10)) {

  # first the vectors for the design matrix is made
alpha=matrix(1,length(TS),1)  # constant vector
beta_t=1:length(TS)           # time trend
beta_s=sin(2*pi*(1:length(TS))/p) # sinus vector
beta_c=cos(2*pi*(1:length(TS))/p) # cosine vector

# now we have all the vectors needed for our model matrix, which we need to make
x=cbind(alpha,beta_t,beta_s,beta_c)

# Now the test and training sets are defined
Y_train=TS[1:(end(TS)[1]-testsize)]
Y_test=TS[(end(TS)[1]-testsize+1):end(TS)[1]]

x_train=x[1:length(Y_train),]
x_test=x[(length(Y_train)+1):length(TS),]

Y=c(Y_train,Y_test)
#now we can find our parameter estimates as:
theta_hat=solve(t(x_train)%*%x_train)%*%t(x_train)%*%Y_train

# now we plot the model to see if it's reasonable
yhat=x_train%*%theta_hat
#plot(yhat)

# now we determine estimator of the variance sigma_hat (3.44 in Madsen)
# since this is unweighted, the Sigma is the identity matrix, hence:
S_theta_hat=t(Y_train-x_train%*%theta_hat)%*%(Y_train-x_train%*%theta_hat)
N=length(TS) # number of observations
P=4 # number of theta parameters
sigma2_hat=S_theta_hat/(N-P)
sigma_hat=sqrt(sigma2_hat)

# now we predict the test period
# for this we need the test x

# first we allocate space
yhat_pred=c(0,0,0,0)

# then we run a for loop to get the last "testsize" predictions
for(i in 1:testsize){
  yhat_pred[i]=x_test[i,]%*%theta_hat
}
yhat_wpred=c(yhat,yhat_pred)
#plot(yhat_wpred)
# and variance of prediction error

Var_pred=var(Y_test-yhat_pred)
sqrt(Var_pred)

# We need to determine our confidence interval for future Y, also called a prediction interval
# we do this from equation 3.61 in Madsen
t.val <- qt(0.975, N - 2) # t value
#allocating space
pred_up=c(0,0,0,0,0,0,0)
pred_low=c(0,0,0,0,0,0,0)
for(i in 1:testsize){
  pred_up[i]=yhat_pred[i]+t.val*sqrt(Var_pred)
  pred_low[i]=yhat_pred[i]-t.val*sqrt(Var_pred)
}

plot(date,Y,xlab="Date",ylab="Measurement",main='TS')

# for all data:
pred_up_full=c()
pred_low_full=c()
for(i in 1:length(TS)){
  pred_up_full[i]=yhat[i]+t.val*sqrt(Var_pred)
  pred_low_full[i]=yhat[i]-t.val*sqrt(Var_pred)
}
lines(date[(end(TS)[1]-testsize+1):end(TS)[1]],yhat_pred,col="red")
lines(date[1:length(yhat)],yhat,col="red")
lines(date[1:length(TS)],pred_up_full,col="green")
lines(date[1:length(TS)],pred_low_full,col="green")
lines(date[(end(TS)[1]-testsize+1):end(TS)[1]],pred_up,col="green")
lines(date[(end(TS)[1]-testsize+1):end(TS)[1]],pred_low,col="green")
legend(date[1],max(TS), legend=c("Measurements", "Estimates","95% CI"),
       col=c("black", "red","green"), lty=c(1,1,1), cex=0.8)


print("Parameter estimates:")
print("alpha")
print(theta_hat[1])
print("beta_t (trend)")
print(theta_hat[2])
print("beta_s (sinus)")
print(theta_hat[3])
print("beta_c (cosinus)")
print(theta_hat[4])

}
