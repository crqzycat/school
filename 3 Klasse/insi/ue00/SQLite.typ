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

#let template(fach, uebungsNummer, uebungsName, versionDatum, doc) = {
  set text(lang: "de")
  set par(justify: true, spacing: 0.8em)
  set list(indent: 1.4em, body-indent: 0.6em, spacing: 0.55em)
  set enum(indent: 1.4em, body-indent: 0.6em, spacing: 0.55em)

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
          #text(weight: "bold", size: 1.2em)[#fach: #uebungsName]
          #v(4pt)
          #text[Übungsblatt #uebungsNummer]
          #v(2pt)
          #text(size: 0.85em)[#klasse · Schuljahr #schuljahr an der #link(mainPage)[HTL Wien 3 Rennweg]]
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
        [Version vom #versionDatum],
        [#author · #context [#here().page()]/#context[#counter(page).final().at(0)]]
      )
    ],
  )
  doc
}

#let fach = "INSI"
#let uebungsNummer = "00"
#let uebungsName = "SQLite"
#let versionDatum = "11. September 2026"

#let doc = template(fach, uebungsNummer, uebungsName, versionDatum, [

= Aufgabe 1 :: SQLite

== a. Warum wird SQLite als „serverless" bezeichnet?

Es wird kein Datenbankserver gebraucht, da die Datenbank einfach eine Datei ist, die von der Anwendung genutzt wird.

== b. Unter welchen Lizenzbedingungen kann SQLite verwendet werden?

SQLite steht unter *Public Domain* – komplett frei nutzbar, keine Bedingungen.

#table(
  columns: 2,
  stroke: 1pt + rgb("cccccc"),
  fill: (_, row) => if row == 0 { rgb("f0f0f0") } else { white },
  [*Lizenz*], [*Bedingungen*],
  [CC0], [Wie SQLite – Public Domain, völlig frei],
  [CC BY], [Namensnennung erforderlich],
  [CC BY-SA], [Namensnennung + Weitergabe unter gleicher Lizenz],
  [CC BY-NC], [Namensnennung + nur nicht-kommerziell],
  [CC BY-ND], [Namensnennung + keine Bearbeitungen],
)

== c. In welcher Sprache wurde SQLite programmiert?

Die Programmiersprache C.

#pagebreak()

= Aufgabe 2b :: Datenbank Chinook

== Datenbank-Struktur

Die Chinook-Datenbank enthält folgende Tabellen:

- `albums` – Alben
- `artists` – Künstler
- `customers` – Kunden
- `employees` – Mitarbeiter
- `genres` – Musik-Genres
- `invoice_items` – Rechnungspositionen
- `invoices` – Rechnungen
- `media_types` – Medientypen
- `playlist_track` – Playlist-Tracks
- `playlists` – Playlists
- `tracks` – Musikstücke

== Tabellenschema: artists

```sql
CREATE TABLE "artists" (
    [ArtistId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [Name] NVARCHAR(120)
);
```

*Struktur:*
- `ArtistId`: Eindeutige ID (Primärschlüssel)
- `Name`: Künstlername

== Tabellenschema: tracks

```sql
CREATE TABLE "tracks" (
    [TrackId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [AlbumId] INTEGER,
    [MediaTypeId] INTEGER NOT NULL,
    [GenreId] INTEGER,
    [Composer] NVARCHAR(220),
    [Milliseconds] INTEGER NOT NULL,
    [Bytes] INTEGER,
    [UnitPrice] NUMERIC(10,2) NOT NULL
);
```

*Struktur:*
- `TrackId`: Eindeutige Track-ID (Primärschlüssel)
- `Name`: Trackname (erforderlich)
- `AlbumId`: Referenz zum Album
- `MediaTypeId`: Medientyp (erforderlich)
- `GenreId`: Musik-Genre
- `Composer`: Komponist
- `Milliseconds`: Dauer des Tracks
- `Bytes`: Dateigröße
- `UnitPrice`: Preis pro Stück (erforderlich)

#pagebreak()

== Genres in der Datenbank

#table(
  columns: 2,
  stroke: 1pt + rgb("cccccc"),
  fill: (_, row) => if row == 0 { rgb("f0f0f0") } else { white },
  [*GenreId*], [*Name*],
  [1], [Rock],
  [2], [Jazz],
  [3], [Metal],
  [4], [Alternative & Punk],
  [5], [Rock And Roll],
  [6], [Blues],
  [7], [Latin],
  [8], [Reggae],
  [9], [Pop],
  [10], [Soundtrack],
  [11], [Bossa Nova],
  [12], [Easy Listening],
  [13], [Heavy Metal],
  [14], [R&B/Soul],
  [15], [Electronica/Dance],
  [16], [World],
  [17], [Hip Hop/Rap],
  [18], [Science Fiction],
  [19], [TV Shows],
  [20], [Sci Fi & Fantasy],
  [21], [Drama],
  [22], [Comedy],
  [23], [Alternative],
  [24], [Classical],
  [25], [Opera],
)

#pagebreak()

== Befehle und Interpretation

#table(
  columns: 3,
  stroke: 1pt + rgb("cccccc"),
  fill: (_, row) => if row == 0 { rgb("f0f0f0") } else { white },
  align: (left, left, left),
  [*Befehl*], [*Funktion*], [*Ergebnis/Interpretation*],
  [`.tables`], [Listet alle Tabellen auf], [Zeigt 11 Tabellen: albums, artists, customers, employees, genres, invoice_items, invoices, media_types, playlist_track, playlists, tracks. Die Datenbank ist eine komplette Musik- und Shop-Verwaltung.],
  [`.schema artists`], [Zeigt Datenbankschema], [Die Tabelle hat 2 Spalten: ArtistId (Primärschlüssel, AUTO INCREMENT) und Name. Speichert Künstlerdaten mit eindeutigen IDs.],
  [`SELECT name FROM artists;`], [Wählt Namen-Spalte], [Gibt ca. 275+ Künstlernamen aus. Die Datenbank enthält einen großen Katalog verschiedenster Musik-Künstler.],
  [`SELECT * FROM genres;`], [Wählt alle Genres], [Zeigt 25 verschiedene Musik-Genres mit IDs (1-25).],
  [`.schema tracks`], [Zeigt Tracks-Schema], [Die Tabelle hat 9 Spalten mit Primärschlüssel TrackId und 3 Fremdschlüsseln.],
  [`SELECT * FROM tracks WHERE GenreID==15`], [Filtert nach Genre], [Gibt 30 Tracks des Genres Electronica/Dance aus.],
)

])

#doc