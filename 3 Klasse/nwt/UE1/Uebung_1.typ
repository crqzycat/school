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
#let fach = "NWT3"
#let uebungsNummer = "01"
#let uebungsName = "IPv4 VLSM RIPv2 EIGRP OSPFv2"
#let versionDatum = "07. September 2026"

// ========== INHALT ==========

#let doc = template(fach, uebungsNummer, uebungsName, versionDatum, [

= VLSM-Adressplan erstellen

#task("1", "Benötigte Präfixe bestimmen", [
  Bestimme für jedes LAN das kleinste passende IPv4-Präfix.
  
  Berücksichtige dabei, dass neben den Endgeräten auch mindestens ein Default Gateway benötigt wird.
  
  Trage ein:
  - benötigte Hosts
  - benötigte Hostadressen
  - Präfix
  - Subnetzmaske
  - Anzahl verfügbarer Hostadressen

  #v(0.8em)
  
  #table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    fill: (_, row) => if row == 0 { rgb("e8eef6") } else { white },
    [*Bereich*], [*Hosts*], [*Router*],
    [Verwaltung], [50], [R2],
    [Kundenservice], [25], [R1],
    [Netzüberwachung], [10], [R3],
    [Geschäftskunden], [14], [R3],
    [Technik], [6], [R3],
  )

  #v(1em)
  
  *Deine Lösung:*
  
  #table(
    columns: (3fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center),
    fill: (_, row) => if row == 0 { rgb("e8eef6") } else { white },
    stroke: 0.5pt + muted,
    [*Bereich*], [*Hosts*], [*Präfix*], [*Subnetzmaske*], [*verf. Adressen*],
    [Verwaltung], [50], [/26], [255.255.255.192], [62],
    [Kundenservice], [25], [/27], [255.255.255.224], [30],
    [Netzüberwachung], [10], [/28], [255.255.255.240], [14],
    [Geschäftskunden], [14], [/28], [255.255.255.240], [14],
    [Technik], [6], [/29], [255.255.255.248], [6],
  )
])

== 1.2 VLSM durchführen

Teile 192.168.10.0/24 mit VLSM auf.

Sortiere die fünf LAN-Anforderungen für die Berechnung selbst vom größten zum kleinsten benötigten Subnetz.

Bestimme für jedes LAN:
- Netzadresse
- Präfix
- Subnetzmaske
- erste Hostadresse
- letzte Hostadresse
- Broadcastadresse
- geplantes Default Gateway

Erstelle daraus einen vollständigen Adressplan.

#v(1em)

*Sortierung (von größtem zu kleinstem Subnetz):*

#table(
  columns: (2fr, 1fr, 1fr),
  align: (left, center, center),
  fill: (_, row) => if row == 0 { rgb("e8eef6") } else { white },
  stroke: 0.5pt + muted,
  [*Bereich*], [*Netzadresse*], [*Präfix*],
  [Verwaltung], [192.168.10.0], [/26],
  [Kundenservice], [192.168.10.64], [/27],
  [Geschäftskunden], [192.168.10.96], [/28],
  [Netzüberwachung], [192.168.10.112], [/28],
  [Technik], [192.168.10.128], [/29],
)

#v(1em)

*Vollständiger Adressplan:*

#table(
  columns: (2fr, 2fr, 1.5fr, 2fr, 2fr, 2fr, 2fr),
  align: (left, center, center, center, center, center, center),
  fill: (_, row) => if row == 0 { rgb("e8eef6") } else { white },
  stroke: 0.5pt + muted,
  [*Bereich*], [*Netzadresse*], [*Präfix*], [*1. Host*], [*Letzter Host*], [*Broadcast*], [*Gateway*],
  [Verwaltung], [192.168.10.0], [/26], [192.168.10.1], [192.168.10.62], [192.168.10.63], [192.168.10.1],
  [Kundenservice], [192.168.10.64], [/27], [192.168.10.65], [192.168.10.94], [192.168.10.95], [192.168.10.65],
  [Geschäftskunden], [192.168.10.96], [/28], [192.168.10.97], [192.168.10.110], [192.168.10.111], [192.168.10.97],
  [Netzüberwachung], [192.168.10.112], [/28], [192.168.10.113], [192.168.10.126], [192.168.10.127], [192.168.10.113],
  [Technik], [192.168.10.128], [/29], [192.168.10.129], [192.168.10.134], [192.168.10.135], [192.168.10.129],
)

== 1.3 WAN-Netze planen

Plane drei /30-Netze für die Verbindungen:
- R1 ↔ R2
- R2 ↔ R3
- R1 ↔ R3

Bestimme für jedes WAN-Netz:
- Netzadresse
- beide nutzbaren Hostadressen
- Broadcastadresse
- Zuordnung der Adressen zu den Router-Interfaces

#v(1em)

#table(
  columns: (2fr, 2fr, 2fr, 2fr, 2fr),
  align: (left, center, center, center, center),
  fill: (_, row) => if row == 0 { rgb("e8eef6") } else { white },
  stroke: 0.5pt + muted,
  [*Verbindung*], [*Netzadresse*], [*Hostadresse 1*], [*Hostadresse 2*], [*Broadcast*],
  [R1 ↔ R2], [192.168.10.136], [192.168.10.137 (R1)], [192.168.10.138 (R2)], [192.168.10.139],
  [R2 ↔ R3], [192.168.10.140], [192.168.10.141 (R2)], [192.168.10.142 (R3)], [192.168.10.143],
  [R1 ↔ R3], [192.168.10.144], [192.168.10.145 (R1)], [192.168.10.146 (R3)], [192.168.10.147],
)

])

#doc