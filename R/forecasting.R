#' @description Peforms the forecast of the forecasting method.
#'
#' @title Performing the forecasts
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param usecase The use case for the benchmark. It must be either economics, finance, human, or nature.
#' @param type The evaluation type. It must be either one (one-step-ahead forecast), multi (multi-step-ahead forecast), or rolling (rolling-origin forecast). one by default.
#' @return The performance measures of the forecasting method.
evaluation <- function(forecaster, data, type){
  results <- c()
  for(i in 1:100){
    print(paste("Progress: ", i, "%", sep=""))
    switch(type,
           "one" = {
             result <- forecast.one(forecaster, data[[i]])
             results <- rbind(results, result)
           },
           "multi" = {
             result <- forecast.multi(forecaster, data[[i]])
             results <- rbind(results, result)
           },
           "rolling" = {
             result <- forecast.rolling(forecaster, data[[i]])
             results <- rbind(results, result)
           }, {
             stop("The wrong type was selected. It must be either one, multi, or rolling.")
           }
    )

  }

  row.names(results) <- NULL
  colnames(results) <- c("time", "smape", "mase", "mues", "moes", "muas", "moas")
  return(results)
}

#' @description Determines the indices for the rolling-origin forecast.
#'
#' @title Determining the indices.
#' @param timeseries The time series.
#' @return The indices.
getindizies <- function(timeseries){
  # Determines start and end indices
  start.ind <- max(ceiling(0.4*length(timeseries)), (2*frequency(timeseries)+1))
  end.ind <- length(timeseries) - 1

  # Determines the indices for rolling-origin
  ind <- seq(start.ind,end.ind, by=ceiling((end.ind - start.ind)/100))
  ind <- unique(c(ind,end.ind))

  return(ind)

}

#' @description Calculates all performance measures.
#'
#' @title Calculating the performance measures
#' @param end The timestamp after the forecast.
#' @param start The timestamp before the forecast.
#' @param hist The training data.
#' @param forecast The forecast.
#' @param actual The test data.
#' @param horizon The forecast horizon.
#' @return The performance measures of the forecast.
calculateMeasures <- function(end, start, hist, forecast, actual, horizon) {
  result <- c()
  result[1] <- difftime(end, start, units = "secs")

  if(length(actual)!=length(forecast)){
    stop(paste("The forecast has another length (", length(forecast) ,") than expected (", length(actual), ").",sep=""))
  }

  # Determining the baseline
  start <- Sys.time()
  tmp <- snaive(hist, h=horizon)$mean
  end <- Sys.time()

  # Normalizes the time-to-result
  result[1] <- result[1]/ as.vector(difftime(end, start, units = "secs"))
  result[2] <- smape(forecast,actual)
  result[3] <- mase(forecast,actual,hist)
  result[4] <- mues(forecast,actual)
  result[5] <- moes(forecast,actual)
  result[6] <- muas(forecast,actual)
  result[7] <- moas(forecast,actual)
  return(result)
}


#' @description Peforms the one-step-ahead forecast of a time series based on the forecasting method.
#'
#' @title Performing the one-step-ahead forecast
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param timeseries The time series.
#' @return The performance measures of the one-step-ahead forecast of the time series.
forecast.one <- function(forecaster, timeseries){
  # Determines history and test for one-step-ahead forecast
  hist <- ts(timeseries[1:(length(timeseries)-1)], frequency = frequency(timeseries))
  actual <- ts(timeseries[length(timeseries)], frequency = frequency(timeseries))

  # Performs forecast
  start <- Sys.time()
  forecast <- forecaster(ts=hist, h=1)
  end <- Sys.time()

  # Unifies data
  actual <- as.vector(actual)
  forecast <- as.vector(forecast)

  return(calculateMeasures(end, start, hist, forecast, actual, 1))
}

#' @description Peforms the multi-step-ahead forecast of a time series based on the forecasting method.
#'
#' @title Performing the one-step-ahead forecast
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param timeseries The time series.
#' @return The performance measures of the multi-step-ahead forecast of the time series.
forecast.multi <- function(forecaster, timeseries){
  # Determines history, horizon, and test for multi-step-ahead forecast
  hist.length <- (ceiling(length(timeseries) * 0.8))
  horizon <- length(timeseries) - hist.length
  hist <-
    ts(timeseries[1:hist.length], frequency = frequency(timeseries))
  actual <- timeseries[(hist.length + 1):length(timeseries)]

  # Performs forecast
  start <- Sys.time()
  forecast <- forecaster(ts=hist, h=horizon)
  end <- Sys.time()

  # Unifies data
  actual <- as.vector(actual)
  forecast <- as.vector(forecast)

  return(calculateMeasures(end, start, hist, forecast, actual, horizon))
}


#' @description Peforms the rolling-origin forecast of a time series based on the forecasting method.
#'
#' @title Performing the one-step-ahead forecast
#' @param forecaster The forecasting method. This method gets a timeseries objekt (ts) and the horizon (h). The method returns the forecast values.
#' @param timeseries The time series.
#' @return The performance measures of the rolling-origin forecast of the time series.
forecast.rolling <- function(forecaster, timeseries){
  # Extracts indices for rolling-origin
  ind <- getindizies(timeseries)
  ind <- ind[-length(ind)]

  # Determines forecast horizon
  horizon <- length(timeseries) - (ceiling(length(timeseries) * 0.8))

  # Performs rolling-origin forecast
  results <- c()
  for(j in ind){
    # Determines history and test according to the rolling-history
    hist <- ts(timeseries[1:j], frequency = frequency(timeseries))
    actual <- timeseries[(j + 1):min((j+horizon),length(timeseries))]

    # Performs forecast
    start <- Sys.time()
    forecast <- forecaster(ts=hist, h=horizon)
    end <- Sys.time()

    # Unifies data
    actual <- as.vector(actual)
    forecast <- as.vector(forecast[1:length(actual)])

    result <- calculateMeasures(end, start, hist, forecast, actual, horizon)
    results <- rbind(results,result)

  }

  # Calculates mean over the rolling-origin
  result <- colMeans(results)
  return(result)
}




