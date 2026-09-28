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

#let fach = "ITSI"
#let uebungsNummer = "01"
#let uebungsName = "Wiederholungsuebung"
#let versionDatum = "14. September 2026"

// ========== INHALT ==========

#let doc = template(fach, uebungsNummer, uebungsName, versionDatum, [

= Grundkonfiguration von Router und Switches

Als Ausgangspunkt der Übung wurde auf allen Geräten eine Grundkonfiguration vorgenommen. Dazu gehören der Hostname, die Absicherung des privilegierten Modus und der Konsolen- bzw. VTY-Zugänge mit Passwörtern, ein Banner sowie die Verschlüsselung der Klartext-Passwörter. Außerdem wurden die benötigten Interfaces aktiviert und beschriftet. Die Grundkonfiguration stellt sicher, dass alle Geräte einheitlich eingerichtet und für die weiteren Schritte erreichbar sind.

#figure(
  image("/images/itsi/ue01/grundkonfig.png", width: 100%),
  caption: [Grundkonfiguration auf Router und Switches],
)

= VLAN-Konfiguration auf den Switches

Um das Netzwerk in getrennte Broadcast-Domänen zu unterteilen, wurden auf den Switches mehrere VLANs angelegt und benannt. Die Endgeräteports wurden als Access-Ports dem jeweiligen VLAN zugewiesen. Die Verbindungen zwischen den Switches und zum Router wurden als Trunk-Ports konfiguriert, damit der Verkehr mehrerer VLANs über eine einzelne Leitung übertragen werden kann.

#note("Hinweis", [
  Ports, die keinem VLAN zugewiesen sind, sollten aus Sicherheitsgründen deaktiviert oder in ein ungenutztes VLAN verschoben werden.
])

= Router on a Stick

Damit Geräte aus unterschiedlichen VLANs miteinander kommunizieren können, wird Inter-VLAN-Routing benötigt. Dafür kommt die Methode _Router on a Stick_ zum Einsatz. Das physische Interface des Routers wird in mehrere Subinterfaces unterteilt, wobei jedes Subinterface einem VLAN entspricht. Jedem Subinterface wird ein 802.1Q-Encapsulation-Tag und die IP-Adresse des Default-Gateways für das jeweilige VLAN zugewiesen. Der Switch-Port zum Router muss dabei als Trunk konfiguriert sein.

#figure(
  image("/images/itsi/ue01/router_on_stick.png", width: 100%),
  caption: [Router on a Stick mit Subinterfaces pro VLAN],
)

= RIP und statische Routen

Für die Verbindung zwischen mehreren Netzen wurde eine Kombination aus dynamischem und statischem Routing verwendet. Mit RIP tauschen die Router ihre bekannten Netze automatisch untereinander aus, sodass neue oder geänderte Strecken ohne manuelle Anpassung erlernt werden. Ergänzend wurden statische Routen konfiguriert, etwa für Netze, die nicht über RIP erreichbar sind, oder als Default-Route Richtung Ausgang.

#figure(
  image("/images/itsi/ue01/rip_plus_static.png", width: 100%),
  caption: [Konfiguration von RIP und statischen Routen],
)

#infobox("Zur Erinnerung", [
  Statische Routen haben eine niedrigere administrative Distanz (1) als RIP (120) und werden daher bei gleichem Ziel bevorzugt.
])

= DHCP

Damit die Endgeräte nicht manuell konfiguriert werden müssen, wurde auf dem Router ein DHCP-Server eingerichtet. Für jedes VLAN gibt es einen eigenen Adresspool mit Netzadresse, Default-Gateway und DNS-Server. Adressen, die für Router, Switches oder Server reserviert sind, wurden zuvor von der Vergabe ausgenommen. Die Endgeräte beziehen ihre Adresse nun automatisch, was sich über die DHCP-Bindings überprüfen lässt.

#figure(
  image("/images/itsi/ue01/dhcp.png", width: 100%),
  caption: [DHCP-Konfiguration und Adressvergabe],
)

= Troubleshooting

Beim Aufbau und Testen der Konfiguration ist es wichtig, Fehler systematisch einzugrenzen. Ein bewährtes Vorgehen ist, von unten nach oben zu prüfen: zuerst die physische Verbindung und die Interfaces, dann VLANs und Trunks, danach Routing und zuletzt die Dienste wie DHCP.

== Häufig verwendete Befehle

```text
show ip interface brief     // Status und IP-Adressen der Interfaces
show vlan brief             // VLANs und zugewiesene Ports
show interfaces trunk       // Trunk-Ports und erlaubte VLANs
show ip route               // Routing-Tabelle
show ip protocols           // Informationen zu RIP
show ip dhcp binding        // vergebene DHCP-Adressen
show running-config         // aktuelle Konfiguration
ping / traceroute           // Erreichbarkeit und Pfad testen
```

== Typische Fehlerquellen

- Interface ist administrativ down (`no shutdown` fehlt).
- Port im falschen VLAN oder Trunk erlaubt das VLAN nicht.
- Falsche Encapsulation oder falsche IP-Adresse auf dem Subinterface.
- Netze werden bei RIP nicht mit `network` angekündigt.
- Fehlende Default-Route oder falsches Next Hop bei statischen Routen.
- DHCP-Pool passt nicht zum Netz oder das Gateway ist falsch eingetragen.

= Hinweis zur Erstellung

#note("Verwendung von KI", [
  Dieses Protokoll wurde mit Unterstützung von Claude, einem KI-Assistenten der Firma Anthropic, erstellt. Die Konfiguration und die Screenshots stammen aus der eigenen Durchführung der Übung.
])

])

#doc