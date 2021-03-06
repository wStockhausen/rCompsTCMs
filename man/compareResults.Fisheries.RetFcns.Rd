% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareResults.Fisheries.RetFcns.R
\name{compareResults.Fisheries.RetFcns}
\alias{compareResults.Fisheries.RetFcns}
\title{Function to compare fishery retention functions by year among several models}
\usage{
compareResults.Fisheries.RetFcns(
  objs,
  cast = "y+x",
  fleets = "all",
  years = "all",
  dodge = 0.2,
  mxy = 15,
  singlePlot = FALSE,
  facet_wrap = NULL,
  facet_grid = ifelse(singlePlot, "x~case", "y~x"),
  showPlot = FALSE,
  pdf = NULL,
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{cast}{- formula to exclude factors from "averaging" over}

\item{fleets}{- vector of feets to plot, or "all"}

\item{years}{- vector of years to show, or 'all' to show all years}

\item{dodge}{- width to dodge overlapping series}

\item{mxy}{- max number of years per page}

\item{singlePlot}{- flag to plot all years on single plot (be sure to adjust facet_grid)}

\item{facet_wrap}{- ggplot2 formula to produce figure with wrapped facets}

\item{facet_grid}{- ggplot2 formula to produce figure with gridded facets}

\item{showPlot}{- flag (T/F) to show plot}

\item{pdf}{- creates pdf, if not NULL}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
lists ofggplot2 objects, nested by fishery or an empty list if year is NULL
}
\description{
This function compares fishery retention functions by year
  among several models.
}
\details{
None.
}
