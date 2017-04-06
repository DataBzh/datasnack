library(ggplot2)
library(magrittr)
rd <- readr::read_csv2("http://data.enseignementsup-recherche.gouv.fr/explore/dataset/fr-esr-etablissements-publics-prives-impliques-recherche-developpement/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true") %>%
  dplyr::filter(Région == "Bretagne")
rd <- tidyr::separate(rd, Géolocalisation, into = c("Y", "X"), sep = ",")
summary(rd)
table(rd$Département)
rd$X <- as.numeric(rd$X)
rd$Y <- as.numeric(rd$Y)
rd$`Chiffre d'affaire 2014` <- as.numeric(rd$`Chiffre d'affaire 2014`)
pander::pander(table(rd$Catégorie))
map <- ggmap::qmap('Bretagne', zoom = 8, maptype = "watercolor")
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
map + 
  geom_point(data = rd, aes(x = X, y = Y, size = `Chiffre d'affaire 2014`, color = Catégorie), stat = "identity") + 
  scale_color_manual(values = palette) + 
  ggtitle("Établissements publics et privés impliqués dans la recherche et développement") +
  xlab("") + 
  ylab("") +
  theme(axis.text=element_blank(),
        axis.title=element_blank(),
        title=element_text(size=18),
        plot.title=element_text(margin=margin(0,0,20,0), size=18),
        axis.title.x=element_text(margin=margin(20,0,0,0)),
        axis.title.y=element_text(margin=margin(0,20,0,0)),
        legend.text=element_text(size = 12),
        plot.margin=margin(20,20,20,20), 
        panel.background = element_rect(fill = "white"), 
        panel.grid.major = element_line(colour = "grey")) 
