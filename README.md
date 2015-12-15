# BATHWebComponents
GitRepository meiner Bachelor Thesis im Rahmen des Studiums "Angewandte Informatik" an der HTWG-Konstanz in Kooperation mit der Firma Seitenbau GmbH.

# Inhaltsverzeichnis

:: ~40%
- Einleitung
  - Einleitung - Clean
  - Entwicklungsumgebung - TODO
- Web Components nach W3C
  - Problemlösung - Clean
  - Web Components Technology Stack - Clean
    - Custom Elements
      - Erzeugen
      - Erweitern - type extensions
    - ShadowDOM
      - Insertion Points
      - CSS Styling
    - HTML Templates
    - HTML Imports
    - Beispiel
  - Polyfill webcomponents.js - In Progress
    - Unterstützung
    - Performance

:: ~60%
- Polymer 1.0
  - Einleitung - TODO
  - How-To - TODO
  - Architektur - TODO
  - Performance - TODO
  - Styling - In Progress
- Beispiel mit polymer
  - Entwicklung mit Yeoman - TODO
  - Implementierung - Clean
  - Deployment mit Bower - TODO
  - Vergleich mit Angular - TODO
- Vorteile für Seitenbau - TODO
- Bedeutung für Seitenbau - TODO
- Vorteile durch Nichtnutzung - TODO
- Zukunftsprognose - TODO
- Danksagung - TODO


## Konventionen

### Quellen

Quellen werden inline via einem `[<Quelle> <Jahr>]` "Tag" angegeben.
Am Ende des Dokumentes ist eine Unterüberschrift *Quellen*, in der alle benutzten Quellen angegeben werden.

### Bilder

`![Bild: <Beschreibung>](*link* "<Beschreibung>. Quelle: <Quelle>")`


## Markdown in LaTeX konvertieren

`pandoc -f markdown -t latex markdownfile.md -o latexfile.tex`
