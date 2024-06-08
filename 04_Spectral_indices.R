#spectral indeces

library(terra)
library(imageRy)

#list of files within imageRy

im.list()

# Extract and assign the needed file 

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") #picture taken from earth observator by NASA
                                                  #this is a landst image (false colour image)
# band 1 = NIR= R
# band 2 = red = G
# band 3 = green = B                                               

# Plotting the data
im.plotRGB(m1992, r=1, g=2, b=3)

# NIR on green
im.plotRGB(m1992, 2, 1, 3)

# NIR on blue
im.plotRGB(m1992, 2, 3, 1)
# to see the naked soil we use color yellow, NIR on blue
# water appears yellow as soil because it's full of sediment

# Now we compare 1992 with 2006: 

#Extraxt and assign the second file

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") #picture from aster
im.plotRGB (m2006, 1, 2, 3)

# NIR on green
im.plotRGB(m2006, 2, 1, 3)

# NIR on blue
im.plotRGB(m2006, 2, 3, 1)
#in the cases above the position of the other bands is the same (I think)

par(mfrow=c(1,2))
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m2006, 1, 2, 3)

# multiframe
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) #NIR on R 1992
im.plotRGB(m1992, 2, 1, 3) #NIR on G 1992
im.plotRGB(m1992, 2, 3, 1) #NIR on B 1992
im.plotRGB(m2006, 1, 2, 3) #NIR on R 2006
im.plotRGB(m2006, 2, 1, 3) #NIR on G 2006
im.plotRGB(m2006, 2, 3, 1) #NIR on B 2006
# plot(m2006[[1]]) # plot NIR

# Calculating the DVI (Difference Vegetation Index)
# DVI = NIR - RED --> simply subtract bands
# bands: 1=NIR, 2=RED, 3=GREEN

# 1992:
dvi1992 = m1992[[1]] - m1992[[2]] #subtractig RED to NIR
# alternative way of coding:
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2

# Plotting the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100) #creating the palette
plot(dvi1992, col=cl) #plotting
dvi1992 #visualizing the index values

# 2006:
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)

# Exercise: plot the dvi1992 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# Normalized Difference Vegetation Index (NDVI)
# this is used instead of the DVI when working with images that have a different number of bits. 
# This way it is possible to make a comparison after the normalization

ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]]) # an extend version would be ndvi92=(mato92[[1]]-mato92[[2]])/(mato92[[1]]+mato92[[2]])
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]]) # same as above but for 2006

dev.off()
# plotting the two images together
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

