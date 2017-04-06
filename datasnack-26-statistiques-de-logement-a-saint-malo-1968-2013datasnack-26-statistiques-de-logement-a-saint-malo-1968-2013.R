stmalo <- readr::read_csv2("http://data.stmalo-agglomeration.fr/explore/dataset/statistiques-logements/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true")
stmalo <- tidyr::gather(stmalo, key = type, value = volume, 3:5)
names(stmalo)[1] <- "Date"
names(stmalo)[2] <- "Total"
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
ggplot(stmalo, aes(x = Date, y = volume, fill = type)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_smooth(se = FALSE) + 
  scale_fill_manual(values = palette, name="Type de \nlogement") +
  xlab("AnnÃ©e") + 
  ylab("Volume") + 
  ggtitle("Statistiques logements Ã  Saint-Malo") +
  theme(axis.text=element_text(size=10),
        axis.title=element_text(size=15),
        title=element_text(size=18),
        plot.title=element_text(margin=margin(0,0,20,0), size=18),
        axis.title.x=element_text(margin=margin(20,0,0,0)),
        axis.title.y=element_text(margin=margin(0,20,0,0)),
        legend.text=element_text(size = 12),
        plot.margin=margin(20,20,20,20), 
        panel.background = element_rect(fill = "white"), 
        panel.grid.major = element_line(colour = "grey"))
