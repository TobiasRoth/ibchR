rm(list=ls(all=TRUE))

#------------------------------------------------------------------------------
# Einstellungen
#------------------------------------------------------------------------------
library(readxl)
library(tidyverse)
library(openxlsx)

# Artzähler
zaheler <- 1

# Tabelle für eingelesene Daten vorbereiten
res <- tibble()

# Tabelle mit Artcodes / Artnamen einlesen (BDM spezifisch)
artcodes <- read_excel("Daten/1550_IBCH_Artcodes.xlsx")

#------------------------------------------------------------------------------
# Daten einlesen
#------------------------------------------------------------------------------
dat <- read_excel("Daten/Laborprotokoll_06_01_2020_Beispiel.xls",  col_names=F) 
coordID <- paste(dat[1,26]) 

# Erst Spalte auslesen
sp1 <- dat[-c(1:8,65:76,87:nrow(dat)),c(1,2,5)]
sp1$...5 <- as.factor(sp1$...5)
names(sp1) <- c("name1","name2","n")
sp1$name1 <- as.character(sp1$name1)
sp1$name2 <- as.character(sp1$name2)
sp1$n <- as.character(sp1$n)
sp1[is.na(sp1$n),"n"] <- 0
tres <- sp1[sp1$n>0,]
if(nrow(tres)>0)
  for(j in 1:nrow(tres)) {
    if(tres[j,"name1"] != "" & !is.na(tres[j,"name1"])) nam <- tres[j,"name1"]
    if(tres[j,"name2"] != "" & !is.na(tres[j,"name2"])) nam <- tres[j,"name2"]
    res[zaheler,"coordID"] <- coordID
    res[zaheler,"ArtID"] <- artcodes[artcodes$ArtName_xls==paste(nam,"", sep=""),"ArtID"]
    res[zaheler,"Name"] <- nam
    res[zaheler,"Anzahl"] <- tres[j,"n"]
    zaheler <- zaheler+1
  }

# Zweite Spalte auslesen
sp1 <- dat[-c(1:8,46:67, 96:nrow(dat)),c(18,19,22)]
names(sp1) <- c("name1","name2","n")
sp1$name1 <- as.character(sp1$name1)
sp1$name2 <- as.character(sp1$name2)
sp1$n<-as.character(sp1$n)
sp1[is.na(sp1$n) ,"n"] <- 0
tres <- sp1[sp1$n>0,]
if(nrow(tres)>0)
  for(j in 1:nrow(tres)) {
    if(tres[j,"name1"] != "" & !is.na(tres[j,"name1"])) nam <- tres[j,"name1"]
    if(tres[j,"name2"] != "" & !is.na(tres[j,"name2"])) nam <- tres[j,"name2"]
    res[zaheler,"coordID"] <- coordID
    res[zaheler,"ArtID"] <- artcodes[artcodes$ArtName_xls == paste(nam,"", sep=""),"ArtID"]
    res[zaheler,"Name"] <- nam
    res[zaheler,"Anzahl"] <- tres[j,"n"]
    zaheler <- zaheler+1
  }


