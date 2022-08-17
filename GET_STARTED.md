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

## Getting Started
In order to evaluate forecasting methods in an automatic manner, the user have to specify how and for which use case the forecasting method in question should be evaluated. An live-demo of running the benchmark is available at [CodeOcean](https://doi.org/10.24433/CO.3240518.v1).

### Example Usage
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

### Inputs

#### Forecasting Method

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

#### Use Case
The benchmark offers four different use cases for with the method can be evaluated. Here, the user have to choose between
* economics (gas, sales, unemployment, etc.), 
* finance (stocks, sales prices, exchange rate, etc.),
* human (calls, web requests, batch requests, etc.), and
* nature (rain, birth, death, etc.).
A more detailed describtion of the use cases can be found in the [Documentation](DOCUMENTATION.md). 

#### Evaluation Type
The "how to forecasting method should be evaluated" is specified by the type of the evaluation. Here, the user have to choose between
* one (one-step-ahead forecast, i.e., forecasting only the last value), 
* multi (multi-step-ahead forecast, i.e., forecasting several values at once), and
* rolling (rolling-origin forecast, i.e., the time series equivalent of cross-validation). 

### Output

