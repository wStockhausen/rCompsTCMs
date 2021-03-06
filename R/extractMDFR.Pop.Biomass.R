#'
#'@title Function to extract estimated population biomass by year among several models as a dataframe
#'
#'@description This function extracts estimated population biomass by year
#'   among several models as a dataframe.
#'
#'@param objs - list of resLst objects
#'@param cast - casting formula for excluding y,x,m,s,z factor levels from sums across the unspecified factors
#'@param years - 'all' or vector of years to include
#'@param verbose - flag (T/F) to print diagnostic information
#'
#'@return dataframe
#'
#'@details Results are extracted using \code{rTCSAM2013::getMDFR.Pop.Biomass},
#'\code{rsimTCSAM::getMDFR.Pop.Biomass}, and/or \code{rTCSAM02::getMDFR.Pop.Biomass}, as appropriate, and
#'cast to aggregate. This differs from \code{extractMDFR.Pop.Biomass1}.
#'
#'@export
#'
extractMDFR.Pop.Biomass<-function(objs,
                                   cast="y+x",
                                   years='all',
                                   verbose=FALSE){
    if (verbose) cat("starting rCompTCMs::extractMDFR.Pop.Biomass().\n");
    options(stringsAsFactors=FALSE);

    if (is.null(cast)){
        cat("Error in rCompTCMs::extractMDFR.Pop.Biomass()\n");
        cat("Must supply a 'cast' formula!\nReturning NULL.\n");
        return(NULL);
    }

    cases<-names(objs);

    mdfr<-NULL;
    for (case in cases){
        obj<-objs[[case]];
        if (verbose) cat("Processing '",case,"', a ",class(obj)[1]," object.\n",sep='');
        mdfr1<-NULL;
        if (inherits(obj,"tcsam2013.resLst")) mdfr1<-rTCSAM2013::getMDFR.Pop.Biomass(obj,cast=cast,verbose=verbose);
        if (inherits(obj,"rsimTCSAM.resLst")) mdfr1<-rsimTCSAM::getMDFR.Pop.Biomass(obj,cast=cast,verbose=verbose);
        if (inherits(obj,"tcsam02.resLst"))   mdfr1<-rTCSAM02::getMDFR.Pop.Biomass(obj,cast=cast,verbose=verbose);
        if (!is.null(mdfr1)){
            mdfr1$case<-case;
            mdfr<-rbind(mdfr,mdfr1);
        }
    }
    mdfr$case<-factor(mdfr$case,levels=cases);
    mdfr$y<-as.numeric(mdfr$y);

    if (is.numeric(years)) {
        mdfr<-mdfr[mdfr$y %in% years,];
    }

    if (verbose) cat("finished rCompTCMs::extractMDFR.Pop.Biomass().\n");
    return(mdfr)
}
