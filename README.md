# ForecastBenchmark

Libra, a forecasting benchmark, automatically evaluates and ranks forecasting methods based on their performance in a diverse set of evaluation scenarios. The benchmark comprises four different use cases, each covering 100 heterogeneous time series taken from different domains. 


## Installation
This package can be installed in R by using the following commands:

`install.packages("devtools")` <br />
`devtools::install_github("DescartesResearch/ForecastBenchmark")` <br />

For unknown reasons, install_gitub does not work under all Windows versions. Therefore the package can alternatively be installed in R with the following commands:

`install.packages("remotes")` <br />
`remotes::install_url(url="https://github.com/DescartesResearch/ForecastBenchmark/archive/master.zip", INSTALL_opt= "--no-multiarch")`

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
`library(ForecastBenchmark)` <br />
`benchmark(forecaster,usecase="nature",type="rolling")`

### Example Forecasting Method
`forecaster <- function(ts,h){` <br />
`  model <- ets(ts)` <br />
`  values <- forecast(model,h)$mean` <br />
`  return(values)` <br />
`}`
