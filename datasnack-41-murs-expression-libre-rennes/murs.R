library(ggplot2)
library(rgdal) 
library(magrittr)
source("data-bzh-tools-master/main.R")
graph <- read.csv2("https://data.rennesmetropole.fr/explore/dataset/murs-dexpression-libre-street-art-et-graffitis/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true", stringsAsFactors = FALSE)
graph <- subset(graph, type_mur == "Mur autorisé") %>%
  tidyr::separate(Geo.Point, c("y","x"), sep = ",") 
graph$longueur <- gsub("m", "", graph$longueur)
for(i in 1:nrow(graph)){
  if(grepl("\\+", graph[i, "longueur"])){
    x <- graph[i,"longueur"] %>%
      strsplit(" \\+ ")
    x <- sum(as.numeric(x[[1]]))
    graph[i, "longueur"] <- as.numeric(x)
  }
}
graph$longueur <- as.numeric(graph$longueur)
graph$hauteur <- gsub("m", "", graph$hauteur)
graph$hauteur <- gsub(",", ".", graph$hauteur)
for(i in 1:nrow(graph)){
  if(grepl("à", graph[i, "hauteur"])){
    x <- graph[i,"hauteur"] %>%
      strsplit(" à ")
    x <- mean(as.numeric(x[[1]]))
    graph[i, "hauteur"] <- as.numeric(x)
  }
}
graph$hauteur <- as.numeric(graph$hauteur)
graph$`Superficie (en m2)` <- graph$longueur * graph$hauteur
roj <- readOGR(dsn=".", layer="perimetres-des-45-sous-quartiers-de-la-ville-de-rennes")
wmap_df <- fortify(roj)
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon(fill = "#e4e4e4") + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group), color="grey50") + 
  geom_point(data=graph, aes(as.numeric(x), as.numeric(y), group = NULL, size = `Superficie (en m2)`), color = databzh$colours[2]) + 
  scale_size(range = c(1,12)) +
  xlab("") +
  ylab(" ") +
  labs(title = "Murs d'expression libre (Street Art et graffitis) sur le territoire de la Ville de Rennes", 
       subtitle = "Données via : Open Data Rennes",
              caption = "http://data-bzh.fr") + 
  theme(title=element_text(),
        plot.title=element_text(margin=margin(0,0,20,0), size=18, hjust = 0.5),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major= element_line("grey50", linetype = "dashed"), 
        panel.background= element_blank()) 
