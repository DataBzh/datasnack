library(ggplot2)
stmalo <- read.csv2("https://www.data.gouv.fr/s/resources/statistiques-logements/community/20150903-104236/35288-STMALO-Logements.csv", encoding = "latin1")
stmalo <- tidyr::gather(stmalo, key = type, value = volume, 3:5)
names(stmalo)[1] <- "Date"
names(stmalo)[2] <- "Total"
stmalo$type <- gsub(pattern = "R\xe9sidences principales", replacement = "Residences principales", stmalo$type)
stmalo$type <- gsub(pattern = "R\xe9sidences secondaires", replacement = "Residences secondaires", stmalo$type)
stmalo$volume <- gsub(pattern = " ", replacement = "", stmalo$volume)
stmalo$Total <- gsub(pattern = " ", replacement = "", stmalo$Total)
stmalo$volume <- as.numeric(stmalo$volume)
stmalo$Total <- as.numeric(stmalo$Total)
palette <- c("#973232", "#1E5B5B", "#6D8D2F", "#287928", "#E18C8C", "#548787", "#B8D283", "#70B470", "#B75353", "#326E6E", "#8CAA4E", "#439243", "#711515", "#0D4444", "#4D6914", "#115A11", "#490101", "#012C2C", "#2E4401", "#013A01")
ggplot(stmalo, aes(x = Date, y = volume, fill = type)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  geom_smooth(se = FALSE) + 
  scale_fill_manual(values = palette, name="Type de \nlogement") +
  xlab("Année") + 
  ylab("Volume") + 
  ggtitle("Statistiques logements à Saint-Malo") +
  labs(caption = "http://data-bzh.fr") +
  databzhTheme()
