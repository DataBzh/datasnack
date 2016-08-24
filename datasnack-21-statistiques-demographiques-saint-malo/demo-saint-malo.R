stmalo <- read.csv2("https://www.data.gouv.fr/s/resources/statistiques-demographiques-a-saint-malo/community/20150106-095528/35288-STMALO-Naissances-deces.csv", encoding="latin1")
names(stmalo) <- c("Date", "Naissance INSEE", "Naissances EtatCivil", "Décès INSEE", "Décès ÉtatCivil")
stmalo <- stmalo[, c(1,3,5)]
stmalo <- tidyr::gather(stmalo, key = "Type", value = "Volume", 2:3)
stmalo[23:44,2] <- "Décés Etat Civil"
names(stmalo)[1] <- "Date"

palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")

ggplot(stmalo, aes(x=Date, y = Volume, fill = Type)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  scale_fill_manual(values = palette, name=" ") +
  xlab("Année") + 
  ylab("Volume") + 
  ggtitle("Statistiques démographiques à Saint-Malo") +
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
