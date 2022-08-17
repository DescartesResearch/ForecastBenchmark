# ForecastBenchmark

Libra, a forecasting benchmark, automatically evaluates forecasting methods based on their performance in a diverse set of evaluation scenarios. The benchmark comprises four different use cases, each covering 100 heterogeneous time series taken from different domains. 

A live-demo for using the benchmark is hosted at [CodeOcean](https://doi.org/10.24433/CO.3240518.v1). 

The assembled dataset for this benchmark, which includes 400 time series, is incorporated in this package and is additionally publicly available at [Zenodo](http://doi.org/10.5281/zenodo.4399959).

Check out our [Getting Started Guide](GET_STARTED.md) for information on how to use the Libra.

## Quick Example
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

The installation process, requirements, and options for this benchmark are described in the [Getting Started Guide](GET_STARTED.md). A more detailed describtion can be found in the [Documentation](DOCUMENTATION.md).

## Cite Us

The forecast benchmark was first published in [Proceedings of the 12th ACM/SPEC International Conference on Performance Engineering (ICPE '21)](https://dl.acm.org/doi/abs/10.1145/3427921.3450241). If you use the forecast benchmark please cite the following [bibkey](CITE.md):

	@inproceedings{KiEiScBaGrKo2018-MASCOTS-TeaStore,
      author = {Andr{\'e} Bauer and Marwin Z{\"u}fle Simon Eismann and Johannes Grohmann and Nikolas Herbst and Samuel Kounev},
      title = {{Libra: A Benchmark for Time Series Forecasting Methods}},
      booktitle = {Proceedings of the 12th ACM/SPEC International Conference on Performance Engineering},
      series = {ICPE '21},
      year = {2021},
      month = {April},
      location = {{Rennes, France}},
    }





