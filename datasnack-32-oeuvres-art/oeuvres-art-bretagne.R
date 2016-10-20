library(ggplot2)
library(magrittr)
library(ggmap)
cotes <- read.csv("pack.master.cotes-darmor.artworks.csv", stringsAsFactors = FALSE)[,1:4]
fin <- read.csv("pack.master.finistere.artworks.csv", stringsAsFactors = FALSE)[,1:4]
ill <- read.csv("pack.master.ille-et-vilaine.artworks.csv", stringsAsFactors = FALSE)[,1:4]
mor <- read.csv("pack.master.morbihan.artworks.csv", stringsAsFactors = FALSE)[,1:4]
cotes$dep <- "Côtes d'Armor"
fin$dep <- "Finistère"
ill$dep <- "Ille-et-Vilaine"
mor$dep <- "Morbihan"
bret <- rbind(cotes, fin, ill, mor)
for(i in 1:nrow(bret)){
  if(nchar(bret[i,4]) == 0){
    bret[i,4] <- "Indisponible"
  }
}
table(bret$dep)
table(bret$tag__artwork_type)
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
map <- ggmap::get_openstreetmap(bbox = c(left = -4.8, bottom = 47.3, right = -1, top = 48.9))
ggmap(map)  +
  geom_point(data = bret, aes(x = as.numeric(lng), y = as.numeric(lat), col = tag__artwork_type), size = 3) +
  scale_color_manual(values = palette) + 
  ggtitle("Oeuvres d'art en Bretagne") +
  xlab("") +
  ylab("") +
  labs(color = "Type d'oeuvre") + 
  theme(title=element_text(size=18),
        plot.title=element_text(margin=margin(0,0,20,0), size=18),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank())
