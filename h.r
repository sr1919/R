load <- function(){
    t <- as.matrix( read.csv("data/report.csv", header = FALSE, strip.white=TRUE) )
    #class( t )
    #dim( t )
    #fix( hg )
    return( t )
}

run <- function() {

    hg <- load()
    mx <- 1.1 * max( hg )

    par( mar = c( 2, 2, 1, 1 ), 
        mgp = c( 2, .5, 0 ), 
        cex = 0.7 )

    for( i in 1:nrow( hg ) ){
        file<-paste( paste("report/img", i, sep="" ), ".png", sep="" )

        png( file, width=500, height=200 )
        plot( hg[i,], 
            ylim = c( 0, mx ),
            type = "s", ylab = "", xlab = "" )
        grid()
        dev.off()
    }

    plot( hg[10,], 
        ylim = c( 0, mx ),
        type = "s", ylab = "", xlab = "" )
        grid()
}

run()
