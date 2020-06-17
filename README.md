# ibchR
Dieses Repository enthält R-Funktionen zur Berechnung verschiedener Kennzahlen für das Makrozoobenthos basierend auf dem Modulstufenkonzept (IBCH-Werte, Ökomorphologie). Für die Richtigkeit der Skripts übernehmen wir keine Garantie. Fehler können [hier](https://github.com/TobiasRoth/ibchR/issues) gemeldet werden. 

### Berechnung IBCH

Die Berechnung des IBCH-Wertes anhand der nachgewiesenen Arten wird im R-Skript [Berechnung_IBCH.R](R/Berechnung_IBCH.R) durchgeführt. Das Skript liest die Rohdaten ein (Beispielsdaten: [rohdaten_ibch.xlsx](Daten/rohdaten_ibch.xlsx)) und macht die Berechnungen. 

### Ökomorphologie

Die Ökomorphologie wird im R-Skript [Berechnung_Oekomorphologie.R](R/Berechnung_Oekomorphologie.R) berechnet. Das Skript liest die Rohdaten ein (Beispielsdaten: [rohdaten_oekomorphologie.csv](Daten/rohdaten_oekomorphologie.csv)) und berechnet die Ökomorphologie-Klasse. 



