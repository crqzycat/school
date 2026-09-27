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

#let highlight(title, body) = block(
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
  // Typografie
  set text(lang: "de")

  set par(
    justify: true,
    spacing: 0.8em,
  )

  // Listen
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
          #author ·
          #context [#here().page()]/#context[
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

#let uebungsName = "Dijkstra"

#let versionDatum = "17. September 2026"


// ========== INHALT ==========

#let doc = template(
  fach,
  uebungsNummer,
  uebungsName,
  versionDatum,
  [

    #task(
      "1",
      "Dijkstra ab Knoten D",
      [
        Verwende die dargestellte Netzwerktopologie und führe den
        Dijkstra-Algorithmus mit dem Startknoten *D* durch.

        Für die Berechnung werden alle Kanten als ungerichtet betrachtet.
      ],
    )


    = 1. Ausgangswerte

    Der Startknoten ist *D*.

    Zu Beginn besitzt D die Distanz 0. Alle anderen Knoten haben
    zunächst die Distanz ∞.

    #table(
      columns: (1.4cm, 2cm, 2.1cm, 2.2cm),
      stroke: 0.5pt,
      inset: 5pt,

      [*Knoten*],
      [*Distanz*],
      [*Vorgänger*],
      [*Bearbeitet*],

      [A], [∞], [–], [–],
      [B], [∞], [–], [–],
      [C], [∞], [–], [–],
      [D], [0], [–], [ja],
      [E], [∞], [–], [–],
      [F], [∞], [–], [–],
      [G], [∞], [–], [–],
      [H], [∞], [–], [–],
      [I], [∞], [–], [–],
      [J], [∞], [–], [–],
      [K], [∞], [–], [–],
    )


    = 2. Schritt – Knoten D

    Von D werden die direkten Nachbarn überprüft:

    - D → C: 0 + 2 = 2 → C = 2, Vorgänger D
    - D → E: 0 + 3 = 3 → E = 3, Vorgänger D

    Damit wird als Nächstes *C* mit der kleinsten Distanz 2 bearbeitet.


    = 3. Schritt – Knoten C

    Von C aus:

    - C → B: 2 + 5 = 7 → B = 7, Vorgänger C
    - C → G: 2 + 1 = 3 → G = 3, Vorgänger C
    - C → D: 2 + 2 = 4 → keine Verbesserung

    Nun haben *E* und *G* beide die vorläufige Distanz 3.

    #highlight(
      "Gleiche Distanz",
      [
        E und G besitzen beide die Distanz 3.
        In diesem Beispiel wird E zuerst ausgewählt.
      ],
    )


    = 4. Schritt – Knoten E

    Von E aus:

    - E → A: 3 + 2 = 5 → A = 5, Vorgänger E
    - E → F: 3 + 3 = 6 → F = 6, Vorgänger E
    - E → D: 3 + 3 = 6 → keine Verbesserung

    Als Nächstes wird *G* mit Distanz 3 bearbeitet.


    = 5. Schritt – Knoten G

    Von G aus:

    - G → J: 3 + 2 = 5 → J = 5, Vorgänger G
    - G → F: 3 + 4 = 7 → keine Verbesserung, F = 6
    - G → C: 3 + 1 = 4 → keine Verbesserung, C = 2

    Jetzt besitzen *A* und *J* beide die vorläufige Distanz 5.

    Es wird A zuerst ausgewählt.


    = 6. Schritt – Knoten A

    Von A aus:

    - A → B: 5 + 3 = 8 → keine Verbesserung, B = 7
    - A → E: 5 + 2 = 7 → keine Verbesserung, E = 3

    Danach wird *J* mit Distanz 5 bearbeitet.


    = 7. Schritt – Knoten J

    Von J aus:

    - J → K: 5 + 1 = 6 → K = 6, Vorgänger J
    - J → H: 5 + 2 = 7 → H = 7, Vorgänger J
    - J → G: 5 + 2 = 7 → keine Verbesserung, G = 3

    Nun besitzen *F* und *K* beide die Distanz 6.

    Es wird F zuerst ausgewählt.


    = 8. Schritt – Knoten F

    Von F aus:

    - F → I: 6 + 2 = 8 → I = 8, Vorgänger F
    - F → G: 6 + 4 = 10 → keine Verbesserung
    - F → E: 6 + 3 = 9 → keine Verbesserung

    Danach wird *K* mit Distanz 6 bearbeitet.


    = 9. Schritt – Knoten K

    Von K aus:

    - K → H: 6 + 3 = 9 → keine Verbesserung, H = 7
    - K → J: 6 + 1 = 7 → keine Verbesserung, J = 5

    Danach wird *H* mit Distanz 7 bearbeitet.


    = 10. Schritt – Knoten H

    Von H aus:

    - H → I: 7 + 1 = 8 → I = 8, gleich gut wie bisher
    - H → K: 7 + 3 = 10 → keine Verbesserung
    - H → J: 7 + 2 = 9 → keine Verbesserung

    Nun ist noch *B* mit Distanz 7 und *I* mit Distanz 8 offen.

    Daher wird zuerst *B* bearbeitet.


    = 11. Schritt – Knoten B

    Von B aus:

    - B → A: 7 + 3 = 10 → keine Verbesserung
    - B → C: 7 + 5 = 12 → keine Verbesserung

    Danach wird *I* mit Distanz 8 bearbeitet.


    = 12. Schritt – Knoten I

    Von I aus:

    - I → H: 8 + 1 = 9 → keine Verbesserung, H = 7
    - I → F: 8 + 2 = 10 → keine Verbesserung, F = 6

    Damit sind alle Knoten endgültig bearbeitet.


    = 13. Bearbeitungsreihenfolge

    #note(
      "Reihenfolge",
      [
        *D → C → E → G → A → J → F → K → H → B → I*
      ],
    )


    = 14. Endergebnis

    #table(
      columns: (1.5cm, 1.8cm, 2cm, 7.8cm),
      stroke: 0.5pt,
      inset: 6pt,

      [*Knoten*],
      [*Distanz*],
      [*Vorgänger*],
      [*Kürzester Weg*],

      [A],
      [5],
      [E],
      [D → E → A],

      [B],
      [7],
      [C],
      [D → C → B],

      [C],
      [2],
      [D],
      [D → C],

      [D],
      [0],
      [–],
      [D],

      [E],
      [3],
      [D],
      [D → E],

      [F],
      [6],
      [E],
      [D → E → F],

      [G],
      [3],
      [C],
      [D → C → G],

      [H],
      [7],
      [J],
      [D → C → G → J → H],

      [I],
      [8],
      [F],
      [D → E → F → I],

      [J],
      [5],
      [G],
      [D → C → G → J],

      [K],
      [6],
      [J],
      [D → C → G → J → K],
    )


    = 15. Kürzeste Wege mit Kosten

    - *D → C* = 2
    - *D → E* = 3
    - *D → C → G* = 2 + 1 = 3
    - *D → E → A* = 3 + 2 = 5
    - *D → C → G → J* = 2 + 1 + 2 = 5
    - *D → E → F* = 3 + 3 = 6
    - *D → C → G → J → K* = 2 + 1 + 2 + 1 = 6
    - *D → C → G → J → H* = 2 + 1 + 2 + 2 = 7
    - *D → C → B* = 2 + 5 = 7
    - *D → E → F → I* = 3 + 3 + 2 = 8


    = 16. Zusammenfassung

    #infobox(
      "Ergebnis",
      [
        Der Dijkstra-Algorithmus bestimmt von D aus für jeden Knoten
        den kürzesten bekannten Weg.

        Die endgültigen Distanzen sind:

        *D = 0, C = 2, E = 3, G = 3, A = 5, J = 5,
        F = 6, K = 6, H = 7, B = 7, I = 8.*

        Bei gleicher vorläufiger Distanz kann einer der betreffenden
        Knoten zuerst ausgewählt werden. Die endgültigen kürzesten
        Distanzen werden dadurch nicht verändert.
      ],
    )
  ],
)

#doc