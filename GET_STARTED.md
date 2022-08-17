# Getting Started

## Installation
In the following, we describe the requirements of and installation steps of the package. 

### Requirements
In order to use and install this R package, ensure that R (≥ 3.2) is installed.

### Installation via remotes
This package can be installed in R by using the package remotes and the following commands:

```
install.packages("remotes")
remotes::install_url(url="https://github.com/DescartesResearch/ForecastBenchmark/archive/master.zip", INSTALL_opt= "--no-multiarch")
```

## Example Usage
In order to evaluate forecasting methods in an automatic manner, the user have to specify how and for which use case the forecasting method in question should be evaluated. An live-demo of running the benchmark is available at [CodeOcean](https://doi.org/10.24433/CO.3240518.v1).

An example code to execute the ForecastBenchmark is depicted in the following:
```
library(ForecastBenchmark)

forecaster <- function(ts,h){
  model <- naive(ts)
  values <- forecast(model,h=h)$mean
  return(values)
}

benchmark(forecaster,usecase="economics",type="one")
```
The inputs and output for this benchmark are described in the next sections.

## Inputs

In the following the essential inputs are explained. Optional parameters are explained in the [Documentation](documentation/DOCUMENTATION.md#inputs-and-parameters). 

### Forecasting Method

In order to benchmark a certain forecasting method, this method needs to implement the following interface
```
function(ts,h){
  ...
}
```
with
* ts (a time series object as input) and
* h (a number representing the horizon as input);
and to return the forecast values either as a vector or a time series object with length h.

An example code for a forecasting method implementing the interface is depicted in the following:
```
forecaster <- function(ts,h){ 
  first <- ts[1]
  last <- ts[length(ts)]
  slope = (last - first)/length(ts)
  forecast <- last + (1:h)*slope
  return(forecast)
}
``` 

### Use Case
The benchmark offers four different use cases for with the method can be evaluated. Here, the user have to choose between
* economics (gas, sales, unemployment, etc.), 
* finance (stocks, sales prices, exchange rate, etc.),
* human (calls, web requests, batch requests, etc.), and
* nature (rain, birth, death, etc.).

A more detailed describtion of the use cases can be found in the [Documentation](documentation/DOCUMENTATION.md#use-cases). 

### Evaluation Type
The "how to forecasting method should be evaluated" is specified by the type of the evaluation. Here, the user have to choose between
* one (one-step-ahead forecast, i.e., forecasting only the last value), 
* multi (multi-step-ahead forecast, i.e., forecasting several values at once), and
* rolling (rolling-origin forecast, i.e., the time series equivalent of cross-validation). 

## Output
The benchmark returns the seven meaures (each average and stand deviation) to quantify the forecasting method. In addition, the benchmark also gives these measures for state-of-the-art methods that have already been benchmarked and saved. The considered measures are:
* Normalized Time: The normalized time-to-result. Normalization is performed using a naive forecasting method executed in the background.
* Symmetrical Mean Absolute Percentage Error: A percentage based accuracy measure of the forecast.
* Mean Absolute Scaled Error: An accuracy measure of the forecast that is scaled by a baseline.
* Mean Under-Estimation Share: The percentage of forecast values that underestimate the actual values.
* Mean Over-Estimation Share: The percentage of forecast values that overestimate the actual values.
* Mean Under-Accuracy Share: The accuracy in terms of underestimation the actual values.
* Mean Over-Accuracy Share: The accuracy in terms of overestimation the actual values.

The mathematical definitions of the measures can be found in the [Documentation](documentation/DOCUMENTATION.md#measures). 
 
