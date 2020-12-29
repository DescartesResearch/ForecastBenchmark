#' @description Calculates the Symmetrical Mean Absolute Percentage Error (sMAPE) between the forecast and test data.
#'
#' @title Calculating the sMAPE of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @return The sMAPE of the forecast
smape <- function(forecast,actual){
  return(200*mean(abs((actual-forecast))/(abs(actual+forecast))))
}

#' @description Calculates the Mean Absolute Scaled Error (MASE) between the forecast and test data.
#'
#' @title Calculating the MASE of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @param hist The training data.
#' @return The MASE of the forecast
mase <- function(forecast,actual,hist){
  freq <- frequency(hist)
  hist.length <- length(hist)

  # Determines the scaling factor
  scale <- (hist.length/(hist.length-freq))
  dif <- 0
  for(i in (freq+1):hist.length){
    dif <- dif + abs(hist[i] - hist[i-freq])
  }
  scale <- scale * dif

  return(sum(abs(actual-forecast))/scale)
}

#' @description Calculates the Mean Under-Estimation Share (MUES) between the forecast and test data.
#'
#' @title Calculating the MUES of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @return The MUES of the forecast
mues <- function(forecast,actual){
  return(mean(pmax(sign(actual-forecast),0)))
}

#' @description Calculates the Mean Over-Estimation Share (MOES) between the forecast and test data.
#'
#' @title Calculating the MOES of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @return The MOES of the forecast
moes <- function(forecast,actual){
  return(mean(pmax(sign(forecast-actual),0)))
}

#' @description Calculates the Mean Under-Accuracy Share (MUAS) between the forecast and test data.
#'
#' @title Calculating the MUAS of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @return The MUAS of the forecast
muas <- function(forecast,actual){
  m <- mues(forecast, actual)

  # No under-estimation
  if(m==0){
    return(0)
  }
  return((1/m)*mean(pmax(actual-forecast,0)/abs(actual)))
}

#' @description Calculates the Mean Over-Accuracy Share (MOAS) between the forecast and test data.
#'
#' @title Calculating the MOAS of the forecast
#' @param forecast The forecast values
#' @param actual The test data.
#' @return The MOAS of the forecast
moas <- function(forecast,actual){
  m <- moes(forecast, actual)

  # No over-estimation
  if(m==0){
    return(0)
  }
  return((1/m)*mean(pmax(forecast-actual,0)/abs(actual)))
}
