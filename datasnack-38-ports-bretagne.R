library(magrittr)
library(rgdal) 
library(ggplot2)
donnees <- httr::GET("https://inspire.data.gouv.fr/api/geogw/services/556c6042330f1fcd4833794d/feature-types/rb:port/download?format=GeoJSON&projection=WGS84")
donnees <- donnees$content %>%
  rawToChar() %>%
  rjson::fromJSON()
frame <- lapply(donnees$features, function(obj){
  data.frame(id = obj$properties$gml_id,
             ville = obj$properties$libelle_po,
             codeInsee = obj$properties$insee_comm, 
             lat = obj$geometry$coordinates[[1]][[1]], 
             long = obj$geometry$coordinates[[1]][[2]])
}) %>% do.call(rbind, .) %>% 
  unique()
frame$Département <- NA
frame[grep("^22", frame$codeInsee),"Département"] <- "Côtes d'Armor"
frame[grep("^29", frame$codeInsee),"Département"] <- "Finistère"
frame[grep("^35", frame$codeInsee),"Département"] <- "Ille-et-Vilaine"
frame[grep("^56", frame$codeInsee),"Département"] <- "Morbihan"
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
roj <- readOGR(dsn=".", layer="R53_dep")
wmap_df <- fortify(roj)
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon() + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group, fill=NULL), color="grey50") +
  geom_point(data = frame, aes(x = lat, y = long, group = NULL, col = Département),size = 4) + 
  scale_color_manual(values = palette) + 
  labs(title = "Les Ports de Bretagne") + 
  theme(title=element_text(),
        plot.title=element_text(margin=margin(0,0,20,0), size=30, hjust = 0.5),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major= element_line("grey50", linetype = "dashed"), 
        panel.background= element_blank()) 
