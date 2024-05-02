# Multivariate analysis

library(imageRy)
library(terra)
library(viridis)

#listing data
im.list()

#importing data
b2 <- im.import("sentinel.dolomites.b2.tif") #blue
b3 <- im.import("sentinel.dolomites.b3.tif") #green
b4 <- im.import("sentinel.dolomites.b4.tif") #red
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

sentdo <- c(b2, b3, b4, b8)

im.plotRGB(sentdo, r=4, g=3, b=2)
#siamo partiti dal nome delle bande originali e li abbiamo importati dopodiche abbiamo fatto uno stack con 4 bande tutte assieme in un immagine
im.plotRGB(sentdo, r=3, g=4, b=2)

pairs(sentdo)
#correlazione tra dati: non sempre c'è una causalità se si correla tra loro > 

# pca #im tutti inizi imagery
pcimage <- im.pca(sentdo)

tot <- sum(1429.02963, 604.34893, 48.67793, 35.42634)
1429.02963*100/ tot
604.34893*100/ tot
48.67793*100/ tot
35.42634*100/ tot

vir <- colorRampPalette(viridis(7))(100)
plot(pcimage, col=vir)

#PC1 => prima componente spiega il 70% del range quindi praticamente uguale alla prima, PC2 e PC3 sono quelle peggior, hanno una minore percentuale di variabilità => siamo passati da un sistema quadridimensionale ad uno più o meno monodimensionale
plot(pcimage, col=viridis(100)) #codice di irene :), scegliere se utilizzare viridis, plasma etc..

#PCA per portare un sistema da n bande ad una banda sola


