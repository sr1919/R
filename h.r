source("ext/plot.depth.r")

load <- function(){
    t<-read.csv("data/hg-report.csv", strip.white=TRUE)
    return( t )
}

plot.depth(
    t,# data.frame
    yaxis.first=TRUE, # is 1st data-column 1st y-axis?
    yaxis.num="n", # supress labelling at y-axis
    xaxis.num="s", # show labelling at x-axis
    xaxes.equal=TRUE, # equal scaling
    xaxis.ticks.minmax=FALSE, # only min-max?
    cex.x.axis=par("cex.axis")*0.8,# size x-axis labels
    cex.y.axis=par("cex.axis")*0.8,# size y-axis labels
    yaxis.lab=FALSE, # axis labels on remaining y-axis?
    yaxis.ticks=TRUE,# add y-ticks to graph?
    axis.top=list(c(FALSE, FALSE)),# axis on top? c(axis=TRUE, labels=TRUE)
    nx.minor.ticks=5,# number intervals for minor ticks
    ny.minor.ticks=5,# number intervals for minor ticks
    bty="L", # boxtype
    plot.type="o", # point-plot type
    plot.before=NULL,# something to plot BEFORE the graph is drawn?
    plot.after=NULL,# something to plot AFTER the graph is drawn?
    l.type="solid", # line type
    l.width=1,# line width
    lp.color="black", # line/point color
    p.type=21,# point type
    p.bgcolor="white",# point background color
    p.size = 1, # point size
    mar.outer=c(1,6,4,1),# outer margin of whole plot
    mar.top=9,# margin on the top
    mar.bottom=5,# margin on the bottom
    mar.right=0,# margin on the right side
    txt.xadj=0.1,# x-adjusting text
    txt.yadj=0.1,# y-adjusting text
    colnames=TRUE,# add columnames
    rotation=60,# columnames rotation
    subtitle="",# below every plot
    xlabel="",# x-labels
    ylabel="",# first y-label
    main="",# title for each plot
    polygon=FALSE, # plot Polygon?
    polygon.color="gray", # color polygon
    show.na=TRUE,# show missing values?
    min.scale.level=0.2,#0...1 if data are less than 0.2(=20%)
    min.scale.rel=0.5,#0...1 relative space for minimal data
    min.scaling=FALSE,#switch min scaling
    color.minscale="gray95",# color for minimum scaled data
    wa.order="none" # sort variables according to the weighted average with y
)