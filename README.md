# ForecastBenchmark

Libra, a forecasting benchmark, automatically evaluates and ranks forecasting methods based on their performance in a diverse set of evaluation scenarios. The benchmark comprises four different use cases, each covering 100 heterogeneous time series taken from different domains. 


## Installation
This package can be installed in R by using the following commands:

`install.packages("devtools")` <br />
`devtools::install_github("DescartesResearch/ForecastBenchmark")` <br />

For unknown reasons, install_gitub does not work under all Windows versions. Therefore the package can alternatively be installed in R with the following commands:

`install.packages("remotes")` <br />
`remotes::install_url(url="https://github.com/DescartesResearch/ForecastBenchmark/archive/master.zip", INSTALL_opt= "--no-multiarch")`
