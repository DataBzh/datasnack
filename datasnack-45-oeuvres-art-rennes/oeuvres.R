library(tidyverse) 
pat <- read_csv2("https://data.rennesmetropole.fr/explore/dataset/les-oeuvres-dart-sur-le-domaine-public-de-la-ville-de-rennes/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
pat <- separate(data = pat, col = `Geo Point`, into = c("lat", "lon"), sep =",")
pat$oeuvre_date <- substr(pat$oeuvre_date, 1, 4) %>%
  as.numeric()
pat$Date <- floor(pat$oeuvre_date / 10)*10
pat$Date <- paste0(as.character(pat$Date), "'s")
  
wmap_df <- readOGR(dsn=".", layer="perimetres-des-45-sous-quartiers-de-la-ville-de-rennes") %>% 
  fortify()
ggplot(wmap_df, aes(long,lat, group=group)) + 
  geom_polygon(fill = "#e4e4e4") + 
  coord_map() +
  geom_path(data=wmap_df, aes(long, lat, group=group), color="grey50") + 
  geom_point(data=pat, aes(as.numeric(lon), as.numeric(lat), group = NULL, col = Date), size = 4) + 
  scale_color_manual(values = databzh$colours) +
  xlab("") +
  ylab(" ") +
  labs(title = "Les œuvres d'art sur le domaine public de la ville de Rennes", 
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
