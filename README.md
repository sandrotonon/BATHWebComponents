# BATHWebComponents
GitRepository meiner Bachelor Thesis im Rahmen des Studiums "Angewandte Informatik" an der HTWG-Konstanz in Kooperation mit der Firma Seitenbau GmbH.

# Inhaltsverzeichnis

[Visit GitHub](https://www.github.com)

- Kapitel 1 - [Einleitung](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-1-einleitung/1-einleitung.md) : Clean
- Kapitel 2 - Web Components nach dem vorläufigen W3C Standard
  + 2.1 [Problemlösung](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/1-problemloesung.md) : Clean
  + 2.2 [Custom Elements](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/2-custom-elements.md) : Clean
  + 2.3 [Shadow DOM](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/3-shadow-dom.md) : Clean
  + 2.4 [HTML Templates](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/4-html-templates.md) : Clean
  + 2.5 [HTML Imports](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/5-html-imports.md) : Clean
  + 2.6 [Polyfills mit webcomponents.js](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/6-polyfills.md) : Clean
  + 2.7 [Implementierung einer Komponente mit den nativen Web Component APIs](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/7-beispiel.md) : Contents
- Kapitel 3 - Einführung in Polymer
  + 3.1 - Architektur : Clean
  + 3.2 - Elemente Katalog : Clean
- Kapitel 4 - Analogie mit nativen Web Components
  + 4.1 Custom Elements : Contents
  + 4.2 Shadow DOM / Templates : TODO
  + 4.3 HTML Imports : Clean
- Kapitel 5 - Zusätzliche Polymer Funktionalitäten
  + 5.1 One-Way und Two-Way Data-Binding : Clean
  + 5.2 Behaviors : Clean
  + 5.3 Events : Clean
- Kapitel 6 - Polymer Best Practices
  + 6.1 UI Performance Patterns : Clean
  + 6.2 Gesture System : Clean
  + 6.3 A11y - Barrierefreiheit in Polymer : Clean
- Kapitel 7 - Entwicklung einer Polymer Komponente und Vergleich mit AngularJS
  + 7.1 Entwicklung der Komponente : TODO
  + 7.2 Vergleich mit AngularJS Implementierung : In Progress
- Kapitel 8 - Zukunftsprognose : Clean
- Anhang : In Progress



- TODO: Der Inhalt muss noch erstellt werden
- Contents: Der Inhalt ist vorhanden, muss aber noch reingeschrieben werden
- Clean: Der Inhalt ist reingeschrieben
- In Progress: Der Inhalt wird erstellt


## Konventionen

### Quellen

Quellen werden inline via einem `[<Quelle> <Jahr>]` "Tag" angegeben.
Am Ende des Dokumentes ist eine Unterüberschrift *Quellen*, in der alle benutzten Quellen angegeben werden.

### Bilder

`![Bild: <Beschreibung>](*link* "<Beschreibung>. Quelle: <Quelle>")`


## Markdown in LaTeX konvertieren

`pandoc -f markdown -t latex markdownfile.md -o latexfile.tex`


### Sublime Build System

Markdown.sublime-build
```
{
  "shell_cmd": "pandoc -f markdown -t latex $file_name -o $file_base_name.tex --chapter",
  "selector": "text.html.markdown"
}
```
