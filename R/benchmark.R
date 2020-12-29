#' @author Andre Bauer

#' @description Automatically evaluates and ranks forecasting methods based on their performance.
#'
#' @title Execute the benchmark
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param usecase The use case for the benchmark. It must be either economics, finance, human, or nature.
#' @param type Optional parameter: The evaluation type. It must be either one (one-step-ahead forecast), multi (multi-step-ahead forecast), or rolling (rolling-origin forecast). one by default.
#' @param output Optional parameter: The name of the output file. benchmark.csv by default.
#' @param name Optional parameter: The name of the forecasting method. Benchmarked Method by default.
#' @return The performance of the forecasting method in comparison with state-of-the-art methods.
#' @examples
#' benchmark(forecaster,usecase="economics",type="one")
#' forecaster <- function(ts,h){ return(forecast(ets(ts), h = h)$mean) }
#' @export
benchmark <- function(forecaster, usecase, type = "one", output="benchmark.csv", name="Benchmarked Method"){
  # Gives feedback about input
  print(paste("Selected use case is '", usecase, "'", sep=""))
  print(paste("Selected evaluation type is '", type, "'", sep=""))

  usecase <- tolower(usecase)
  type <- tolower(type)

  # Configures the benchmark
  switch(usecase,
         "economics" = {
            data <- economics
            ind <- 1:100
         },
         "finance" = {
            data <- finance
            ind <- 101:200
         },
         "human" = {
            data <- human_access
            ind <- 201:300
         },
         "nature" = {
            data <- nature_and_demographic
            ind <- 301:400
         }, {
           stop("The wrong use case was selected. It must be either economics, finance, human, or nature.")
         }
  )

  # Performs the benchmarking
  results <- evaluation(forecaster, data, type)

  # Adds performance of state-of-the-art methods
  switch(type,
         "one" = {
           time.val <- c(mean(results[,1]), colMeans(benchmark.one.time[ind,]))
           smape.val <- c(mean(results[,2]), colMeans(benchmark.one.smape[ind,]))
           mase.val <- c(mean(results[,3]), colMeans(benchmark.one.mase[ind,]))
           mues.val <- c(mean(results[,4]), colMeans(benchmark.one.mues[ind,]))
           moes.val <- c(mean(results[,5]), colMeans(benchmark.one.moes[ind,]))
           muas.val <- c(mean(results[,6]), colMeans(benchmark.one.muas[ind,]))
           moas.val <- c(mean(results[,7]), colMeans(benchmark.one.moas[ind,]))
         },
         "multi" = {
           time.val <- c(mean(results[,1]), colMeans(benchmark.multi.time[ind,]))
           smape.val <- c(mean(results[,2]), colMeans(benchmark.multi.smape[ind,]))
           mase.val <- c(mean(results[,3]), colMeans(benchmark.multi.mase[ind,]))
           mues.val <- c(mean(results[,4]), colMeans(benchmark.multi.mues[ind,]))
           moes.val <- c(mean(results[,5]), colMeans(benchmark.multi.moes[ind,]))
           muas.val <- c(mean(results[,6]), colMeans(benchmark.multi.muas[ind,]))
           moas.val <- c(mean(results[,7]), colMeans(benchmark.multi.moas[ind,]))
         },
         "rolling" = {
           time.val <- c(mean(results[,1]), colMeans(benchmark.rolling.time[ind,]))
           smape.val <- c(mean(results[,2]), colMeans(benchmark.rolling.smape[ind,]))
           mase.val <- c(mean(results[,3]), colMeans(benchmark.rolling.mase[ind,]))
           mues.val <- c(mean(results[,4]), colMeans(benchmark.rolling.mues[ind,]))
           moes.val <- c(mean(results[,5]), colMeans(benchmark.rolling.moes[ind,]))
           muas.val <- c(mean(results[,6]), colMeans(benchmark.rolling.muas[ind,]))
           moas.val <- c(mean(results[,7]), colMeans(benchmark.rolling.moas[ind,]))
         }
  )



  methods <- c(name, "ETS", "sARIMA", "sNaive", "TBATS", "Theta", "GPyTorch", "NNetar",
               "Random Forest", "SVR", "XGBoost")

  # Prints the different performance measures
  names(time.val) <- methods
  print("## Normalized Time")
  print(time.val)

  names(smape.val) <- methods
  print("## Symmetrical Mean Absolute Percentage Error")
  print(smape.val)

  names(mase.val) <- methods
  print("## Mean Absolute Scaled Error")
  print(mase.val)

  names(mues.val) <- methods
  print("## Mean Under-Estimation Share")
  print(mues.val)

  names(moes.val) <- methods
  print("## Mean Over-Estimation Share")
  print(moes.val)

  names(muas.val) <- methods
  print("## Mean Under-Accuracy Share")
  print(muas.val)

  names(moas.val) <- methods
  print("## Mean Over-Accuracy Share")
  print(moas.val)

  # Prepares the output
  result <- rbind(time.val, smape.val, mase.val, mues.val, moes.val, muas.val, moas.val)
  rownames(result) <- c("Normalized Time", "Symmetrical Mean Absolute Percentage Error",
                        "Mean Absolute Scaled Error", "Mean Under-Estimation Share",
                        "Mean Over-Estimation Share", "Mean Under-Accuracy Share",
                        "Mean Over-Accuracy Share")

  # Writes benchmarking results
  write.table(result,file=output,sep = ";", col.names=NA)

}
