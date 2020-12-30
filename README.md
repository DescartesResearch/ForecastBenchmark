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
For using the ForecastBenchmark, the type of the evaluation have to be choosen
* one (one-step-ahead forecast), 
* multi (multi-step-ahead forecast), or
* rolling (rolling-origin forecast), 

the use case have to be choosen 
* economics, 
* finance, 
* human, or 
* nature,

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
