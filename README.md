# ibchR
Dieses Repository enthält R-Funktionen zur Berechnung verschiedener Kennzahlen für das [Makrozoobenthos basierend auf dem Modulstufenkonzept](https://www.modul-stufen-konzept.ch/fg/module/mzb/index) (IBCH-Werte, Ökomorphologie). Für die Richtigkeit der Skripts übernehmen wir keine Garantie. Fehler können [hier](https://github.com/TobiasRoth/ibchR/issues) gemeldet werden. 

### Berechnung IBCH

Die Berechnung des IBCH-Wertes anhand der nachgewiesenen Arten wird im R-Skript [Berechnung_IBCH.R](R/Berechnung_IBCH.R) durchgeführt. Das Skript liest die Rohdaten ein (Beispielsdaten: [rohdaten_ibch.xlsx](Daten/rohdaten_ibch.xlsx)) und macht die Berechnungen.  Vergleich dazu die Berechnung des IBCH-Wertes derselben Artenliste mit dem Laborprotokoll ([Laborprotokoll_06_01_2020_Beispiel.xls](Daten/Laborprotokoll_06_01_2020_Beispiel.xls)).

### Ökomorphologie

Die Ökomorphologie wird im R-Skript [Berechnung_Oekomorphologie.R](R/Berechnung_Oekomorphologie.R) berechnet. Das Skript liest die Rohdaten ein (Beispielsdaten: [rohdaten_oekomorphologie.csv](Daten/rohdaten_oekomorphologie.csv)) und berechnet die Ökomorphologie-Klasse. 

### Einlesen Laborprotokoll

Das R-Skript [Einlesen_Laborprotokoll.R](R/Einlesen_Laborprotokoll.R) liest die Artnachweise aus dem IBCH-Laborprotokoll ein. Die eingelesen Daten können mit R dann weiter ausgewertet werden. Im Skript werden die Index-Werte aus der Fusszeile des Laborprotokoll nicht eingelesen. Bei Bedarf kann dies aber relativ einfach im Skript ergänzt werden.



