#===============================================================================
# Name           : plotlm3d
# Original author: John Fox (scatter3d from package Rcmdr)
# Changes        : Jose Claudio Faria and Duncan Murdoch
# Date (dd/mm/yy): 12/8/06 19:44:37
# Version        : v18
# Aim            : To plot 3d scatter, an or, surfaces with rgl package
# Description    : The simple, power and very flexible function **plotlm3d** enables 
#			you to plot 3d points and/or surfaces obtained from linear methods. 
#			It was adapted from scatter3d 
#			[[http://socserv.socsci.mcmaster.ca/jfox/Misc/Rcmdr/index.html | Rcmdr package]] 
#			of John Fox and some [[ http://www.stat.wisc.edu/~deepayan | Deepayan Sarkar]] ideas.
#		     	It requires the [[rp>rgl]] package that you can download from 
#			[[http://cran.r-project.org|CRAN]]. The version v17 is closed with rgl
#			in development [[http://www.stats.uwo.ca/faculty/murdoch/software|rgl 0.67-470]].
#===============================================================================
# Arguments:
# x                 variable for horizontal axis.
# y                 variable for out-of-screen axis.
# z                 variable for vertical axis (response).
# surface           plot surface(s) (TRUE or FALSE).
# model             one or more linear model to fit ('z ~ x + y' is the default).
# groups            if NULL (the default), no groups are defined; if a factor,
#                   a different surface or set of surfaces is plotted for each
#                   level of the factor; in this event, the colours in plane.col
#                   are used successively for the points and surfaces.
# model.by.group    if TRUE the function will adjust one model for each level
#                   of groups; the order of the models must be the same of the
#                   level of the.
# model.summary     print summary or summaries of the model(s) fit (TRUE or FALSE).
# simple.axes       whether to draw simple axes (TRUE or FALSE).
# box               whether to draw a box (TRUE or FALSE).
# xlab,           
# ylab,           
# zlab              axis labels.
# surface.col       vector of colours for regression planes, used in the order
#                   specified by fit.
# point.col         colour of points.
# grid.col          colour of grid lines on the regression surface(s).
# grid              plot grid lines on the regression surface(s) (TRUE or FALSE).
# grid.lines        number of lines (default, 26) forming the grid, in each of
#                   the x and z directions.
# sphere.factor     relative size factor of spheres representing points; the
#                   default size is dependent on the scale of observations.
# threshold         if the actual size of the spheres is less than the threshold,
#                   points are plotted instead.
# speed             revolutions of the plot per second.
# revolutions       number of full revolutions of the display.
 
plotlm3d <- function (x, y, z,
    surface        = T,
    model          = 'z ~ x + y',
    groups         = NULL,
    model.by.group = F,
    model.summary  = F,
    simple.axes    = T,
    box            = F,
    xlab           = deparse(substitute(x)),
    ylab           = deparse(substitute(y)),
    zlab           = deparse(substitute(z)),
    surface.col    = c('blue', 'orange', 'red', 'green',
                       'magenta', 'cyan', 'yellow', 'gray', 'brown'),
    point.col      = 'yellow',
    grid.col       = material3d("color"),
    grid           = T,
    grid.lines     = 26,
    sphere.factor  = 1,
    threshold      = 0.01,
    speed          = 0.5,
    revolutions    = 0)
{
  require(rgl)
  require(mgcv)
  summaries <- list()
 
  if ((!is.null(groups)) && model.by.group)
    if (!nlevels(groups) == length(model))
      stop('Model number is different of the number of groups')
 
  if ((!is.null(groups)) && (nlevels(groups) > length(surface.col)))
    stop('Number of groups exceeds number of colors')
 
  if ((!is.null(groups)) && (!is.factor(groups)))
    stop('groups variable must be a factor.')
 
  xlab; ylab; zlab  # necessary, but, I think it is a small bug!?
 
  valid <- if (is.null(groups))
    complete.cases(x, y, z)
  else
    complete.cases(x, y, z, groups)
 
  x <- x[valid]
  y <- y[valid]
  z <- z[valid]
  
  if (!is.null(groups))
    groups <- groups[valid]
 
  levs <- levels(groups)
  size <- max(c(x,y,z))/100 * sphere.factor
 
  if (is.null(groups)) {
    if (size > threshold)
      spheres3d(x, y, z, color = point.col, radius = size)
    else
      points3d(x, y, z, color = point.col)
  }
  else {
    if (size > threshold)
      spheres3d(x, y, z, color = surface.col[as.numeric(groups)], radius = size)
    else
      points3d(x, y, z, color = surface.col[as.numeric(groups)])
  }
 
  aspect3d(c(1, 1, 1))
 
  if (surface) {
    xvals <- seq(min(x), max(x), length = grid.lines)
    yvals <- seq(min(y), max(y), length = grid.lines)
    
    dat  <- expand.grid(x = xvals, y = yvals)
 
    for (i in 1:length(model)) {
      if (is.null(groups)) {
        mod <- lm(formula(model[i]))
 
        if (model.summary)
          summaries[[model[i]]] <- summary(mod)
 
        zhat <- matrix(predict(mod, newdata = dat), grid.lines, grid.lines)
        surface3d(xvals, yvals, zhat, color = surface.col[i], alpha = 0.5, lit = F)
 
        if (grid)
          surface3d(xvals, yvals, zhat, color = grid.col, alpha = 0.5,
            lit = F, front = 'lines', back = 'lines')
      }
      else { # groups is not NULL
        if (!model.by.group) {
          for (j in 1:length(levs)) {
            mod <- lm(formula(model[i]), subset = (groups == levs[j]))
 
            if (model.summary)
              summaries[[paste(model[i], '.', levs[j], sep = '')]] <- summary(mod)
 
            zhat <- matrix(predict(mod, newdata = dat), grid.lines, grid.lines)
            surface3d(xvals, yvals, zhat, color = surface.col[j], alpha = 0.5, lit = F)
 
            if (grid)
             surface3d(xvals, yvals, zhat, color = grid.col, alpha = 0.5,
                lit = F, front = 'lines', back = 'lines')
 
            texts3d(min(x), min(y), predict(mod, newdata = data.frame(x = min(x), y = min(y),
              groups = levs[j])), paste(levs[j], ' '), adj = 1, color = surface.col[j])
          }
        }
        else { # model.by.group is TRUE
          mod <- lm(formula(model[i]), subset = (groups == levs[i]))
 
          if (model.summary)
            summaries[[paste(model[i], '.', levs[i], sep = '')]] <- summary(mod)
 
          zhat <- matrix(predict(mod, newdata = dat), grid.lines, grid.lines)
 
          surface3d(xvals, yvals, zhat, color = surface.col[i], alpha = 0.5, lit = F)
 
          if (grid)
            surface3d(xvals, yvals, zhat, color = grid.col, alpha = 0.5,
              lit = F, front = 'lines', back = 'lines')
 
          texts3d(min(x), min(y), predict(mod, newdata = data.frame(x = min(x), y = min(y),
            groups = levs[i])), paste(levs[i], ' '), adj = 1, color = surface.col[i])
        }
      }
    }
  }
  
  if(simple.axes) {
    axes3d(c('x', 'y', 'z'))
    title3d(xlab = xlab, ylab = ylab, zlab = zlab)
  }
  else
    decorate3d(xlab = xlab, ylab = ylab, zlab = zlab, box = box)
 
  if (revolutions > 0) {
    start <- proc.time()[3]
    startMatrix <- par3d("userMatrix")
    while ((theta <- speed*(proc.time()[3] - start))/2/pi < revolutions) {
      rgl.viewpoint(userMatrix = rotate3d(startMatrix, theta, 0, 0, 1))
    }
  }

  if (model.summary)
    return(summaries)
  else
    return(invisible(NULL))
}