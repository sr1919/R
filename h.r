#===============================================================================
# Name           : h
# Original author: Sergey Shkvyra <sr1919@gmail.com>
# Changes        : 
# Date (yy/mm/dd): 12/11/21
# Version        : v0.1
# Brief          : Generate graphics (png files) from homogeneity data
# Usage          : h.r <data.csv> <folder>
#                :  data.csv - file in csv format with homogeneity data
#                :  folder   - name of output folder where to save images
#===============================================================================


#
#   load data from and return as matrix
#
load <- function( 
    f   #   csv file with data
){
    t <- as.matrix( read.csv( f, header = FALSE, strip.white=TRUE) )
    return( t )
}

run <- function() {

    # get input file name
    args <- commandArgs(trailingOnly = TRUE)
    inp.file <- args[1]
#    if( nchar(inp.file) == 0 ){
#        print( getwd() )
#        inp.file <- "homogeneity.csv"
#    }

    hg <- load( inp.file )
    mx <- 1.1 * max( hg )

    # set output folder
    out.folder <- args[2]
#    if( nchar( out.folder ) == 0 ){
#        out.folder <- "img"
#    }
    if( !file.exists( out.folder) ){
        dir.create( out.folder )
    }
    else{
        #print( list.files( out.folder ) )
        file.remove( list.files( out.folder ) )
    }
    out.folder <- paste( out.folder, "\\%03d.png", sep ="" )

    # set graphics params
    par( 
        #mai = c( 1, 1, 0.5, 0.5 ), 
        #mar = c( 2, 2, 1, 1 ), 
        mgp = c( 0, 0, 0 ), 
        omi = c( 0, 0, 0, 0 ),
        cex = 0.7 )

    # generate graphics
    png( out.folder, width=500, height=200 )
    for( i in 1:nrow( hg ) ){
        plot( hg[i,], 
            ylim = c( 0, mx ),
            type = "s", ylab = "Graylevel", xlab = paste("Row", i, sp="") )
        grid()
    }
    dev.off()
}

run()
