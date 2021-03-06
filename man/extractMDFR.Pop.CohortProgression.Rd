% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extractMDFR.Pop.CohortProgression.R
\name{extractMDFR.Pop.CohortProgression}
\alias{extractMDFR.Pop.CohortProgression}
\title{Function to extract cohort progression by year among several models as a dataframe}
\usage{
extractMDFR.Pop.CohortProgression(
  objs,
  cast = "x+m+s+z",
  years = "all",
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{cast}{- casting formula for excluding x,m,s,z factor levels from sums across the unspecified factors}

\item{years}{- 'all' or vector of years to include}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
dataframe in canonical format
}
\description{
This function extracts cohort progression by year
  among several models as a dataframe.
}
\details{
Results are extracted using \code{rTCSAM2013::getMDFR.Pop.Abundance},
\code{rsimTCSAM::getMDFR.Pop.Abundance}, and/or \code{rTCSAM02::getMDFR.Pop.Abundance}, as appropriate, and 
cast to aggregate. This differs from \code{extractMDFR.Pop.Abundance1}.
}
