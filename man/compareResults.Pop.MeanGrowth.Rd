% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareResults.Pop.MeanGrowth.R
\name{compareResults.Pop.MeanGrowth}
\alias{compareResults.Pop.MeanGrowth}
\title{Compare mean post-molt size among several model runs}
\usage{
compareResults.Pop.MeanGrowth(
  objs,
  dodge = 0.2,
  showPlot = FALSE,
  pdf = NULL,
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{dodge}{- width to dodge overlapping series}

\item{showPlot}{- flag to print plot to current device}

\item{pdf}{- name for output pdf file}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
ggplot object
}
\description{
Function to compare mean post-molt size among several model runs.
}
\details{
None.
}
