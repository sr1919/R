#source("ext/plot.depth.r")

load <- function(){
    t<-read.csv("data/report.csv", header = FALSE, strip.white=TRUE)
    return( as.matrix(t) )
}

#hg<-array( load()->x, dim(x) )
hg<-load()
class( hg )
dim( hg )
fix( hg )

for( i in 1:nrow( hg ) ){
    plot( hg[i,], hg[1,] ) 
}
