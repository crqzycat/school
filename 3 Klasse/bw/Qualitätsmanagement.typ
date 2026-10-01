#let mainPage = "https://www.htlrennweg.at/"

#let author = "Nils Piskorz"
#let klasse = "3BI"
#let schuljahr = "2026/2027"

// Gemeinsame Gestaltung

#let navy = rgb("16324f")
#let blue = rgb("227c9d")
#let mint = rgb("d9f3ee")
#let yellow = rgb("fff0b8")
#let ink = rgb("1c2733")
#let muted = rgb("627182")

#show heading.where(level: 1): it => block(
  above: 1.5em,
  below: 0.65em,
  [
    #text(size: 18pt, weight: "bold", fill: navy)[#it.body]
    #line(length: 100%, stroke: 1.2pt + blue)
  ],
)

#show heading.where(level: 2): it => block(
  above: 1.1em,
  below: 0.4em,
  [
    #text(size: 13pt, weight: "bold", fill: navy)[#it.body]
  ],
)

#show raw: set text(font: "Menlo", size: 8.7pt)

#let code(source, lang: "java") = block(
  fill: rgb("f3f6f8"),
  radius: 5pt,
  inset: 10pt,
  width: 100%,
  source,
)

#let note(title, body) = block(
  fill: mint,
  radius: 6pt,
  inset: 10pt,
  width: 100%,
  [
    #text(weight: "bold", fill: navy)[#title]
    #linebreak()
    #body
  ],
)

#let infobox(title, body) = block(
  fill: rgb("eaf4fb"),
  radius: 5pt,
  inset: 7.5pt,
  width: 100%,
  [
    #text(weight: "bold", fill: navy)[#title]
    #linebreak()
    #body
  ],
)

#let hinweis(title, body) = block(
  fill: yellow,
  radius: 5pt,
  inset: 7.5pt,
  width: 100%,
  [
    #text(weight: "bold", fill: navy)[#title]
    #linebreak()
    #body
  ],
)

#let task(number, title, body) = block(
  fill: yellow,
  radius: 6pt,
  inset: 10pt,
  width: 100%,
  [
    #text(weight: "bold", fill: navy)[Aufgabe #number · #title]
    #linebreak()
    #body
  ],
)

#let template(fach, uebungsNummer, uebungsName, versionDatum, doc) = {
  set text(lang: "de")

  set par(
    justify: true,
    spacing: 0.8em,
  )

  set list(
    indent: 1.4em,
    body-indent: 0.6em,
    spacing: 0.55em,
  )

  set enum(
    indent: 1.4em,
    body-indent: 0.6em,
    spacing: 0.55em,
  )

  set page(
    width: 210mm,
    height: 297mm,
    margin: (
      top: 40mm,
      bottom: 25mm,
      left: 20mm,
      right: 20mm,
    ),
    header-ascent: 5mm,

    header: [
      #table(
        columns: (40%, 60%),
        rows: (98pt),
        stroke: none,
        align: (left, right),

        image("/images/htl3r_logo_slogan_transparent.png"),

        [
          #text(weight: "bold", size: 1.2em)[
            #fach: #uebungsName
          ]

          #v(4pt)

          #text[Übungsblatt #uebungsNummer]

          #v(2pt)

          #text(size: 0.85em)[
            #klasse · Schuljahr #schuljahr an der
            #link(mainPage)[HTL Wien 3 Rennweg]
          ]
        ]
      )

      #line(length: 100%)
    ],

    footer: [
      #line(length: 100%)

      #table(
        columns: (50%, 50%),
        rows: (auto),
        align: (left, right),
        stroke: none,

        [
          Version vom #versionDatum
        ],

        [
          #author · #context [#here().page()]/#context[
            #counter(page).final().at(0)
          ]
        ],
      )
    ],
  )

  doc
}

// ========== ANPASSUNGEN ==========

#let fach = "BW"
#let uebungsNummer = "01"
#let uebungsName = "Qualitätsmanagement"
#let versionDatum = "10. September 2026"

// ========== INHALT ==========

#let doc = template(fach, uebungsNummer, uebungsName, versionDatum, [

= Qualitätsmanagement

== Hubble-Weltraumteleskop

Die Bildqualität war nicht so gut wie erwartet aufgrund eines Fehlers des Hauptspiegels. 1993 wurde dieser durch das COSTAR-Spiegelsystem korrigiert.

== Qualität

Qualität ist die Gesamtheit von Eigenschaften und Merkmalen eines Produkts oder einer Dienstleistung, die sich auf deren Eignung zur Erfüllung festgelegter oder vorausgesetzter Erfordernisse bezieht.

== Qualitätsmerkmale

Qualitätsmerkmale sind messbare, zählbare oder beurteilbare Produkteigenschaften, welche die Qualität des Produkts beschreiben. Den Merkmalen werden entsprechende *Merkmalswerte* zugeordnet.

Auch Merkmale im Produktumfeld gehören dazu (z.B. Beratung, Kundendienst, Bedienungsanleitung).

=== Beispiel

#table(
  columns: (25%, 35%, 40%),

  [*Typ*],
  [*Qualitätsmerkmal*],
  [*Merkmalswert*],

  [messbar],
  [Durchmesser],
  [10 mm, 20 mm, 30 mm],

  [messbar],
  [Schichtdicke],
  [5 µm, 8 µm, 10 µm],

  [zählbar],
  [Schweißpunkte],
  [10, 15, 20 je Meter],

  [zählbar],
  [Schmutzpunkte],
  [10, 20, 30 Punkte je dm²],

  [beurteilbar],
  [Design],
  [attraktiv / neutral / unattraktiv],

  [beurteilbar],
  [Geschmack],
  [gut / neutral / schlecht],
)

== Anforderungsarten

=== Basisanforderungen

Produkteigenschaften, die vom Kunden selbstverständlich angesehen werden.

=== Leistungsanforderungen

Produkteigenschaften, die vom Kunden nachgefragt werden und zur Differenzierung vom Wettbewerb beitragen.

=== Begeisterungsanforderungen

Produkteigenschaften, die vom Kunden nicht erwartet werden, aber mit Begeisterung angenommen werden.

#pagebreak()

== KANO-Modell

Das KANO-Modell kategorisiert Kundenanforderungen nach ihrer Auswirkung auf die Kundenzufriedenheit.

#image("/images/kano-model.png", width: 100%)

- *Basismerkmale:* Fehlen sie, ist der Kunde sehr unzufrieden. Sind sie erfüllt, ist er nur „nicht unzufrieden".
- *Leistungsmerkmale:* Gerade – mehr Leistung bedeutet gleichmäßig mehr Zufriedenheit.
- *Begeisterungsmerkmale:* Schon eine kleine Zusatzleistung bringt viel Zufriedenheit.

== Fehler

Bei vielen Qualitätsmerkmalen ist es kaum oder gar nicht möglich, den Merkmalswert bei der Herstellung zu erreichen.

Deswegen wird meistens eine Bandbreite angegeben. Der Bereich zwischen oberem und unterem Grenzwert wird als *Toleranzbereich* bezeichnet.

Liegt der am Produkt gemessene Istwert des Qualitätsmerkmals außerhalb des Toleranzbereichs, hat dieses Produkt einen Fehler und muss ausgeschieden werden.

=== Beispiel: Welle Ø 30h7 (Größtmaß 30,000 mm, Kleinstmaß 29,979 mm → Toleranzbereich 21 µm)

#table(
  columns: (20%, 30%, 50%),

  [*Teil*],
  [*Istwert*],
  [*Bemerkung*],

  [1],
  [29,995 mm],
  [OK],

  [2],
  [29,968 mm],
  [Fehler (zu klein) → Teil ausscheiden],

  [3],
  [29,981 mm],
  [OK],

  [4],
  [30,005 mm],
  [Fehler (zu groß) → Nacharbeit],
)

#pagebreak()

=== Fehlerklassifizierung

- *Nebenfehler:* Entsprechen geringen Abweichungen, welche die Funktionalität nur unwesentlich beeinträchtigen.

- *Hauptfehler:* Sind nicht kritisch, können aber zu einem Ausfall führen.

- *Kritische Fehler:* Können zu einer Gefahr für Personen werden.

== Qualitätskosten

=== Fehlerkosten

Entstehen durch hergestellte Produkte, die den Qualitätsmerkmalen nicht entsprechen. Kosten entstehen durch Ausschuss, Nacharbeit, Garantie, Produkthaftung, Imageverlust etc.

=== Fehlerverhütungskosten

Kosten für vorbeugende Fehlervermeidung.

Dazu gehören:

- Qualitätsplanung
- Lieferantenbeurteilung
- Prüfplanung
- Mitarbeiterschulung

=== Prüfkosten

Kosten der Qualitätsprüfungen (z.B. Wareneingangsprüfung, Zwischen- und Endprüfung, Prüfmittel).

=== Qualitätskosten gesamt

*Qualitätskosten = Fehlerkosten + Prüfkosten + Fehlerverhütungskosten*

#hinweis("Größenordnung der Qualitätskosten", [
  - Fehlerkosten: 78%
  - Prüfkosten: 15%
  - Fehlerverhütungskosten: 7%
])

Man strebt ein *Minimum der Qualitätskosten* an: Hohe Qualität ist teuer – geringe Qualität ist viel teurer. Qualität rechnet sich!

=== Zehner-Regel der Fehlerkosten

Mit jeder Phase, in der ein Fehler unentdeckt bleibt, verzehnfachen sich die Kosten seiner Behebung.

#table(
  columns: (50%, 50%),

  [*Phase*],
  [*Kosten der Fehlerbehebung*],

  [Konzeption],
  [1 €],

  [Entwicklung],
  [10 €],

  [Fertigung],
  [100 €],

  [Endprüfung],
  [1.000 €],

  [beim Kunden],
  [10.000 €],
)

Rund 75% aller Fehler entstehen in Konzeption und Entwicklung, aber rund 80% werden erst in der Prüfung oder beim Kunden entdeckt. Genau diese Lücke macht Fehler so teuer.

Beispiel Hubble: Der Spiegelfehler entstand in der Fertigung, wurde aber erst im Weltall entdeckt.

=== Beispiel: Zahlt sich Fehlerverhütung aus?

#table(
  columns: (40%, 30%, 30%),

  [*Kostenart (je Jahr)*],
  [*vorher*],
  [*nachher*],

  [Fehlerkosten],
  [240.000 €],
  [90.000 €],

  [Fehlerverhütungskosten],
  [20.000 €],
  [50.000 €],

  [Prüfkosten],
  [40.000 €],
  [50.000 €],

  [*Qualitätskosten gesamt*],
  [*300.000 €*],
  [*190.000 €*],
)

Die zusätzlichen 40.000 € für Verhütung und Prüfung senken die Fehlerkosten um 150.000 €. Die Qualitätskosten sinken um rund 37%.

#note("Wichtiger Hinweis", [
  Je später Fehler entdeckt werden, desto mehr kostet es.
  Deshalb ist Qualitätsmanagement so wichtig!
])

#pagebreak()

== Bereiche des Qualitätsmanagements

- *Qualitätsplanung* (Prävention – proaktiv)
- *Qualitätsprüfung* (Überwachung – während/nach)
- *Qualitätslenkung* (Kontrolle – laufend)
- *Qualitätsverbesserung* (Optimierung – kontinuierlich)

== Qualitätsplanung

Zur Qualitätsplanung gehören:

- Die konkrete Festlegung der Qualitätsmerkmale der Produkte, basierend auf den Kundenanforderungen
- Die Festlegung von Toleranzbereichen für diese Merkmalswerte
- Die Verbesserung von Prozessen bei der Leistungserstellung
  (z.B. Werkzeugauswahl, Ablaufpläne, Maschineneinstellungen, Transportvorschriften)
- Lieferantenbeurteilung
- Mitarbeiterschulung

== Qualitätsprüfung

Die Qualitätsprüfung überwacht, ob Prozesse und Produkte den Qualitätsanforderungen entsprechen (Vollprüfung oder Stichprobenprüfung). Sie besteht aus drei Teilen:

+ *Prüfplanung*
+ *Prüfausführung* (Soll/Ist-Vergleich, Produkte außerhalb des Toleranzbereichs werden ausgeschieden)
+ *Verarbeitung der Prüfergebnisse*

Die Prüfplanung beantwortet folgende Fragen:

#table(
  columns: (20%, 80%),

  [*Frage*],
  [*Erklärung*],

  [Was?],
  [Welches Merkmal wird geprüft?],

  [Wie viel?],
  [Welche Stückzahl?],

  [Wie oft?],
  [Welche Häufigkeit?],

  [Womit?],
  [Welches Prüfmittel?],

  [Wie?],
  [Welche Prüfmethode?],

  [Wann?],
  [Welcher Prüfzeitpunkt?],

  [Durch wen?],
  [Wer prüft?],

  [Wo?],
  [Welcher Prüfort?],

  [Verarbeitung?],
  [Was passiert mit den Prüfdaten?],
)

#note("Archivierung der Prüfdaten", [
  Die gemessenen Prüfdaten werden archiviert und ermöglichen bei Bedarf
  die Rückverfolgung. Es ist nicht nur wichtig zu wissen, ob etwas
  fehlerhaft ist, sondern auch *was* fehlerhaft ist.
])

== Qualitätslenkung

*Qualitätslenkung* bedeutet die Beherrschung der qualitätsrelevanten Prozesse.

Dabei werden die Prozesse während der Produktion überwacht und gesteuert: Durch *Soll-Ist-Vergleiche* (Ergebnisse der Qualitätsprüfung) und *korrigierende Eingriffe* bei Abweichungen vom Sollwert (z.B. Maschineneinstellungen, Werkzeugwechsel, Mitarbeitergespräche).

== Qualitätsverbesserung

Kontinuierliche Optimierung und Verbesserung der Qualitätsprozesse basierend auf Prüfergebnissen und Feedback.

=== PDCA-Zyklus

Der PDCA-Zyklus (auch *Deming-Kreis*) beschreibt einen kontinuierlichen Verbesserungsprozess.

#table(
  columns: (20%, 80%),

  [*Schritt*],
  [*Funktion*],

  [Plan],
  [Verbesserung planen, Problem analysieren und Ziele festlegen],

  [Do],
  [Geplante Maßnahmen umsetzen],

  [Check],
  [Ergebnis überprüfen und feststellen, ob die Maßnahme wirksam war],

  [Act],
  [Erfolgreiche Verbesserung dauerhaft einführen bzw. bei Problemen erneut planen],
)

#hinweis("PDCA-Merksatz", [
  *Plan → Do → Check → Act*
])

#pagebreak()

== Werkzeuge des QM

=== Problemlösungsprozess

Es müssen standardisierte Problemlösungsprozesse eingeführt werden.

#table(
  columns: (38%, 62%),

  [*Schritt*],
  [*Funktion*],

  [Problem verstehen und beschreiben],
  [Problem erkennen und beschreiben. Ziel: Problem verstehen und lösen.],

  [Analyse],
  [Problem wird nach seinen Ursachen und Auslösern untersucht.],

  [Suche nach und Auswahl einer Lösung],
  [Aus den gefundenen Lösungsansätzen wird die beste ausgewählt.],

  [Realisierung & Bewertung der Lösung],
  [Lösung wird umgesetzt und auf ihre Wirksamkeit untersucht. Bei einem Fehler wird mit der neuerlichen Problembeschreibung begonnen.],

  [Einführung],
  [Die Lösung wird dauerhaft in den Prozess integriert.],
)

=== Qualitätswerkzeuge der Datenerfassung und Datenanalyse

=== Brainstorming

Dient dazu, möglichst viele Ideen und mögliche Ursachen für ein Problem zu sammeln. Es ist eine *Gruppenaktivität* in der Phase der Ideenfindung.

*4 Grundregeln:*

- Keine Kritik (in der Ideenfindung wird nicht bewertet)
- „Verrückte" Ideen sind erwünscht
- Quantität vor Qualität
- Lass dich inspirieren (Ideen der anderen aufgreifen)

*Ablauf:* Teamleiter (TL) beschreibt die Ausgangsfrage, der Protokollführer (PF) schreibt alle Ideen ohne Kommentar sichtbar auf. Zuerst *Ideenfindungsphase* (ca. 20 Minuten), danach getrennt die *Bewertungsphase* (ca. 30 Minuten, z.B. durch Punktevergabe).

*Vorteile:* einfach, geringer Aufwand, viele Ideen in kurzer Zeit.\
*Nachteile:* kaum optische Anreize, aufwendige Nachbereitung, zurückhaltende Menschen äußern ungern verrückte Ideen.

=== Flussdiagramm

Stellt einen Prozess grafisch dar und zeigt die einzelnen Schritte und deren Reihenfolge.

→ Dient dazu, Abläufe übersichtlich darzustellen und mögliche Fehlerstellen zu erkennen.

#table(
  columns: (30%, 70%),

  [*Symbol*],
  [*Bedeutung*],

  [Start / Ende],
  [Begrenzung des dargestellten Prozesses],

  [Anweisung],
  [Eine durchzuführende Einzelaufgabe],

  [Verzweigung],
  [Frage mit zwei Antworten (ja / nein)],

  [Unterprozess],
  [Komplexer Unterprozess mit eigener Verfahrensanweisung],

  [Dokument],
  [Dokument als Input für eine Tätigkeit bzw. als Output],
)

=== Baumdiagramm

Zerlegt ein Problem oder Ziel schrittweise in einzelne Teilbereiche.

→ Dient dazu, komplexe Probleme systematisch zu strukturieren.

=== Strichliste / Fehlersammelliste

Die Häufigkeit des Auftretens eines Fehlers wird strukturiert erfasst.

Der Fehler muss dafür bereits bekannt sein. Sinnvoll ist eine zusätzliche Spalte „sonstige Fehler" für bisher unbekannte Fehler.

#table(
  columns: (50%, 50%),

  [*Fehler*],
  [*Häufigkeit*],

  [a],
  [III],

  [b],
  [II],

  [c],
  [IIII],

  [d],
  [I],
)

=== Ishikawa-Diagramm

Das Ishikawa-Diagramm wird auch *Ursachen-Wirkungs-Diagramm* oder *Fischgräten-Diagramm* genannt.

Es dient dazu, mögliche Ursachen eines Problems systematisch zu untersuchen. Das Problem steht am Kopf, die Hauptursachen auf den Hauptästen, die Nebenursachen auf den Nebenästen.

Die Hauptursachen sind meist aus den *7M* herleitbar:

- Management
- Mensch
- Maschine
- Mitwelt
- Material
- Methode
- Messbarkeit

#infobox("Beispiel: Kopierer", [
  *Mensch:*
  - schmutzige Hände
  - falsche Maschinenbedienung

  *Maschine:*
  - Walzenzustand
  - Helligkeit der Lampe
  - Tisch schmutzig

  *Material:*
  - falscher Toner
  - Papierqualität
  - schlechte Flüssigkeit

  *Methode:*
  - Positionieren des Originals
  - zu wenig Toner
  - Deutlichkeit des Originals
  - Maschinenüberlastung
])

=== Verlaufsdiagramm

Zeigt erfasste Messwerte in der Reihenfolge ihrer Messung (y-Achse: Messwert, x-Achse: Zeit).

→ Dient dazu, Veränderungen und Trends zu erkennen.

=== Korrelationsdiagramm

Zeigt den Zusammenhang zwischen zwei Merkmalen bzw. Messgrößen (unabhängige Variable X = Ursache, abhängige Variable Y = Wirkung).

→ Dient dazu, festzustellen, ob zwischen zwei Größen ein Zusammenhang besteht.

Mögliche Ergebnisse: positive Korrelation (stark/schwach), negative Korrelation (stark/schwach), keine Korrelation.

=== Pareto-Diagramm

Stellt Fehler oder Ursachen nach ihrer Häufigkeit bzw. Bedeutung absteigend geordnet dar (inkl. Summenlinie in %).

→ Dient dazu, die wichtigsten Fehlerursachen zu erkennen und Prioritäten zu setzen.

#hinweis("Pareto-Prinzip (80/20-Regel)", [
  20% der Ursachen sind für 80% der Wirkung (z.B. der Fehler) verantwortlich.
])

=== Histogramm

Stellt die Häufigkeitsverteilung von Messwerten als Balkendiagramm dar. Dazu werden gleich große Klassen zwischen kleinstem und größtem Messwert gebildet. Verbindet man die Spitzen der Balken, erhält man die Gauß'sche Normalverteilungskurve.

→ Dient dazu, die Verteilung und Streuung eines Qualitätsmerkmals zu erkennen.

=== Matrixdiagramm

Stellt Beziehungen zwischen mehreren Merkmalen, Faktoren oder Gruppen übersichtlich dar.

→ Dient dazu, Zusammenhänge und Abhängigkeiten zwischen verschiedenen Faktoren zu erkennen.

*Wichtigste Kriterien ermitteln:* Jedes Kriterium wird mit jedem verglichen. Ist das Zeilenkriterium wichtiger als das Spaltenkriterium, wird „2" eingetragen, sonst „0". Danach werden die Zeilen summiert – die höchsten Summen sind die wichtigsten Kriterien.

#pagebreak()

== Übersicht der Qualitätswerkzeuge

#table(
  columns: (35%, 65%),

  [*Werkzeug*],
  [*Funktion*],

  [Brainstorming],
  [Ideen und mögliche Ursachen sammeln],

  [Flussdiagramm],
  [Prozesse und Abläufe darstellen],

  [Baumdiagramm],
  [Probleme oder Ziele in Teilbereiche zerlegen],

  [Strichliste / Fehlersammelliste],
  [Häufigkeit bekannter Fehler erfassen],

  [Ishikawa-Diagramm],
  [Mögliche Ursachen eines Problems untersuchen],

  [Verlaufsdiagramm],
  [Entwicklung eines Merkmals über die Zeit darstellen],

  [Korrelationsdiagramm],
  [Zusammenhang zwischen zwei Merkmalen untersuchen],

  [Pareto-Diagramm],
  [Häufigste bzw. wichtigste Fehler erkennen],

  [Histogramm],
  [Häufigkeitsverteilung und Streuung darstellen],

  [Matrixdiagramm],
  [Beziehungen zwischen verschiedenen Faktoren darstellen],
)

#pagebreak()

== Methoden des QM

#table(
  columns: (25%, 75%),

  [*Methode*],
  [*Kurzbeschreibung*],

  [FMEA],
  [Fehlermöglichkeits- und Einflussanalyse: vorbeugende Bewertung möglicher Fehler (in Entwicklung und Planung)],

  [SPC],
  [Statistische Prozessregelung: laufende Prozessüberwachung mit Regelkarten],

  [QFD],
  [Quality Function Deployment: Übersetzung der Kundenwünsche in technische Merkmale],

  [Taguchi],
  [Robuste Auslegung von Produkt und Prozess gegen Störgrößen],

  [KAIZEN / KVP],
  [Kontinuierlicher Verbesserungsprozess in kleinen Schritten],
)

=== FMEA

*Risikoprioritätszahl: RPZ = B · A · E*

- *B* – Bedeutung der Folge für den Kunden (10 = sehr schwerwiegend)
- *A* – Auftretenswahrscheinlichkeit (10 = tritt fast sicher auf)
- *E* – Entdeckungswahrscheinlichkeit (10 = wird fast sicher nicht entdeckt)

#table(
  columns: (34%, 30%, 8%, 8%, 8%, 12%),

  [*Möglicher Fehler*],
  [*Folge*],
  [*B*],
  [*A*],
  [*E*],
  [*RPZ*],

  [Bohrung zu klein],
  [Montagestopp],
  [6],
  [4],
  [3],
  [72],

  [Falscher Werkstoff],
  [Bauteil bricht im Betrieb],
  [10],
  [2],
  [6],
  [120],

  [Grat nicht entfernt],
  [Schnittverletzung beim Kunden],
  [8],
  [5],
  [4],
  [160],
)

Hohe RPZ-Werte werden zuerst bearbeitet, danach wird neu bewertet.

=== SPC

In festen Abständen wird eine kleine Stichprobe gemessen. Mittelwert und Streuung kommen in die *Regelkarte*.

- Liegen die Punkte zufällig um die Mittellinie, ist der Prozess beherrscht → *nicht eingreifen*.
- Bei Trend, Sprung oder Überschreiten einer Eingriffsgrenze wird die Ursache gesucht.

=== Taguchi

Störgrößen (Temperatur, Luftfeuchte, Materialschwankungen) sind nie ganz vermeidbar. Produkt und Prozess werden daher *robust* dagegen ausgelegt. Jede Abweichung vom Sollwert verursacht schon Kosten, auch innerhalb der Toleranz.

=== KAIZEN / KVP

Japanisch für „Veränderung zum Besseren": viele kleine Verbesserungen durch die Mitarbeiter (Verbesserungsvorschläge, Qualitätszirkel, PDCA).

- *5S:* Sortieren, Systematisieren, Säubern, Standardisieren, Selbstdisziplin
- *Poka Yoke:* So gestalten, dass Fehler nicht passieren oder sofort auffallen (z.B. USB-C-Stecker, Maschine startet nicht bei offener Tür)

#note("Merksatz", [
  Qualitätsmanagement bedeutet nicht nur Fehler zu finden,
  sondern Fehler möglichst früh zu verhindern und Prozesse
  kontinuierlich zu verbessern.
])

])

#doc
