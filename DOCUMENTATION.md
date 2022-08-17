# Documentation

## Inputs and Parameters
In the following, we describe inputs and parameters of the benchmark.

### Usage
benchmark(
  forecaster,
  usecase,
  type = "one",
  output = "benchmark.csv",
  name = "Benchmarked Method",
  reportAll = TRUE
)

### Arguments
* forecaster:	
The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
* usecase: The use case for the benchmark. It must be either economics, finance, human, or nature.
* type:	Optional parameter: The evaluation type. It must be either one (one-step-ahead forecast), multi (multi-step-ahead forecast), or rolling (rolling-origin forecast). one by default.
* output: Optional parameter: The name of the output file with the structure Folder/subfolder/file. benchmark.csv by default.
* name: Optional parameter: The name of the forecasting method. Benchmarked Method by default.
* reportAll: Optional parameter: Whether to report the results of the state-of-the-art methods already benchmarked. TRUE by default.

## Use Cases

## Measures
