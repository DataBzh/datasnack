library(ggplot2)
library(rgdal)
cotes <- read.csv("/home/colin/Dropbox/R/misc/pack.master.cotes-darmor.tourismattractions_museums.csv", stringsAsFactors = FALSE)[,1:3]
fin <- read.csv("/home/colin/Dropbox/R/misc/pack.master.finistere.tourismattractions_museums.csv", stringsAsFactors = FALSE)[,1:3]
ill <- read.csv("/home/colin/Dropbox/R/misc/pack.master.ille-et-vilaine.tourismattractions_museums.csv", stringsAsFactors = FALSE)[,1:3]
mor <- read.csv("/home/colin/Dropbox/R/misc/pack.master.morbihan.tourismattractions_museums.csv", stringsAsFactors = FALSE)[,1:3]
cotes$dep <- "Côtes d'Armor"
fin$dep <- "Finistère"
ill$dep <- "Ille-et-Vilaine"
mor$dep <- "Morbihan"
bret <- rbind(cotes, fin, ill, mor)
table(bret$dep)
roj <- readOGR(dsn=".", layer="R53_dep")
wmap_df <- fortify(roj)
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon(fill = "#012C2C") + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group, fill=NULL), color="black") +
  geom_point(data = bret, aes(x = lng, y = lat, group = NULL, col = dep),size = 5) + 
  scale_color_manual(values = palette) +   
  ggtitle("Musées en Bretagne") +
  xlab("") +
  ylab("") +
  labs(color = "Département", 
       caption = "http://data-bzh.fr") + 
  theme(title=element_text(),
        plot.title=element_text(margin=margin(0,0,20,0), size=30, hjust = 0.5),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(), 
        panel.grid.major= element_blank(), 
        panel.background= element_blank()) 
