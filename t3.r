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
(colnames(test)[2:ncol(test) ] <- paste("#",letters[1:(ncol(test)-1)]))

# Example 3: colors and types -------------------------------
t3 <- function(){
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
 }