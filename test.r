# create random dataset
test <- data.frame( #
  "tiefe"= tiefe <- 0:(-29)-20,
  a <- sample(90, 30, replace = TRUE),
  b <- sample(90, 30, replace = TRUE),
  c <- sample(9, 30, replace = TRUE),
  d <- sample(90, 30, replace = TRUE),
  e <- sample(90, 30, replace = TRUE),
    # data with NA
  f <- c(
    rep(NA, 5), # 5 x NA
    sample(90, 10, replace = TRUE),
    rep(NA, 5), # 5 x NA
    sample(90, 10, replace = TRUE)),
  g <- sample(90, 30, replace = TRUE),
  h <- g,
  i <- sample(90, 30, replace = TRUE)
)
# add column names
(colnames(test)[2:ncol(test) ] <- paste("Name #",letters[1:(ncol(test)-1)]))
 
 # Example 1: default -------------------------------
    par(las=1) # labels on axis
      plot.depth(test)
 
# Example 2: axis top -------------------------------
    par(las=1) # labels on axis
      plot.depth(test, axis.top=list(c(T,F)))
 
# Example 3: colors and types -------------------------------
    (color <- rep(c("darkred","orange","blue3"), each = 10))
    bluetored <- rainbow(5, s=0.5, v=0.9, start=0.65, end=1)
    color.coldwarm <- c(bluetored, bluetored[5:1], bluetored, bluetored[5:1], bluetored, bluetored[5:1])
    par(las=1) # labels on axis
      plot.depth(test,
        plot.type = c("h","h","p","o","c","b", "s", "S", "n") -> type,
        polygon = c(rep(FALSE, 8), TRUE),
        xlabel = paste("type ",type, sep = ""), # Info
        l.width = c(12,12,1,1,1,1,1,1,1), # line widths
        lp.color = list(color, # plot 1
          color.coldwarm, # plot 2; 30 colors
          "red", # plot 3
          "darkred", # plot 4
          "blue1", # plot 5
          "blue2", # plot 6
          "blue3", # plot 7
          "blue4", # plot 8
          "white" # plot 9
        ) # End list color
      ) # End plot.depth()
 
# Example 4:  lines+points -------------------------------
    par(las=1) # labels on axis
    bluetored <- rainbow(15, s=0.5, start=0.6, end=1)
    color.points <- c(bluetored, bluetored[15:1])
    plot.depth(test,
      plot.type = "o",
      # points
      p.type = list(1,2,3,4,21,16,17,c(1:25,1:5),5), # as for pch
      p.bgcolor = list("white", "white", "white", "white", # 1, 2, 3, 4th plot
        color.points, # at plot 5
        "white","white", "green", "white" # 6 7 8 9
      ),
      p.size = list(1, 1, 1, 1, 4, 1, 1,  seq(1, 3, length.out=30), 1 ),
      l.width = list(2, 4, 1, 0.5, 1, 1, 1, 1, 1 ),
      # lines: character, numeric, manuell
      l.type = list("solid",2,3,4,5,6,"64141414","88","solid"),
      lp.color = rainbow(9) # line/point-fg color
    )
 
 
# Example 5: scaled rare data -------------------------------
    plot.depth(test,
      plot.type = "n",
      mar.outer = c(1,10,4,1), # more space at the left
      mar.top = 12, # more palce on top
      polygon = T,
      rotation = c(1:9)*10, # 10 20 30 ... 80
      min.scale.level = 0.12, # 12%-level of maximum
      min.scaling = c(F,F,5,F,F,F,F,F,F), # T - TRUE, F - FALSE
      color.minscale = "orange"   # Farbe
    )
 
# Example 6: additinal plots -------------------------------
    plot.depth(test,
      plot.before=expression(c(par(xpd=F),grid())), # add grid, but not in outer region
      plot.after=list(
        NULL, # 1. plot
        expression( # at the 2. plot:
          # data from 4th plot
          segments(0, test[,1], test[,4], test[,1], lend=2, lwd=10, col="darkred"),
          # daten fron 4th Graph
          lines(x=test[,4],y=test[,1], col="darkred", lty="solid", pch=16, type="o"),
          # daten fron 2nd Graph
          lines(x=test[,2],y=test[,1], col="red", pch=21 , lty="dotted", type="o", bg="white")
        ), # end expression(..)
        NULL, NULL, NULL, NULL, NULL, NULL, NULL
        # 3. 4. 5. 6. 7. 8. 9. plot
      ), # end list(..) in Option 'plot.after'
      axis.top=list( # top lables
        c(TRUE, FALSE), # 1. ticks-yes, numbers-no
        c(T, T), # 2.
        c(F, T), # 3.
        c(F, F), # 4.
        c(T, F), # 5.
        c(T, F), # 6.
        c(T, F), # 7.
        c(T, F), # 8.
        c(T, F) # 9.
      ),
      colnames=c( # column names
        T, F, T, T, T, T, T, T, T
      )
    ) # End plot.depth(..)
 
# Example 7: additional axes -------------------------------
    testabiotic <- cbind(
      test[,1], # depth data from 1st column
      "TOC"= toc <- sample(30, replace=TRUE),
      "deltaN"=deltaN <- rnorm(30),
      test[,-1] # rest of data
    )
    # text for axis
    text <- letters[1:12]
    # axis positions
    where.y <- c(-20, -26, -27, -28, -33, -35, -38, -40, -42,-46, -48, -49)
    par(las=1)
    plot.depth(testabiotic,
      mar.outer = c(1, 12, 4, 1), # c(bottom , left , top, right)
      bty ="c", # box like a 'C'
      plot.before =list(
        expression( # at 1. plot
          axis(side=2, labels=text, at=where.y, pos=-30, col="red"),
          # y-axis with text + at
          axis(side=2, pos=-60, col="blue", yaxp=c(-20, -50, 24))
          # special axis intervals
        ),
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
        # 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. plot
      ),
      xaxes.equal = c(F,F,rep(T, 9)), # not equal axes on all axes
      colnames = c(F,F,rep(T, 9)),
      xlabel = list(
        "", # 1. plot
        expression(delta^15 ~ N), # 2. plot
        "count", # 3. plot
        "count", # 4. plot
        "count", # 5. plot
        "count", # 6. plot
        "count", # 7. plot
        "count", # 8. plot
        "count", # 9. plot
        "count", # 10. plot
        "count" # 10. plot
      ),
      subtitle = c(
        "TOC \n%", # 1. plot
        rep("", 10) # 2. ... 11. plot
      )
    ) # Ende plot.depth(..)
    # labelling y-axes with mouse
    par(xpd=TRUE) -> original # save graphical parameter
      # from left to right
      locator(1) -> where # mit Maus setzen
      text(where$x, where$y, "depth special (m)", adj=0, srt=90, col= "blue")
      # adj=0 linksbündig; srt=90 Grad drehen
      locator(1) -> where # mit Maus setzen
      text(where$x, where$y, "zones", adj=0, srt=90, col= "red")
      locator(1) -> where # mit Maus setzen
      text(where$x, where$y, "depth (m)", adj=0, srt=90)
    par(original) # Grafikeistellungen für xpd wieder zurück
 
# Example 8: equal scaling of x-axes -------------------------------
    plot.depth(testabiotic,
      min.scale.level=1,
      min.scale.rel=1
    )
 
# Example 9: no equal scaling of x-axes -------------------------------
library(palaeo) # http://www.campus.ncl.ac.uk/staff/Stephen.Juggins/analysis.htm
data(aber)
plot.depth(aber,
  yaxis.first=FALSE,
  polygon=TRUE,# Polygon
  min.scaling=TRUE,# switch on minimum-scaling 
  plot.type="n",# no points
  xaxes.equal=FALSE, # no equal x axes
  xlabel="%", 
  ylabel="sample number",
  xaxis.ticks.minmax=TRUE,# show only min to max
  yaxis.ticks=FALSE,# no  main y ticks
  nx.minor.ticks=0,
  bty="n"# no box
)
title("'xaxes.equal=FALSE'")
 
 
# Example 10:  labelling -------------------------------
    par(las = 1)
    plot.depth(test,
      yaxis.num="s",
      colnames = c(T,T,F,T,F,F,T,T,T), # T - TRUE, F - FALSE
      xlabel = list("count", "%",
        expression(mg%.%l^-1), # mg · l−1 
        expression(sum(species)), #
        expression(paste("%-",O[2])), # % − O2
        expression(CO[3]^paste(2," -")), # CO2−  3
        "count","",
        "count"
      ),
      subtitle = list("","","","","","","",
        expression(over(count[x],count[y])),""  # fract: count_x / count_y
      )
    )
 
# Example 11: weigthed averaging according to depth and colSum  -------------------
library(palaeo) # http://www.campus.ncl.ac.uk/staff/Stephen.Juggins/analysis.htm
data(aber)
plot.depth(aber,
  yaxis.first=FALSE,
  polygon=TRUE,# Polygon
  min.scaling=TRUE,# switch on minimum-scaling 
  plot.type="n",# no points
  xaxes.equal=FALSE, # no equal x axes
  xlabel="%", 
  ylabel="sample number",
  xaxis.ticks.minmax=TRUE,# show only min to max
  yaxis.ticks=FALSE,# no  main y ticks
  nx.minor.ticks=0,
  bty="n",# no box
  wa.order = "topleft" # plot abundant species topleft
)
title("'wa.order=\"topleft\"'\nsorting according to depth + column sum")
