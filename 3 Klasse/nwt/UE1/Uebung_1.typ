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

= 2. Cisco-Packet-Tracer-Konfiguration

== 2.1 Router-Konfigurationen

*Schritt 1: Grundkonfiguration und Sicherheit (R1)*

```
enable
configure terminal
hostname R1
no ip domain-lookup
service password-encryption
enable secret CiscoEnable123!
username admin privilege 15 secret Admin123!
banner motd #ACHTUNG: Nur autorisierter Zugriff!#
line console 0
password Console123!
login
logging synchronous
exec-timeout 10 0
exit
ip domain-name nwt3.local
crypto key generate rsa modulus 2048
ip ssh version 2
line vty 0 4
login local
transport input ssh
exec-timeout 10 0
exit
end
write memory
```

*Schritt 2: Interface-Konfiguration (R1)*

```
configure terminal
interface GigabitEthernet0/0
ip address 192.168.10.65 255.255.255.224
no shutdown
interface Serial0/3/0
ip address 192.168.10.137 255.255.255.252
clock rate 64000
no shutdown
interface Serial0/3/1
ip address 192.168.10.145 255.255.255.252
no shutdown
end
write memory
```

*Schritt 3: RIPv2-Konfiguration (R1)*

```
configure terminal
router rip
version 2
no auto-summary
network 192.168.10.0
end
write memory
```

*Schritt 4: EIGRP-Konfiguration (R1)*

```
configure terminal
router eigrp 100
eigrp router-id 1.1.1.1
network 192.168.10.0
no auto-summary
passive-interface GigabitEthernet0/0
end
write memory
```

*Schritt 5: OSPFv2-Konfiguration (R1)*

```
configure terminal
router ospf 1
router-id 1.1.1.1
network 192.168.10.0 0.0.0.255 area 0
passive-interface GigabitEthernet0/0
no passive-interface Serial0/3/0
no passive-interface Serial0/3/1
end
write memory
```

*Schritt 1: Grundkonfiguration und Sicherheit (R2)*

```
enable
configure terminal
hostname R2
no ip domain-lookup
service password-encryption
enable secret CiscoEnable123!
username admin privilege 15 secret Admin123!
banner motd #ACHTUNG: Nur autorisierter Zugriff!#
line console 0
password Console123!
login
logging synchronous
exec-timeout 10 0
exit
ip domain-name nwt3.local
crypto key generate rsa modulus 2048
ip ssh version 2
line vty 0 4
login local
transport input ssh
exec-timeout 10 0
exit
end
write memory
```

*Schritt 2: Interface-Konfiguration (R2)*

```
configure terminal
interface GigabitEthernet0/0
ip address 192.168.10.1 255.255.255.192
no shutdown
interface Serial0/3/0
ip address 192.168.10.138 255.255.255.252
no shutdown
interface Serial0/3/1
ip address 192.168.10.141 255.255.255.252
clock rate 64000
no shutdown
end
write memory
```

*Schritt 3: RIPv2-Konfiguration (R2)*

```
configure terminal
router rip
version 2
no auto-summary
network 192.168.10.0
end
write memory
```

*Schritt 4: EIGRP-Konfiguration (R2)*

```
configure terminal
router eigrp 100
eigrp router-id 2.2.2.2
network 192.168.10.0
no auto-summary
passive-interface GigabitEthernet0/0
end
write memory
```

*Schritt 5: OSPFv2-Konfiguration (R2)*

```
configure terminal
router ospf 1
router-id 2.2.2.2
network 192.168.10.0 0.0.0.255 area 0
passive-interface GigabitEthernet0/0
no passive-interface Serial0/3/0
no passive-interface Serial0/3/1
end
write memory
```

*Schritt 1: Grundkonfiguration und Sicherheit (R3)*

```
enable
configure terminal
hostname R3
no ip domain-lookup
service password-encryption
enable secret CiscoEnable123!
username admin privilege 15 secret Admin123!
banner motd #ACHTUNG: Nur autorisierter Zugriff!#
line console 0
password Console123!
login
logging synchronous
exec-timeout 10 0
exit
ip domain-name nwt3.local
crypto key generate rsa modulus 2048
ip ssh version 2
line vty 0 4
login local
transport input ssh
exec-timeout 10 0
exit
end
write memory
```

*Schritt 2: Interface-Konfiguration (R3)*

```
configure terminal
interface GigabitEthernet0/0
ip address 192.168.10.113 255.255.255.240
no shutdown
interface GigabitEthernet0/1
ip address 192.168.10.129 255.255.255.248
no shutdown
interface GigabitEthernet0/2
ip address 192.168.10.97 255.255.255.240
no shutdown
interface Serial0/3/0
ip address 192.168.10.142 255.255.255.252
clock rate 64000
no shutdown
interface Serial0/3/1
ip address 192.168.10.146 255.255.255.252
no shutdown
end
write memory
```

*Schritt 3: RIPv2-Konfiguration (R3)*

```
configure terminal
router rip
version 2
no auto-summary
network 192.168.10.0
end
write memory
```

*Schritt 4: EIGRP-Konfiguration (R3)*

```
configure terminal
router eigrp 100
eigrp router-id 3.3.3.3
network 192.168.10.0
no auto-summary
passive-interface GigabitEthernet0/0
passive-interface GigabitEthernet0/1
passive-interface GigabitEthernet0/2
end
write memory
```

*Schritt 5: OSPFv2-Konfiguration (R3)*

```
configure terminal
router ospf 1
router-id 3.3.3.3
network 192.168.10.0 0.0.0.255 area 0
passive-interface GigabitEthernet0/0
passive-interface GigabitEthernet0/1
passive-interface GigabitEthernet0/2
no passive-interface Serial0/3/0
no passive-interface Serial0/3/1
end
write memory
```

= 3. Verifikation und Testing

== 3.1 Erfolgreich durchgeführte Tests

Alle Ping-Tests zwischen den Routern waren erfolgreich:
- R1 → R2: Successful (0.000 sec)
- R1 → R3: Successful (0.000 sec)
- R2 → R3: Successful (0.000 sec)

== 3.2 EIGRP und OSPF Nachbarschaften

Die Routing-Protokolle wurden erfolgreich aktiviert und die Nachbarschaften aufgebaut:
- EIGRP Neighbors: Alle Router erkannt
- OSPF Neighbors: Alle Router in FULL/- Status
- Routing-Tabellen aktualisiert mit R, D, und O Routen

= 4. Reflexionsfragen

== Aufgabe 19: Adressierung erklären

*Was ist die Netzadresse?*

Die Netzadresse ist die erste Adresse eines Subnetzes. Sie wird verwendet, um das gesamte Netzwerk zu bezeichnen und hat alle Host-Bits auf 0 gesetzt. Beispiel: 192.168.10.0/26 ist die Netzadresse für das Verwaltungs-LAN. Sie dient Routern zur Identifikation des Netzwerks.

*Was ist die Broadcastadresse?*

Die Broadcastadresse ist die letzte Adresse eines Subnetzes und wird verwendet, um Pakete an alle Hosts in diesem Netzwerk zu senden. Sie hat alle Host-Bits auf 1 gesetzt. Beispiel: 192.168.10.63 ist die Broadcastadresse für das Verwaltungs-Netz. Sie ist essentiell für Netzwerk-Broadcasts.

*Welche Adressen können Endgeräten zugewiesen werden?*

Endgeräten können alle Adressen zwischen der ersten Hostadresse und der letzten Hostadresse zugewiesen werden. Im Verwaltungs-LAN sind das 192.168.10.1 bis 192.168.10.62. Diese Adressen sind für die Kommunikation von Endsystemen reserviert.

*Warum kann die Netzadresse nicht einem PC zugewiesen werden?*

Die Netzadresse ist reserviert, um das gesamte Netzwerk zu identifizieren. Sie wird von Routern und anderen Netzwerkgeräten verwendet. Eine Zuweisung an einen PC würde zu Konflikten führen und die Routing-Funktionalität beeinträchtigen.

*Warum kann die Broadcastadresse nicht als Hostadresse verwendet werden?*

Die Broadcastadresse ist für die Netzwerk-Kommunikation reserviert. Sie wird verwendet, um Frames an alle Hosts in einem Netzwerk zu senden. Eine Zuweisung an einen einzelnen Host würde die Broadcast-Funktionalität zerstören.

*Welche Aufgabe hat das Default Gateway?*

Das Default Gateway ist der Router, an den ein Host Pakete sendet, die für andere Netzwerke bestimmt sind. Im Verwaltungs-LAN ist das Default Gateway 192.168.10.1 (R2 Gig0/0). Ohne Default Gateway kann ein Host nur mit Geräten in seinem eigenen Netzwerk kommunizieren.

== Aufgabe 20: VLSM begründen

*Warum ist VLSM in diesem Szenario sinnvoll?*

VLSM ist in diesem Szenario sehr sinnvoll, da die fünf LANs unterschiedliche Größen haben. Verwaltung benötigt 50 Hosts, Kundenservice 25, während Technik nur 6 braucht. Ohne VLSM würden wir jedem LAN ein /26-Netz zuweisen und über 50% der Adressen verschwenden. Mit VLSM nutzen wir:
- Verwaltung: /26 (62 verfügbar)
- Kundenservice: /27 (30 verfügbar)
- Geschäftskunden und Netzüberwachung: /28 (14 verfügbar)
- Technik: /29 (6 verfügbar)

Dies spart Adressraum und ermöglicht bessere Skalierbarkeit.

== Aufgabe 21: RIPv2 erklären

*Was macht RIPv2?*

RIPv2 ist ein Distance-Vector Routing-Protokoll, das Routing-Informationen zwischen Routern austauscht. Es verwendet Hop Count als Metrik mit einer maximalen Hop Count von 15. Jeder Router sendet seine Routing-Tabelle an benachbarte Router.

*Worin unterscheidet sich dynamisches von statischem Routing?*

Statisches Routing erfordert manuelle Konfiguration jeder Route auf jedem Router. Dynamisches Routing (wie RIPv2) lernt automatisch von benachbarten Routern und passt Routen automatisch an, wenn sich das Netzwerk ändert.

*Was bedeutet die Metrik Hop Count?*

Hop Count ist die Anzahl der Router (Hops), die ein Paket durchlaufen muss, um zum Ziel zu gelangen. Ein direktes Netzwerk hat einen Hop Count von 0, ein über einen Router erreichbares Netzwerk hat einen Hop Count von 1.

*Warum wird version 2 verwendet?*

RIPv2 hat gegenüber RIPv1 mehrere Verbesserungen: Es unterstützt VLSM, verwendet Multicast-Updates statt Broadcast und hat bessere Sicherheit. RIPv1 kann nur classful Subnetze verarbeiten.

*Warum wird no auto-summary gesetzt?*

Mit auto-summary würde RIPv2 Subnets automatisch zur nächsten classful Netzwerkgröße zusammenfassen. Da wir VLSM verwenden, müssen wir no auto-summary setzen, damit die genauen Subnetzmasken angekündigt werden.

== Aufgabe 22: EIGRP erklären

*Was ist EIGRP und wofür wird es verwendet?*

EIGRP ist ein Advanced Distance-Vector Routingprotokoll von Cisco. Es kombiniert Eigenschaften von Distance-Vector und Link-State Protokollen und wird verwendet, um automatisch optimale Routen in Netzwerken zu berechnen.

*Was ist eine EIGRP-Nachbarschaft und welche Voraussetzungen müssen dafür erfüllt sein?*

Eine EIGRP-Nachbarschaft ist eine Verbindung zwischen zwei direkt verbundenen EIGRP-Routern, über die Routing-Informationen ausgetauscht werden. Voraussetzungen sind: gleiche AS-Nummer, gleiche K-Werte, verbundene Interfaces im gleichen Subnetz und aktiviertes EIGRP auf beiden Routern.

*Aus welchen Größen setzt sich die EIGRP-Metrik standardmäßig zusammen?*

Die Metrik setzt sich aus Bandbreite und Delay zusammen. Die Formel ist: Metrik = (10^7 / Bandbreite) + (Delay / 10). Standardmäßig werden nur Bandbreite und Delay berücksichtigt (K1=1, K3=1).

*Was bedeutet die Autonomous-System-Nummer bei EIGRP?*

Die AS-Nummer ist ein Identifikator für eine Gruppe von Routern, die zusammen ein EIGRP-System bilden. Router mit unterschiedlichen AS-Nummern können keine EIGRP-Nachbarschaften aufbauen. In unserem Netzwerk verwenden alle drei Router die AS 100.

*Warum gilt EIGRP als hybrides Routingprotokoll?*

EIGRP wird als hybrid bezeichnet, weil es Eigenschaften sowohl von Distance-Vector als auch von Link-State Protokollen kombiniert. Es nutzt den DUAL-Algorithmus zur Schleifen-Vermeidung, teilt aber auch nur Distanzinformationen mit Nachbarn.

== Aufgabe 23: OSPFv2 erklären und vergleichen

*Was ist OSPFv2 und wofür wird es verwendet?*

OSPFv2 ist ein Open-Standard Link-State Routing-Protokoll. Es wird verwendet, um optimale Routen basierend auf den Kosten von Links zu berechnen und unterstützt komplexe Netzwerk-Topologien.

*Was ist ein OSPF-Nachbar?*

Ein OSPF-Nachbar ist ein benachbarter Router, mit dem dieser Router Link-State Informationen austauscht. In unserem Netzwerk sind alle drei Router OSPF-Nachbarn.

*Welche Aufgabe hat area 0?*

Area 0 ist die Backbone-Area in OSPF. Alle anderen Areas müssen direkt oder indirekt mit Area 0 verbunden sein. In unserem einfachen Netzwerk verwenden wir nur Area 0.

*Was ist eine Router-ID?*

Die Router-ID ist ein eindeutiger Identifier für einen Router in OSPFv2, dargestellt als IP-Adresse. Sie wird verwendet, um Router in OSPF-Nachbarschaften zu identifizieren.

*Was ist eine Wildcard-Maske?*

Eine Wildcard-Maske ist das Inverse einer Subnetzmaske. Sie wird in OSPF network-Befehlen verwendet: 0 bedeutet genaue Übereinstimmung, 1 bedeutet beliebig. Beispiel: 0.0.0.255 für 192.168.10.0/24.

*Warum können RIPv2, EIGRP und OSPFv2 gleichzeitig aktiv sein?*

Die drei Routingprotokolle arbeiten unabhängig voneinander. Ein Router kann Routing-Informationen von allen drei Protokollen erhalten und entscheidet anhand der administrative Distance, welche Route er verwendet.

*Was bedeutet die administrative Distance, und warum wird EIGRP standardmäßig gegenüber OSPF und RIP bevorzugt?*

Die administrative Distance ist ein Vertrauensmaß für die Routenquelle. Je niedriger, desto vertrauenswürdiger. EIGRP (intern) hat AD 90, OSPF hat AD 110, RIP hat AD 120. EIGRP wird daher bevorzugt.

*Woran erkennst du in show ip route, ob eine Route über RIP, EIGRP oder OSPF gelernt wurde?*

In show ip route werden Routen mit Buchstaben gekennzeichnet: R = RIP, D = EIGRP, O = OSPF, C = Connected, L = Local.

= 5. Fazit

Das Netzwerk wurde erfolgreich geplant, konfiguriert und getestet. Alle drei Routingprotokolle laufen parallel und die administrative Distance sorgt für die richtige Routenauswahl. EIGRP wird aufgrund seiner niedrigeren AD bevorzugt. Die VLSM-Planung ermöglichte effiziente Nutzung des Adressraums.

#v(2em)

#note("Hinweis", [
  Dieses Protokoll wurde mit Unterstützung von Claude, einem KI-Assistenten von Anthropic, erstellt. 
])

])

#doc
