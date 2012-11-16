#library("RSvgDevice")
png("histogram.png", width = 320, height = 480 )
set.seed(50)
par(mar=c(3,2,1,1),yaxs="i",mgp=c(1.8,.9,0))
hist(rnorm(100),col="lightblue",
    main="",xlab="",ylab="",ylim=c(0,28))
box()
dev.off()

#   on same graphic
N <- 100
x1 <- rnorm(N)
x2 <- rnorm(N) + x1 + 1
y <- 1 + x1 + x2 + rnorm(N)
mydat <- data.frame(y,x1,x2)
matplot(mydat[,1],mydat[,2:3], pch = 1:2)

# several graphics
par(mfrow = c(3,2))
plot(x1, type = "n")
plot(x1, type = "p")
plot(x1, type = "l")
plot(x1, type = "h")
plot(x1, type = "s")
plot(x1, type = "S")