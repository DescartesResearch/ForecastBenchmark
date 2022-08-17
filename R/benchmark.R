#' @author Andre Bauer

#' @description Automatically evaluates and ranks forecasting methods based on their performance.
#'
#' @title Execute the benchmark
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param usecase The use case for the benchmark. It must be either economics, finance, human, or nature.
#' @param type Optional parameter: The evaluation type. It must be either one (one-step-ahead forecast), multi (multi-step-ahead forecast), or rolling (rolling-origin forecast). one by default.
#' @param output Optional parameter: The name of the output file with the structure Folder/subfolder/file. benchmark.csv by default.
#' @param name Optional parameter: The name of the forecasting method. Benchmarked Method by default.
#' @param reportAll Optional parameter: Whether to report the results of the state-of-the-art methods already benchmarked. TRUE by default.
#' @return The performance of the forecasting method in comparison with state-of-the-art methods.
#' @examples
#' # Example usage
#' benchmark(forecaster,usecase="economics",type="one")
#'
#' # Example forecasting method
#' forecaster <- function(ts,h){ return(forecast(ets(ts), h = h)$mean) }
#' @export
benchmark <- function(forecaster, usecase, type = "one", output="benchmark.csv", name="Benchmarked Method", reportAll=TRUE){
  # Checks if folder exists
  if(grepl("/",output)){
    split <- tail(unlist(gregexpr('/', output)),1)
    folder <- substr(output,1,split)
    if(!dir.exists(folder)){
      stop(paste("The folder", folder, "does not exist"))
    }
  }
  
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
           time.mean <- c(mean(results[,1]), colMeans(benchmark.one.time[ind,]))
           smape.mean <- c(mean(results[,2]), colMeans(benchmark.one.smape[ind,]))
           mase.mean <- c(mean(results[,3]), colMeans(benchmark.one.mase[ind,]))
           mues.mean <- c(mean(results[,4]), colMeans(benchmark.one.mues[ind,]))
           moes.mean <- c(mean(results[,5]), colMeans(benchmark.one.moes[ind,]))
           muas.mean <- c(mean(results[,6]), colMeans(benchmark.one.muas[ind,]))
           moas.mean <- c(mean(results[,7]), colMeans(benchmark.one.moas[ind,]))

           time.sd <- c(sd(results[,1]), apply(benchmark.one.time[ind,], 2, sd))
           smape.sd <- c(sd(results[,2]), apply(benchmark.one.smape[ind,], 2, sd))
           mase.sd <- c(sd(results[,3]), apply(benchmark.one.mase[ind,], 2, sd))
           mues.sd <- c(sd(results[,4]), apply(benchmark.one.mues[ind,], 2, sd))
           moes.sd <- c(sd(results[,5]), apply(benchmark.one.moes[ind,], 2, sd))
           muas.sd <- c(sd(results[,6]), apply(benchmark.one.muas[ind,], 2, sd))
           moas.sd <- c(sd(results[,7]), apply(benchmark.one.moas[ind,], 2, sd))
         },
         "multi" = {
           time.mean <- c(mean(results[,1]), colMeans(benchmark.multi.time[ind,]))
           smape.mean <- c(mean(results[,2]), colMeans(benchmark.multi.smape[ind,]))
           mase.mean <- c(mean(results[,3]), colMeans(benchmark.multi.mase[ind,]))
           mues.mean <- c(mean(results[,4]), colMeans(benchmark.multi.mues[ind,]))
           moes.mean <- c(mean(results[,5]), colMeans(benchmark.multi.moes[ind,]))
           muas.mean <- c(mean(results[,6]), colMeans(benchmark.multi.muas[ind,]))
           moas.mean <- c(mean(results[,7]), colMeans(benchmark.multi.moas[ind,]))

           time.sd <- c(sd(results[,1]), apply(benchmark.multi.time[ind,], 2, sd))
           smape.sd <- c(sd(results[,2]), apply(benchmark.multi.smape[ind,], 2, sd))
           mase.sd <- c(sd(results[,3]), apply(benchmark.multi.mase[ind,], 2, sd))
           mues.sd <- c(sd(results[,4]), apply(benchmark.multi.mues[ind,], 2, sd))
           moes.sd <- c(sd(results[,5]), apply(benchmark.multi.moes[ind,], 2, sd))
           muas.sd <- c(sd(results[,6]), apply(benchmark.multi.muas[ind,], 2, sd))
           moas.sd <- c(sd(results[,7]), apply(benchmark.multi.moas[ind,], 2, sd))
         },
         "rolling" = {
           time.mean <- c(mean(results[,1]), colMeans(benchmark.rolling.time[ind,]))
           smape.mean <- c(mean(results[,2]), colMeans(benchmark.rolling.smape[ind,]))
           mase.mean <- c(mean(results[,3]), colMeans(benchmark.rolling.mase[ind,]))
           mues.mean <- c(mean(results[,4]), colMeans(benchmark.rolling.mues[ind,]))
           moes.mean <- c(mean(results[,5]), colMeans(benchmark.rolling.moes[ind,]))
           muas.mean <- c(mean(results[,6]), colMeans(benchmark.rolling.muas[ind,]))
           moas.mean <- c(mean(results[,7]), colMeans(benchmark.rolling.moas[ind,]))

           time.sd <- c(sd(results[,1]), apply(benchmark.rolling.time[ind,], 2, sd))
           smape.sd <- c(sd(results[,2]), apply(benchmark.rolling.smape[ind,], 2, sd))
           mase.sd <- c(sd(results[,3]), apply(benchmark.rolling.mase[ind,], 2, sd))
           mues.sd <- c(sd(results[,4]), apply(benchmark.rolling.mues[ind,], 2, sd))
           moes.sd <- c(sd(results[,5]), apply(benchmark.rolling.moes[ind,], 2, sd))
           muas.sd <- c(sd(results[,6]), apply(benchmark.rolling.muas[ind,], 2, sd))
           moas.sd <- c(sd(results[,7]), apply(benchmark.rolling.moas[ind,], 2, sd))
         }
  )

  ind <- 1
  if(reportAll){
    ind <- 10
  }

  methods <- c(name, "ETS", "sARIMA", "sNaive", "TBATS", "Theta", "GPyTorch", "NNetar",
               "Random Forest", "SVR", "XGBoost")

  # Prints the different performance measures
  names(time.mean) <- methods
  print("## Avg. Normalized Time")
  print(time.mean[1:ind])

  names(time.sd) <- methods
  print("## SD. Normalized Time")
  print(time.sd[1:ind])

  names(smape.mean) <- methods
  print("## Avg. Symmetrical Mean Absolute Percentage Error")
  print(smape.mean[1:ind])

  names(smape.sd) <- methods
  print("## SD. Symmetrical Mean Absolute Percentage Error")
  print(smape.sd[1:ind])

  names(mase.mean) <- methods
  print("## Avg. Mean Absolute Scaled Error")
  print(mase.mean[1:ind])

  names(mase.sd) <- methods
  print("## SD. Mean Absolute Scaled Error")
  print(mase.sd[1:ind])

  names(mues.mean) <- methods
  print("## Avg. Mean Under-Estimation Share")
  print(mues.mean[1:ind])

  names(mues.sd) <- methods
  print("## SD. Mean Under-Estimation Share")
  print(mues.sd[1:ind])

  names(moes.mean) <- methods
  print("## Avg. Mean Over-Estimation Share")
  print(moes.mean[1:ind])

  names(moes.sd) <- methods
  print("## SD. Mean Over-Estimation Share")
  print(moes.sd[1:ind])

  names(muas.mean) <- methods
  print("## Avg. Mean Under-Accuracy Share")
  print(muas.mean[1:ind])

  names(muas.sd) <- methods
  print("## SD. Mean Under-Accuracy Share")
  print(muas.sd[1:ind])

  names(moas.mean) <- methods
  print("## Avg. Mean Over-Accuracy Share")
  print(moas.mean[1:ind])

  names(moas.sd) <- methods
  print("## SD. Mean Over-Accuracy Share")
  print(moas.sd[1:ind])

  # Prepares the output
  result <- rbind(time.mean, time.sd, smape.mean, smape.sd, mase.mean, mase.sd, mues.mean, mues.sd,
                  moes.mean, moes.sd, muas.mean, muas.sd, moas.mean, moas.sd)
  rownames(result) <- c("Avg. Normalized Time", "SD. Normalized Time",
                        "Avg. Symmetrical Mean Absolute Percentage Error", "SD. Symmetrical Mean Absolute Percentage Error",
                        "Avg. Mean Absolute Scaled Error", "SD. Mean Absolute Scaled Error",
                        "Avg. Mean Under-Estimation Share", "SD. Mean Under-Estimation Share",
                        "Avg. Mean Over-Estimation Share", "SD. Mean Over-Estimation Share",
                        "Avg. Mean Under-Accuracy Share", "SD. Mean Under-Accuracy Share",
                        "Avg. Mean Over-Accuracy Share", "SD. Mean Over-Accuracy Share")

  # Writes benchmarking results
  write.table(result[,1:ind,drop=F],file=output,sep = ";", col.names=NA)

}
