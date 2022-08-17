# The Libra Brenchmark
Time series forecasting is essential in various disciplines for decision-making. Therefore, it is also an active research area where many methods are proposed. 
According to the "No-Free-Lunch Theorem", there is no forecasting method that performs best for all use cases. 
That is, every method has its own advantages and disadvantages. 
Although there are forecasting competitions such as the M-Competitions which can be considered as benchmarks, these are barely applied in scientific works. 
They typically consider only small sets of methods and do not provide any information on the time-to-result of the studied methods. 
Consequently, methods until now fail to provide a reliable approach to guide the choice of an appropriate forecasting method for a particular use case. 
The question of how to solve this problem remains.

To tackle this question, the forecasting benchmark Libra is presented. Libra  automatically evaluates a forecasting method based on the choices of the user. The user uploads a code artifact of the forecasting method to be benchmarked. Then, the user specifies one of four use cases and selects one out of three evaluation types for the benchmarking process. Based on that, the method in question is evaluated and compared to other state-of-the-art methods, so that it allows the user to compare the respective forecasting method to other forecasting methods. In addition to that, different forecast error measures are included for a more detailed insight. A highly diverse data set was gathered comprising 400 publicly available time series taken from different domains, providing a higher heterogeneity compared to prior forecasting competitions. To sum it up, Libra offers a broad data set exhibiting, a high degree of diversity, different measures, and three types of evaluation approaches.


## Workflow

The workflow of the proposed benchmark is presented in following figure.

![alt text](sequence_diagram.png?raw=true)

In the beginning, the user uploads the code artifact of the forecasting method that should be evaluated to the benchmark. 
This causes the forecasting method to be deployed within Libra, so that it can only communicate with it. 
In the next step, the user specifies one out of four use cases in which the respective forecasting method should be evaluated. 
Additionally, the user selects one of three evaluation types. 
After the selection of the input by the user, the benchmark shuffles the set of time series within the domain. 
That is, the respective forecasting method receives the time series in a random order. 
Every time series within the domain gets split into a training and test time series depending on the evaluation type. 
The training time series and the forecast horizon are passed to the forecasting method. 
Then, the forecasting method performs a forecast, which afterwards gets submitted to the benchmark. 
The benchmark calculates the sMAPE, the MASE, and four other measures based on the input and forecasting method. 
Besides the forecasting accuracy, the forecast also records the required time for each forecast. 
To have a comparable time-to-result, the benchmark performs a forecast with sNaïve beforehand. 
After each forecast, a report is created that contains an overview and ranking compared to the state-of-the-art methods. 
It also lists the average and the standard deviation of the gathered measures. 
The incorporated comparison of state-of-the-art methods include ETS, NNetar, random forest, sARIMA, sNaïve, SVR, TBATS, Theta, and XGBoost. 
Their results were conducted prior to the use of the benchmark and were saved within the benchmark.


## Evaluation of Methods


As mentioned in the previous section, Libra contains three different evaluation types to quantify the forecast accuracy of a forecasting method: 
(i) One-step-ahead forecasts, (ii) multi-step-ahead forecasts, and (iii) rolling origin forecasts. 
With the first type of forecasting method, only the last value of the time series must be forecast while the others are received. 
In some scenarios, a fine granularity causes several data points in a short time, so that planning requires values in advance. 
This is why the second type splits the time series in 80% training and a 20\% test data set, which then have to be forecast. 
For the first two types of evaluation, an "arbitrary" split may be performed, so that the resulting forecasts are sensitive to occurrences that may only occur in that
particular split. The third evaluation method uses the idea of rolling origin in order to stabilize the assessment of forecasting methods. 
