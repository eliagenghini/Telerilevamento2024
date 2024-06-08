# satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

#All functions begin with ".im"

#List of data available in the package imageRy
im.list() 


# Importing data from the list
mato <- im.import("matogrosso_ast_2006209_lrg.jpg") 
# I assigned it to the object 'mato'
# Image comes from Earth Observatory by NASA
# https://earthobservatory.nasa.gov/ you may use this website to gather images for your project

# Plotting the data 1
plot(mato)

# Importing another image to see different bands
b2 <- im.import("sentinel.dolomites.b2.tif")    
# Sentinel-2's band 2 (b2) corresponds to the wavelength of the color blue
# this place is Le Tofane
# the image shows the variation of reflection of the color blue:
# Low values = low reflection, high absorption (plants commonly absorb blue)
# High values = high reflection, low absorption (rocks reflect blue, and in general all the bands)

color
# Plotting the data 2

# changing color palette
clg <- colorRampPalette(c("black", "grey", "white"))(3)
clg <- colorRampPalette(c("black", "grey", "white"))(100) # the number outside the main argument defines how many shades will be shown
plot(b2, col=clg)                                         # you can use as many colors as you want

# changing color palette
clcyan <- colorRampPalette(c("magenta", "cyan4", "yellow"))(3) 
clcyan <- colorRampPalette(c("magenta", "cyan4", "yellow"))(100) # the number outside the main argument defines how many shades will be shown
plot(b2, col=clcyan)

# changing color palette 
clch <- colorRampPalette(c("magenta", "cyan4", "cyan", "chartreuse"))(300) # the number outside the main argument defines how many shades will be shown
plot(b2, col=clch)


# Importing additional bands
# import the green band from Sentinel-2 (band 3) (560 nm)
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=clch)

# import the red band from Sentinel-2 (band 4) (665 nm)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clch)

# import the NIR band from Sentinel-2 (band 8) (842)
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clch)


# Creating a multiframe
# it works like a matrix (rows and columns), this one would be a 2x2 matrix

par(mfrow=c(2,2)) 
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

# Exercise: plot the four bands in a single raw

par(mfrow=c(1,4)) 
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)

# Let's make a satellite image
# overlapping the four bands creating a stack (making of a satellite image)
# it uses metadata to give names to the plots using the names of the images
# that's a better way than the previous one

stacksent<-c(b2, b3, b4, b8)
plot(stacksent, col=clch)

dev.off() 
# delete the previous device/results

# RGB plotting
# stacksent[[1]] = b2 = blue
# stacksent[[2]] = b3 = green
# stacksent[[3]] = b4 = red
# stacksent[[4]] = b8 = NIR

# ES: plot(stacksent[[4]], col=clch) 
# I'm using two square parenthesis because stacksent is 2-dimensional object, if it were an array I would have used one set of parenthesis

# im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, 3, 2, 1) #the same as above
im.plotRGB(stacksent, 4, 2, 1) 
# NIR makes vegetation easier to visualize so I replace other colors with it

# Exercise: make a plot with the natural color and the false color images
par(mfrow=c(1,2))
im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, 4, 2, 1)

# Other combinations
par(mfrow=c(1,3))
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)
im.plotRGB(stacksent, 4, 3, 2)

dev.off()
# NIR on green
im.plotRGB(stacksent, 3, 4, 2)

# NIR on blue, this makes soil appear as yellow
im.plotRGB(stacksent, 3, 2, 4)


# Exercise: put the 4 images all together
par(mfrow=c(2,2))
im.plotRGB(stacksent, r=3, g=2, b=1) # natural colour
im.plotRGB(stacksent, 4, 2, 1)       # NIR on red
im.plotRGB(stacksent, 3, 4, 2)       # NIR on green
im.plotRGB(stacksent, 3, 2, 4)       # NIR on blue

# correlate variables, it also calculates Pearson's Correlation Index and data frequency
pairs(stacksent)






