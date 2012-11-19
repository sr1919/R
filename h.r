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
	png( "img.png", width=400, height=100 )
    #plot( hg[i,], type"l", ylab="graylevel", xlab="row" )
    plot( hg[i,], type"l", ylab="", xlab="" )
    dev.off()
}
