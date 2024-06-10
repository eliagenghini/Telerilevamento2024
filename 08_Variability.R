# Measuring variability from satellite imageRy

library(imageRy)
library(terra)
install.packages("viridis")
library(viridis)

im.list()

sent <- im.import("sentinel.png") 

im.plotRGB(sent, r=1, g=2, b=3) 
# (vegetazione è diventata rossa mentre il suolo nudo diventa celeste + crepacci scuri, bianco è nuvole e neve)

# NIR = band 1
# red = band 2
# green = band 3

im.plotRGB(sent, r=2, g=1, b=3) 
# (prateria diventa verde fluo, mentre boschi diventano un pò più scuri)

# Spectral Variability (calcoliamo variabilità immagine)
nir <- sent[[1]]
plot(nir) # plotting NIR 

cl <- colorRampPalette(c("red", "orange","yellow"))(100) 
plot(nir, col=cl)

#focal: tira fuori statistiche in un gruppo di valori, in questo caso la deviazione standard

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # 1 definisco la matrice # 2 definisco la variabilità, standard deviation
plot(sd3)

#ora cambiamo palette per aiutare i daltonici:
viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col=viridisc)

# Standard deviation 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# stack
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)

