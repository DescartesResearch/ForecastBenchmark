# ForecastBenchmark

Libra, a forecasting benchmark, automatically evaluates and ranks forecasting methods based on their performance in a diverse set of evaluation scenarios. The benchmark comprises four different use cases, each covering 100 heterogeneous time series taken from different domains. 

The assembled data set for this benchmark comprising 400 time series is publicly availabe at [Zenodo](http://doi.org/10.5281/zenodo.4399959).


## Installation

### Requirements
In order to use and install this R package, ensure that R (≥ 3.2) is installed.

### Installation via devtools
This package can be installed in R by using the package devtools and the following commands:

```
install.packages("devtools") 
devtools::install_github("DescartesResearch/ForecastBenchmark") 
``` 

### Alternative Installation via remotes
For unknown reasons, install_github does not work under all Windows versions. Therefore the package can alternatively be installed in R with the following commands:

```
install.packages("remotes")
remotes::install_url(url="https://github.com/DescartesResearch/ForecastBenchmark/archive/master.zip", INSTALL_opt= "--no-multiarch")
```

## Getting Started
In order to evaluate and rank forecasting methods in an automatic manner, the user have to specify how and for which use case the forecasting method in question should be evaluated.

The "how" is specified by the type of the evaluation. Here, the user have to choose between
* one (one-step-ahead forecast, i.e., forecasting only the last value), 
* multi (multi-step-ahead forecast, i.e., forecasting several values at once), and
* rolling (rolling-origin forecast, i.e., the time series equivalent of cross-validation).  

Moreover, the benchmark offers four different use cases. Here, the user have to choose between
* economics (gas, sales, unemployment, etc.), 
* finance (stocks, sales prices, exchange rate, etc.),
* human (calls, SMS, Internet, etc.), and
* nature (rain, birth, death, etc.). 

and the forecasting method needs to apply the following interface
* ts (a time series object) as input, 
* h (a number representing the horizon) as input, and
* returns the forecast either as vector or time series object.

### Example Usage
```
library(ForecastBenchmark)
benchmark(forecaster,usecase="nature",type="rolling")
```

### Example Forecasting Method
```
forecaster <- function(ts,h){
  model <- ets(ts)
  values <- forecast(model,h)$mean
  return(values)
}
```
