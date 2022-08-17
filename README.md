# ForecastBenchmark

Libra, a forecasting benchmark, automatically evaluates and ranks forecasting methods based on their performance in a diverse set of evaluation scenarios. The benchmark comprises four different use cases, each covering 100 heterogeneous time series taken from different domains. 

A live-demo for using the benchmark is hosted at [CodeOcean](https://doi.org/10.24433/CO.3240518.v1). 

The assembled dataset for this benchmark, which includes 400 time series, is incorporated in this package and is additionally publicly available at [Zenodo](http://doi.org/10.5281/zenodo.4399959).

## Cite Us

The forecast benchmark was first published in Proceedings of the 12th ACM/SPEC International Conference on Performance Engineering (ICPE '21). If you use the forecast benchmark please cite the following [bibkey](CITE.md).


## Installation
In the following, we describe the requirements of and installation steps of the package. 

### Requirements
In order to use and install this R package, ensure that R (≥ 3.2) is installed.

### Installation via remotes
This package can be installed in R by using the package devtools and the following commands:

```
install.packages("remotes")
remotes::install_url(url="https://github.com/DescartesResearch/ForecastBenchmark/archive/master.zip", INSTALL_opt= "--no-multiarch")
```

### Installation via devtools
Alternatevly, this package can be installed in R by using the package devtools and the following commands:

```
install.packages("devtools") 
devtools::install_github("DescartesResearch/ForecastBenchmark") 
``` 

## Getting Started
In order to evaluate and rank forecasting methods in an automatic manner, the user have to specify how and for which use case the forecasting method in question should be evaluated. An live-demo of running the benchmark is available at [CodeOcean](https://doi.org/10.24433/CO.3240518.v1).

### Example Usage
An example code to execute the ForecastBenchmark is depicted in the following:
```
library(ForecastBenchmark)
benchmark(forecaster,usecase="nature",type="rolling")
```
The inputs for this benchmark are described in the next sections.

### Evaluation Type
The "how to forecasting method should be evaluated" is specified by the type of the evaluation. Here, the user have to choose between
* one (one-step-ahead forecast, i.e., forecasting only the last value), 
* multi (multi-step-ahead forecast, i.e., forecasting several values at once), and
* rolling (rolling-origin forecast, i.e., the time series equivalent of cross-validation).  

### Use Case
The benchmark offers four different use cases for with the method can be evaluated. Here, the user have to choose between
* economics (gas, sales, unemployment, etc.), 
* finance (stocks, sales prices, exchange rate, etc.),
* human (calls, SMS, Internet, etc.), and
* nature (rain, birth, death, etc.). 

### Requirements for the Forecasting Method
In order to benchmark a certain forecasting method, this method needs to returns the forecast values (either as vector or time series object) and to implement the following interface
```
function(ts,h){
  ...
}
```
with
* ts (a time series object as input) and
* h (a number representing the horizon as input).

### Example Forecasting Method
An example code for a forecasting method implementing the interface is depicted in the following:
```
forecaster <- function(ts,h){
  model <- ets(ts)
  values <- forecast(model,h)$mean
  return(values)
}
```




