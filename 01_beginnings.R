#First R script

#R as a calculator ("<-"= create an object)
a <- 6^3
b <- 5*8
a+b

# R for arrays and matrix calculation ("c"= is used to group elements into a single object)
flowers<-c(3,6,8,10,15,18)
insects<-c(10,16,25,42,61,73)

# plot arrays
plot(flowers, insects)

#changing plot parameters:

#symbols
plot(flowers, insects, pch=19)

#symbol dimensions
plot(flowers, insects, pch=19, cex=2)
plot(flowers, insects, pch=19, cex=.5)

#color
plot(flowers, insects, pch=19, cex=.5, col="chocolate3")

#name x and y asses
plot(flowers, insects, pch=19, cex=.5, col="chocolate3", ylab="insetti", xlab="fiori")




