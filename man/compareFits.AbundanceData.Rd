% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareFits.AbundanceData.R
\name{compareFits.AbundanceData}
\alias{compareFits.AbundanceData}
\title{Compare fits to abundance time series by fleet among several model runs}
\usage{
compareFits.AbundanceData(
  objs = NULL,
  fleets = "all",
  fleet.type = c("survey", "fishery"),
  catch.type = c("index", "retained", "discard", "total"),
  ci = 0.8,
  fishery.pdfType = c("norm2", "normal", "lognormal"),
  numRecent = 15,
  plot1stObs = TRUE,
  scales = "free_y",
  pdf = NULL,
  showPlot = FALSE,
  verbose = FALSE
)
}
\arguments{
\item{fleets}{- names of fleets to plot (or "all")}

\item{fleet.type}{- fleet type ('fishery' or 'survey')}

\item{catch.type}{- catch type ('index','retained',  or 'total')}

\item{ci}{- confidence interval for plots}

\item{scales}{- ggplot2 scales option for facet_grid}

\item{pdf}{- name for output pdf file}

\item{showPlot}{- flag (T/F) to show plot}

\item{verbose}{- flag (T/F) to print diagnostic information}

\item{obj}{- object that can be converted into a list of tcsam2013.resLst and/or tcsam02.resLst objects}
}
\value{
Non-nested list of ggplot2 objects, with captions as names, or NULL.
}
\description{
Function to compare fits to abundance time series by fleet among
several model runs.
}
\details{
Uses \code{rTCSAM2013::getMDFR.SurveyQuantities()},
\code{rTCSAM2013::getMDFR.FisheryQuantities()}, \code{rTCSAM02::getMDFR.Fits.FleetData()}.
Also uses \code{wtsUtilities::printGGList}.
}
