# Importing data from external sources

library(terra)
library(imageRy)

setwd("C:/Users/elige/Downloads") # make use of slash instead of backslash
eclissi <- rast("eclissi.png") 

# Plotting the data
im.plotRGB(eclissi, 1, 2, 3)
im.plotRGB(eclissi, 3, 2, 1)
im.plotRGB(eclissi, 2, 3, 1)
im.plotRGB(eclissi, 2, 1, 3)

# Band difference
dif<-eclissi[[1]]-eclissi[[2]]  # this does not make much sense, it's just an example of band differences
plot(dif)

# Importing another image
ocean <- rast("oceanisgreening_2022.jpg")
im.plotRGB(ocean, 1, 2, 3)

# Importing data downloaded from Copernicus
soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc") #nc è tipo jpg/png 
plot(soil) # SSM: soil moisture ; SSM_NOISE: estimated error
plot(soil[[1]])

# Cropping the images using coordinates
ext <- c(25, 30, 55, 58) #definition of the extension of the crop
soilcrop <- crop(soil, ext) #cropping the image using the extension above
plot(soilcrop)
plot(soilcrop[[1]])
