#include <TMB.hpp>
template<class Type>
bool isNA(Type x){
  return R_IsNA(asDouble(x));
}
template<class Type>
  Type objective_function<Type>::operator() ()
{
  DATA_VECTOR(y);
  DATA_IVECTOR(timeindex);
  PARAMETER(logSdRw);
  PARAMETER(logSdObs);
  PARAMETER(lam0);
  PARAMETER_VECTOR(lam);
  int timeSteps=y.size();
  Type sdRw=exp(logSdRw);
  Type sdObs=exp(logSdObs);
  Type ans=-dnorm(lam(0),lam0,sdRw,true);
  for(int i=1;i<lam.size();i++){
    ans+=-dnorm(lam(i),lam(i-1),sdRw,true);
  }
  for(int i=0;i<timeSteps;i++){
    if(!isNA(y(i))){
    ans+=-dnorm(y(i),lam(timeindex(i)),sdObs,true);
   }
   }
   return ans;
   }
