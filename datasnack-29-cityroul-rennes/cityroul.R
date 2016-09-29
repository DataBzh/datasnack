library(ggplot2)
cityroul <- read.csv2("https://data.explore.star.fr/explore/dataset/mkt-partenaires-cityroul-td/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
cityroul <- tidyr::separate(cityroul, Coordonnees, into = c("lat", "lon"), sep = ",")
ggmap::qmap('Rennes', zoom = 12, maptype = "roadmap") +
geom_point(data = cityroul, aes(x = as.numeric(lon), y = as.numeric(lat)), col = "#973232") +
  ggtitle("Stations du service City Roul'") +
  theme(plot.title=element_text(margin=margin(0,0,20,0), size=18),
        legend.text=element_text(size = 12),
        plot.margin=margin(20,20,20,20)) 
