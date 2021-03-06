% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareResults.Pop.NatZ.LinePlots.R
\name{compareResults.Pop.NatZ.LinePlots}
\alias{compareResults.Pop.NatZ.LinePlots}
\title{Function to compare population numbers-at-size estimates by year among several models}
\usage{
compareResults.Pop.NatZ.LinePlots(
  objs,
  type = c("N_yxmsz", "N_yxmz", "N_yxz", "iN_xmsz", "fN_xmsz"),
  dodge = 0.2,
  ncol = 3,
  nrow = 5,
  showPlot = FALSE,
  pdf = NULL,
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{type}{- type of abuundance ("N_yxmsz","N_yxmz","N_yxz","iN_xmsz","fN_xmsz")}

\item{dodge}{- width to dodge overlapping series}

\item{ncol}{- number of columns per page for multi-year plots}

\item{nrow}{- number of rows per page (nominal) for multi-year plots}

\item{showPlot}{- flag (T/F) to show plot}

\item{pdf}{- creates pdf, if not NULL}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
ggplot2 object
}
\description{
This function compares population numbers-at-size estimates by year
  using line plots among several models.
}
\details{
uses \code{rTCSAM2013::getMDFR.Pop.Quantities},
\code{rsimTCSAM::getMDFR.Pop.Quantities}, \code{rsimTCSAM::getMDFR.Pop.Quantities}, and
\code{plotMDFR.XY}.
}
