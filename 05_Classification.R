# Classification
# quantyfing land cover change

install.packages("ggplot2")
install.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

# Importing images
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# Classifying images
sunc <- im.classify(sun, num_clusters = 3)

# Doing the same for matogrosso
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg" )
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Classifying images
m1992c <- im.classify(m1992, num_clusters = 2)
m2006c <- im.classify(m2006, num_clusters = 2)
# class 1 = human/naked soil
# class 2 = forest

# Frequencies
# calculating frequencies (number of pixels) of each class to do further analysis 
# "frequencies" is the number of elements belonging to a class
f1992 <- freq(m1992c)
f1992
f2006 <- freq(m2006c)
f2006

# Proportions
tot1992 <- ncell(m1992c) #total number of pixels of the image
tot2006 <- ncell(m2006c)
prop1992 = f1992 / tot1992
prop2006 = f2006 / tot2006

# Percentages
perc1992 = prop1992*100
perc2006 = prop2006*100

# Printing the values
prop1992
prop2006
perc1992
perc2006

# percentages 92: 17% human - 83% forest
# percentages 06: 55% human - 45% forest

# Building a dataframe/dataset
class <- c("forest","human")
p1992 <- c(83, 17)
p2006 <- c(45, 55)

tabout <- data.frame(class, p1992, p2006) 
tabout
# building a dataframe (table) with columns (class, % 1992, % 2006)

# Plotting the output (using ggplot2). It creates a graph
# It needs: the table we are using; aestetics (how do you want it?)...
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") # then I add the geometry stat=identity means "just use the value I don't need any statistics"
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")

# Patchwork
# comparing graphs
# library(patchwork)

p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# varying axis and using lines
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
