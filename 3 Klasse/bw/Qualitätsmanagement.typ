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
  fill: rgb("eaf4fb"), radius: 5pt, inset: 7.5pt, width: 100%,
  [#text(weight: "bold", fill: navy)[#title]#linebreak()#body],
)

#let highlight(title, body) = block(
  fill: yellow, radius: 5pt, inset: 7.5pt, width: 100%,
  [#text(weight: "bold", fill: navy)[#title]#linebreak()#body],
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
  // Typografie
  set text(lang: "de")
  set par(
    justify: true,
    spacing: 0.8em,
  )

  // Listen: etwas mehr Luft und deutliche Einrückung
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
    margin: (top: 40mm, bottom: 25mm, left: 20mm, right: 20mm),
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
            #klasse · Schuljahr #schuljahr an der #link(mainPage)[HTL Wien 3 Rennweg]
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
// Ändere diese Werte für dein Übungsblatt:

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

Qualitätsmerkmale sind messbare, zählbare oder beurteilbare Produkteigenschaften, welche die Qualität des Produkts beschreiben.

=== Beispiel

#table(
  columns: (25%, 35%, 40%),
  [*Typ*], [*Qualitätsmerkmal*], [*Merkmalswert*],
  [messbar], [Durchmesser], [10 mm, 20 mm, 30 mm],
  [messbar], [Schichtdicke], [5 µm, 8 µm, 10 µm],
  [zählbar], [Schweißpunkte], [10, 15, 20 je Meter],
  [zählbar], [Schmutzpunkte], [10, 20, 30 Punkte je dm²],
  [beurteilbar], [Design], [attraktiv / neutral / unattraktiv],
  [beurteilbar], [Geschmack], [gut / neutral / schlecht],
)

== Anforderungsarten

=== Basisanforderungen
Produkteigenschaften, die vom Kunden selbstverständlich angesehen werden.

=== Leistungsanforderungen
Produkteigenschaften, die vom Kunden nachgefragt werden.

=== Begeisterungsanforderungen
Produkteigenschaften, die vom Kunden nicht erwartet werden, aber mit Begeisterung angenommen werden.

#pagebreak()

== KANO-Modell

Das KANO-Modell kategorisiert Kundenanforderungen nach ihrer Auswirkung auf die Kundenzufriedenheit.

#image("/images/kano-model.png", width: 100%)

== Fehler

Bei vielen Qualitätsmerkmalen ist es kaum oder gar nicht möglich, den Merkmalswert bei der Herstellung zu erreichen. Deswegen wird daher meistens eine Bandbreite angegeben. Der Bereich zwischen oberem und unterem Grenzwert wird als *Toleranzbereich* bezeichnet.

Liegt der am Produkt gemessene Istwert des Qualitätsmerkmals außerhalb des Toleranzbereichs, hat dieses Produkt einen Fehler und muss ausgeschieden werden.

=== Beispiel: Durchmesser 30 mm mit 15 µm Toleranz

#table(
  columns: (20%, 30%, 50%),
  [*Teil*], [*Istwert*], [*Bemerkung*],
  [1], [29,995 mm], [OK],
  [2], [29,968 mm], [Fehler (zu klein) → Teil ausscheiden],
  [3], [29,981 mm], [OK],
  [4], [30,005 mm], [Fehler (zu groß) → Nacharbeit],
)

=== Fehlerklassifizierung

- *Nebenfehler:* Entsprechen geringen Abweichungen, welche die Funktionalität nur unwesentlich mindern.
- *Hauptfehler:* Sind nicht kritisch, können aber zu einem Ausfall führen.
- *Kritische Fehler:* Können zu einer Gefahr für Personen werden.

== Qualitätskosten

=== Fehlerkosten

Entstehen durch hergestellte Produkte, die den Qualitätsmerkmalen nicht entsprechen. Kosten entstehen durch Ausschuss, Nacharbeit, etc.

=== Fehlerverhütungskosten

Kosten für vorbeugende Fehlervermeidung. Dazu gehören:
- Qualitätsplanung
- Lieferantenbeurteilung
- Prüfplanung
- Mitarbeiterschulung

=== Prüfkosten

Kosten der Qualitätsprüfungen.

])

#doc