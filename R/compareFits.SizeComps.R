#'
#'@title Compare fits to size comps by fleet among several model runs
#'
#'@description Function to compare fits to size comps by fleet among
#'several model runs.
#'
#' @param objs - object that can be converted into a list of tcsam2013.resLst and/or tcsam02.resLst objects
#' @param mdfr - dataframe from call to \code{extractFits.SizeComps} (as alternative to objs)
#' @param fleets - names of fleets to include (or "all")
#' @param fleet.type - fleet type ('fishery' or 'survey')
#' @param catch.type - catch type ('index','retained',  or 'total')
#' @param  years - years to plot, as numerical vector (or "all" to plot all years)
#' @param plot1stObs - flag (T/F) to plot observations only from first case
#' @param nrow - number of rows per page for output plots
#' @param ncol - number of columns per page for output plots
#' @param pdf - name for output pdf file
#' @param showPlot - flag (T/F) to show plot
#' @param verbose - flag (T/F) to print diagnostic information
#'
#'@details Uses \code{rTCSAM2013::getMDFR.SurveyQuantities()},
#'\code{rTCSAM2013::getMDFR.FisheryQuantities()}, \code{rTCSAM02::getMDFR.Fits.FleetData()}.
#'Also uses \code{wtsUtilities::printGGList}.
#'
#'@return Non-nested list of ggplot2 objects, with captions as names
#'
#'@import ggplot2
#'
#'@export
#'
compareFits.SizeComps<-function(objs=NULL,
                                mdfr=NULL,
                                fleets="all",
                                fleet.type=c('survey','fishery'),
                                catch.type=c('index','retained','discard','total'),
                                years='all',
                                plot1stObs=TRUE,
                                nrow=5,
                                ncol=2,
                                pdf=NULL,
                                showPlot=FALSE,
                                verbose=FALSE){

    if (verbose) cat("Starting rCompTCMs::compareFits.SizeComps().\n");
    options(stringsAsFactors=FALSE);

    fleet.type<-fleet.type[1];
    catch.type<-catch.type[1];

    if (fleet.type=='survey') catch.type<-'index';

    #create pdf, if necessary
    if(!is.null(pdf)){
        pdf(file=pdf,width=11,height=8,onefile=TRUE);
        on.exit(grDevices::dev.off());
        showPlot<-TRUE;
    }

    if (is.null(mdfr)){
        mdfr<-rCompTCMs::extractFits.SizeComps(objs,
                                               fleets=fleets,
                                               fleet.type=fleet.type,
                                               catch.type=catch.type,
                                               years=years,
                                               plot1stObs=plot1stObs,
                                               verbose=verbose);
    }

    #----------------------------------
    # define output list of plots
    #----------------------------------
    plots<-list();
    figno<-1;

    #----------------------------------
    # plot fits to size comps
    #----------------------------------
    if (verbose) cat("Plotting",nrow(mdfr),"rows.\n")
    ylab<-""; cap1<-"1";
    if ((catch.type=="index")&&(fleet.type=="survey")) {
        ylab<-"survey size comps";
        cap1<-"  \n  \nFigure &&fno. Comparison of observed and predicted &&xms survey size comps for &&fleet. &&pg.  \n  \n";
    }
    if ((catch.type=="index")&&(fleet.type=="fishery")) {
        ylab<-"fishery CPUE size comps";
        cap1<-"  \n  \nFigure &&fno. Comparison of observed and predicted &&xms index catch (CPUE) size comps for &&fleet. &&pg.  \n  \n";
    }
    if (catch.type=="retained") {
        ylab<-"retained catch size comps";
        cap1<-"  \n  \nFigure &&fno. Comparison of observed and predicted &&xms retained catch size comps for &&fleet. &&pg.  \n  \n";
    }
    if (catch.type=="total") {
        ylab<-"total catch size comps";
        cap1<-"  \n  \nFigure &&fno. Comparison of observed and predicted &&xms total catch size comps for &&fleet. &&pg.  \n  \n";
    }
    xs<-c("male","female","all sex");
    ms<-c("immature","mature","all maturity");
    ss<-c("new shell","old shell","all shell");
    zs<-sort(unique(mdfr$z));

    mxp<-nrow*ncol;
    xlab<-'size (mm CW)';
    if (verbose) cat(paste0("names(mdfr)= '",names(mdfr),"'.\n"));
    for (fleet in unique(mdfr$fleet)){
        if (verbose) cat("Plotting fleet '",fleet,"'.\n",sep='');
        idf<-mdfr$fleet==fleet;
            pxs<-list();
            for (x in xs){
                idx<-mdfr$x==x;
                pms<-list();
                for (m in ms){
                    idm<-mdfr$m==m;
                    pss<-list();
                    for (s in ss){
                        ids<-mdfr$s==s;
                        if (verbose) cat("Checking",x,m,s,"\n");
                        pgs<-list();
                        if (sum(idf&idx&idm&ids,na.rm=TRUE)==0){
                            if (verbose) cat("--Dropping",x,m,s,"\n");
                        } else {
                            if (verbose) cat("--Plotting",x,m,s,"size comps\n");
                            mdfrp<-mdfr[idf&idx&idm&ids,];#select results for fleet, sex, maturity state, and shell condition
                            if (verbose) cat("--Plotting",nrow(mdfrp),"rows.\n")

                            #add in missing years as size comps with 0's
                            ys<-sort(unique(mdfrp$y));
                            mny<-5*floor(min(ys)/5);
                            mxy<-mny+mxp*ceiling((max(ys)-mny+1)/mxp)-1;
                            mdfrpp<-mdfrp[1,];
                            mdfrpp$val<-0;
                            if (mny<min(ys)){
                                for (y in mny:(min(ys)-1)) {
                                    mdfrpp$y<-y;
                                    mdfrp<-rbind(mdfrp,mdfrpp);
                                }
                            }
                            if (mxy>max(ys)){
                                for (y in (max(ys)+1):mxy) {
                                    mdfrpp$y<-y;
                                    mdfrp<-rbind(mdfrp,mdfrpp);
                                }
                            }
                            ys<-mny:mxy;
                            npg<-ceiling(length(ys)/mxp);
                            if (verbose) cat("mny =",mny,",mxy =",mxy,", npg =",npg,'\n')
                            for (y in ys){
                                if (!any(mdfrp$y==y)) {
                                    #year y is missing, so add in zero size comp for year y
                                    mdfrpp$y<-y;
                                    mdfrp<-rbind(mdfrp,mdfrpp);
                                }
                            }

                            rng<-range(mdfrp$val,na.rm=TRUE,finite=TRUE);
                            if (verbose) cat("rng = ",rng,'\n')

                            for (pg in 1:npg){ #loop over pages
                                dfrp<-mdfrp[(mdfrp$y %in% ys[(pg-1)*mxp+1:mxp]),]
                                #do plot
                                pd<-position_identity();
                                p <- ggplot(data=dfrp)
                                p <- p + geom_bar(aes(x=z,y=val,fill=case),data=dfrp[dfrp$type=='observed',],stat="identity",position='identity',alpha=0.5)
                                p <- p + geom_line(aes(x=z,y=val,colour=case),data=dfrp[(dfrp$type=='predicted'),],size=1,alpha=0.5)
                                p <- p + geom_point(aes(x=z,y=val,colour=case,shape=case),data=dfrp[(dfrp$type=='predicted'),],size=1)
                                p <- p + ylim(0,rng[2])
                                p <- p + geom_hline(yintercept=0,colour='black',size=0.5)
                                p <- p + labs(x=xlab,y=ylab)
                                p <- p + facet_wrap(~y,ncol=ncol,dir='v')
                                ttl<-paste0(fleet,': ',x,", ",m,", ",s);
                                if (verbose) cat("Plotting '",ttl,"'.\n",sep='')
                                p <- p + ggtitle(ttl)
                                p <- p + guides(fill=guide_legend('observed'),colour=guide_legend('predicted'),shape=guide_legend('predicted'))
                                xms<-paste0(x,", ",m,", ",s);
                                cp1<-gsub("&&xms",xms,cap1,fixed=TRUE);
                                cp1<-gsub("&&fleet",fleet,cp1,fixed=TRUE);
                                cp1<-gsub("&&pg",paste0("Page ",pg," of ",npg),cp1,fixed=TRUE);
                                if (showPlot) figno<-wtsUtilities::printGGList(p,figno,cp1,showPlot)$figno;
                                plots[[cp1]]<-p;
                            }#pg
                        }#if
                    }#ss
                }#ms
            }#xs
    }#fleets

    if (verbose) cat("Finished rCompTCMs::compareFits.SizeComps().\n");
    return(plots);
}
