# Documentation

## Sequence Diagram of Libra

![alt text](sequence_diagram.png?raw=true)

## Inputs and Parameters
In the following, we describe inputs and parameters of the benchmark.

### Usage
```
benchmark(
  forecaster,
  usecase,
  type = "one",
  output = "benchmark.csv",
  name = "Benchmarked Method",
  reportAll = TRUE
)
```

### Arguments
* forecaster:	
The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
* usecase: The use case for the benchmark. It must be either economics, finance, human, or nature.
* type:	Optional parameter: The evaluation type. It must be either one (one-step-ahead forecast), multi (multi-step-ahead forecast), or rolling (rolling-origin forecast). one by default.
* output: Optional parameter: The name of the output file with the structure Folder/subfolder/file. benchmark.csv by default.
* name: Optional parameter: The name of the forecasting method. Benchmarked Method by default.
* reportAll: Optional parameter: Whether to report the results of the state-of-the-art methods already benchmarked. TRUE by default.

## Use Cases
The benchmark comprises four different use cases with each 100 time series: 
* economics (gas, sales, unemployment, etc.), 
* finance (stocks, sales prices, exchange rate, etc.),
* human (calls, web requests, batch requests, etc.), and
* nature (rain, birth, death, etc.).

The time series are additionally publicly available at [Zenodo](http://doi.org/10.5281/zenodo.4399959).

### Distribution of the Time Series Lenghts in each Use Case

![alt text](length_distribution.png?raw=true)

### Distribution of the Time Series Frequencies in each Use Case

![alt text](frequency_distribution.png?raw=true)

### Relationship between Time Series Length and Frequency in each Use Case

![alt text](frequency_length.png?raw=true)

## Measures
The benchmark report the performance of the forecasting method based on seven measures.

### Normalized Time
The time-to-result of the forecasting method is measured and then normalized. Normalization is performed using a naive forecasting method executed in the background.

### Symmetrical Mean Absolute Percentage Error
A percentage based accuracy measure of the forecast. Mathematically,
$$SMAPE = \frac{100\%}{k} \sum_{t=1}^k \frac{\lvert y_t - \hat{y}_t \rvert}{\lvert y_t \rvert},$$
where $k$ is the forecast horizon, $y_t$ the actual value at time $t$, and $\hat{y}_t$ the forecast value at time $t$.

### Mean Absolute Scaled Error
An accuracy measure of the forecast that is scaled by a baseline. Mathematically,
$$MASE = \frac{100\%}{k} \sum_{t=1}^k \frac{\lvert y_t - \hat{y}_t \rvert}{b},$$ 

with 

$$b = \frac{1}{n-m}\sum_{i=m+1}^{n} \lvert h_i - h_{i-m}\rvert,$$
where $k$ is the forecast horizon, $y_t$ the actual value at time $t$, $\hat{y}_t$ the forecast value at time $t$, $m$ the length of the period ($m = 1$ for non-seasonal time series), $n$ the length of the history, and $h_i$ the historical values at time $i$. 

### Mean Under-Estimation Share
The percentage of forecast values that underestimate the actual values. Mathematically,
$$\rho_U := \frac{1}{k} \cdot \sum_{t=1}^k max(sgn(y_t - \hat{y_t}),0),$$
where $k$ is the forecast horizon (i.e., the length of the forecast), $y_t$ the actual value at time $t$, and $\hat{y_t}$ the forecast value at time $t$.
 
### Mean Over-Estimation Share
The percentage of forecast values that overestimate the actual values. Mathematically,
$$\rho_O := \frac{1}{k} \cdot \sum_{t=1}^k max(sgn(\hat{y_t} - y_t),0),$$
where $k$ is the forecast horizon (i.e., the length of the forecast), $y_t$ the actual value at time $t$, and $\hat{y_t}$ the forecast value at time $t$.
 
### Mean Under-Accuracy Share
The accuracy in terms of underestimation the actual values. Mathematically,
$$\delta_U :=  \frac{1}{k \cdot \rho_U} \cdot \sum_{t=1}^k \frac{max(y_t - \hat{y_t},0)}{\lvert y_t \rvert} $$
if there are forecast values that underestimate the actual values, otherwiese 0. In this equation, $k$ is the forecast horizon (i.e., the length of the forecast), $y_t$ the actual value at time $t$, and $\hat{y_t}$ the forecast value at time $t$.

### Mean Over-Accuracy Share
The accuracy in terms of overestimation the actual values. . Mathematically,
$$\frac{1}{k \cdot \rho_O} \cdot \sum_{t=1}^k \frac{max(\hat{y_t} - y_t,0)}{\lvert y_t \rvert}$$
if there are forecast values that underestimate the actual values, otherwiese 0. In this equation, $k$ is the forecast horizon (i.e., the length of the forecast), $y_t$ the actual value at time $t$, and $\hat{y_t}$ the forecast value at time $t$.
