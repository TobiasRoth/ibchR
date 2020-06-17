rm(list=ls(all=TRUE))

#------------------------------------------------------------------------------------------------------------
# Einstellungen
#------------------------------------------------------------------------------------------------------------
# R-Packete
library(tidyverse)

#------------------------------------------------------------------------------------------------------------
# Hilfsfunktion zur Bewertung des Uferbereichs
#------------------------------------------------------------------------------------------------------------  
raumbedarfL <- function(dat) {
  dat$res <- "ungenuegend"
  for(i in 1:nrow(dat)) {
    res <- FALSE
    if(dat[i,"Wasserspiegel"]=="ausgepraegt") res <- dat[i,"Uferbreite_links"]>=15 | (dat[i,"Uferbreite_links"]>=5 & dat[i,"Uferbreite_links"] > 3.75 + 0.75*dat[i,"Breite"])
    if(dat[i,"Wasserspiegel"]=="eingeschraenkt") res <- dat[i,"Uferbreite_links"]>=15 | (dat[i,"Uferbreite_links"]>=5 & dat[i,"Uferbreite_links"] > 3 + 1.2*dat[i,"Breite"])
    if(dat[i,"Wasserspiegel"]=="keine") res <- dat[i,"Uferbreite_links"]>=15 | (dat[i,"Uferbreite_links"]>=5 & dat[i,"Uferbreite_links"] > 3.5 + 1.5*dat[i,"Breite"])
    dat[i, "res"] <- ifelse(res, "genuegend","ungenuegend")
  }
  dat$res
}  

raumbedarfR <- function(dat) {
  dat$res <- "ungenuegend"
  for(i in 1:nrow(dat)) {
    res <- FALSE
    if(dat[i,"Wasserspiegel"]=="ausgepraegt") res <- dat[i,"Uferbreite_rechts"]>=15 | (dat[i,"Uferbreite_rechts"]>=5 & dat[i,"Uferbreite_rechts"] > 3.75 + 0.75*dat[i,"Breite"])
    if(dat[i,"Wasserspiegel"]=="eingeschraenkt") res <- dat[i,"Uferbreite_rechts"]>=15 | (dat[i,"Uferbreite_rechts"]>=5 & dat[i,"Uferbreite_rechts"] > 3 + 1.2*dat[i,"Breite"])
    if(dat[i,"Wasserspiegel"]=="keine") res <- dat[i,"Uferbreite_rechts"]>=15 | (dat[i,"Uferbreite_rechts"]>=5 & dat[i,"Uferbreite_rechts"] > 3.5 + 1.5*dat[i,"Breite"])
    dat[i, "res"] <- ifelse(res, "genuegend","ungenuegend")
  }
  dat$res
}

#------------------------------------------------------------------------------------------------------------
# Daten einlesen und aufbereiten; Export MSK_Daten ohne Stationen Eindolung = ja, mit excel abspeichern, so dass Dezimalstellen mit . anstatt , abgetrennt werden!
# Sohlverb, Boschung_links/rechts etc. Klassen in DB zuerst anpassen. Anroid gibt z. B. < 10% als 1-9% aus. Die Klassen müssen in der DB sowieso angepasst werden, damit einheitlich.  
#------------------------------------------------------------------------------------------------------------
dat <- read_csv("Daten/rohdaten_oekomorphologie.csv")

### Wasserspiegelbreitenvariabiliät
if(length(unique(dat$Wasserspiegel))!=3) stop("Einige Gewässer haben eine falsche Angabe zum Wasserspiegel") 
BREITENVAR <- rep(0, nrow(dat))
BREITENVAR[dat$Wasserspiegel=="eingeschraenkt"] <- 2
BREITENVAR[dat$Wasserspiegel=="keine"] <- 3
M1 <- BREITENVAR

### Verbauung der Sohle
if(length(unique(dat$Sohlenverbauung))>6) stop("Einige Gewässer haben eine falsche Angaben zur Sohlenverbauung") 
SOHLVER <- rep(5, nrow(dat))
SOHLVER[dat$Sohlenverbauung =="keine"] <- 0  
SOHLVER[dat$Sohlenverbauung =="< 10%"] <- 1 
SOHLVER[dat$Sohlenverbauung =="10-30%"] <- 2
SOHLVER[dat$Sohlenverbauung =="30-60%"] <- 3 
SOHLVER[dat$Sohlenverbauung =="> 60%"] <- 4
if(length(unique(dat$Material))>6) stop("Einige Gewässer haben eine falsche Angaben zum Sohlenmaterial") 
SOHLMAT <- rep(0, nrow(dat))
SOHLMAT[dat$Material =="Steine"] <- 0  
SOHLMAT[dat$Material =="Holz"] <- 1
SOHLMAT[dat$Material =="Beton"] <- 1 
SOHLMAT[dat$Material =="undurchlaessig"] <- 1 
SOHLMAT[dat$Material =="andere (dicht)"] <- 1 
M2 <- ifelse(SOHLVER <= 2,  SOHLVER, 2+SOHLMAT) 

### Bebauung des Böschungsfusses
if(length(unique(dat$Boschung_links))>6) stop("Einige Gewässer haben eine falsche Angaben zur linken Böschung") 
LBUKVER <- rep(2.5, nrow(dat))
LBUKVER[dat$Boschung_links =="keine"] <- 0  
LBUKVER[dat$Boschung_links =="< 10%"] <- 0 
LBUKVER[dat$Boschung_links =="10-30%"] <- 0.5 
LBUKVER[dat$Boschung_links =="30-60%"] <- 1.5 
LBUKVER[dat$Boschung_links =="> 60%"] <- 2.5 
if(length(unique(dat$Durchlaessigkeit_links))!=3) stop("Einige Gewässer haben eine falsche Angaben zur linken Durchlässigkeit") 
LBUKMAT <- rep(0, nrow(dat))
LBUKMAT[dat$Durchlaessigkeit_links =="durchlaessig"] <- 0  
LBUKMAT[dat$Durchlaessigkeit_links =="undurchlaessig"] <- 0.5  
M3L <- ifelse(LBUKVER == 0,  LBUKVER, LBUKVER+ LBUKMAT)
if(length(unique(dat$Boschung_rechts))>6) stop("Einige Gewässer haben eine falsche Angaben zur rechten Böschung") 
LBUKVER <- rep(2.5, nrow(dat))
LBUKVER[dat$Boschung_rechts =="keine"] <- 0  
LBUKVER[dat$Boschung_rechts =="< 10%"] <- 0 
LBUKVER[dat$Boschung_rechts =="10-30%"] <- 0.5 
LBUKVER[dat$Boschung_rechts =="30-60%"] <- 1.5 
LBUKVER[dat$Boschung_rechts =="> 60%"] <- 2.5 
if(length(unique(dat$Durchlaessigkeit_rechts))!=3) stop("Einige Gewässer haben eine falsche Angaben zur rechten Durchlässigkeit") 
LBUKMAT <- rep(0, nrow(dat))
LBUKMAT[dat$Durchlaessigkeit_rechts =="durchlaessig"] <- 0  
LBUKMAT[dat$Durchlaessigkeit_rechts =="undurchlaessig"] <- 0.5  
M3R <- ifelse(LBUKVER == 0,  LBUKVER, LBUKVER+ LBUKMAT)

### Uferbereich
if(sum(is.na(dat$Uferbreite_links))>0) stop("Einige Gewässer haben keine Angabe zur linken Uferbreite ('Uferbreite_links')")
if(sum(is.na(dat$Uferbreite_rechts))>0) stop("Einige Gewässer haben keine Angabe zur rechten Uferbreite ('Uferbreite_rechts')")
if(sum(is.na(dat$Breite))>0) stop("Einige Gewässer haben keine Angabe zur Breite der Gewässersohle ('Breite')")
dat[dat$Uferbreite_links == 0,"Beschaffenheit_links"] <- "kunstlich"
dat[dat$Uferbreite_rechts == 0,"Beschaffenheit_rechts"] <- "kunstlich"
if(length(unique(dat$Beschaffenheit_links))>3) stop("Einige Gewässer haben eine falsche Angaben zur linken Uferbeschaffenheit") 
if(length(unique(dat$Beschaffenheit_rechts))>3) stop("Einige Gewässer haben eine falsche Angaben zur rechten Uferbeschaffenheit") 

RAUMBED <- raumbedarfL(dat[,c("Breite", "Uferbreite_links", "Wasserspiegel")])
M4L <- rep(NA, nrow(dat))
for(i in 1: length(M4L)) {
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_links"] == "gewaessergerecht") M4L[i] <- 0
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_links"] == "gewaesserfremd") M4L[i] <- 1.5
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_links"] == "kunstlich") M4L[i] <- 3.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_links"] == "gewaessergerecht") M4L[i] <- 2.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_links"] == "gewaesserfremd") M4L[i] <- 3.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_links"] == "kunstlich") M4L[i] <- 3.0
}
RAUMBED <- raumbedarfR(dat[,c("Breite", "Uferbreite_rechts", "Wasserspiegel")])
M4R <- rep(NA, nrow(dat))
for(i in 1: length(M4R)) {
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_rechts"] == "gewaessergerecht") M4R[i] <- 0
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_rechts"] == "gewaesserfremd") M4R[i] <- 1.5
  if(RAUMBED[i] =="genuegend" & dat[i,"Beschaffenheit_rechts"] == "kunstlich") M4R[i] <- 3.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_rechts"] == "gewaessergerecht") M4R[i] <- 2.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_rechts"] == "gewaesserfremd") M4R[i] <- 3.0
  if(RAUMBED[i] =="ungenuegend" & dat[i,"Beschaffenheit_rechts"] == "kunstlich") M4R[i] <- 3.0
}

#------------------------------------------------------------------------------------------------------------
# Berchnung MSK
#------------------------------------------------------------------------------------------------------------
MSL <- M1 + M2 + M3L + M4L
MSR <- M1 + M2 + M3R + M4R
MS <- (MSL+MSR)/2
MS

