#let mainPage = "https://www.htlrennweg.at/"

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

#let template(filename, doc) = {
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

  let parts = filename.split("_")
  let schoolyear = parts.at(0)
  let fach = parts.at(1)
  let uebungsNummer = parts.at(2)
  let uebungsName = parts.slice(3).join(" ")

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
            Schuljahr #schoolyear an der #link(mainPage)[HTL Wien 3 Rennweg]
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
          Version vom 07. September 2026
        ],
        [
          #context [#here().page()]/#context[
            #counter(page).final().at(0)
          ]
        ],
      )
    ],
  )

  doc
}

#let doc = template("2026_27_NWT3_01_IPv4_VLSM_RIPv2_EIGRP_OSPFv2", [

= VLSM-Adressplan erstellen

#task("1", "Benötigte Präfixe bestimmen", [
  Bestimme für jedes LAN das kleinste passende IPv4-Präfix.
  
  Berücksichtige dabei, dass neben den Endgeräten auch mindestens ein Default Gateway benötigt wird.
  
  Trage für jeden Bereich folgende Informationen ein:
  - benötigte Hosts (aus Anforderungen)
  - benötigte Hostadressen (Hosts + 1 für Gateway)
  - Präfix (in CIDR-Notation)
  - Subnetzmaske
  - Anzahl verfügbarer Hostadressen nach Subnetzmaskierung

  #v(0.8em)
  
  *Übersicht der Anforderungen:*

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
    [Verwaltung], [], [], [], [],
    [Kundenservice], [], [], [], [],
    [Netzüberwachung], [], [], [], [],
    [Geschäftskunden], [], [], [], [],
    [Technik], [], [], [], [],
  )
])

])

#doc