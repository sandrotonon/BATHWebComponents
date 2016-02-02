# BATHWebComponents
GitRepository meiner Bachelor Thesis "Web-Component-basierte Entwicklung mit Polymer" im Rahmen des Studiums "Angewandte Informatik" an der HTWG-Konstanz in Kooperation mit der Firma Seitenbau GmbH.


# Inhaltsverzeichnis

- Kapitel 1 - [Einleitung](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-1-einleitung/1-einleitung.md) : **Clean**
- Kapitel 2 - Web Components nach dem vorläufigen W3C Standard
  + 2.1 [Problemlösung](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/1-problemloesung.md) : **Clean**
  + 2.2 [Custom Elements](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/2-custom-elements.md) : **Clean**
  + 2.3 [Shadow DOM](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/3-shadow-dom.md) : **Clean**
  + 2.4 [HTML Templates](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/4-html-templates.md) : **Clean**
  + 2.5 [HTML Imports](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/5-html-imports.md) : **Clean**
  + 2.6 [Polyfills mit webcomponents.js](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/6-polyfills.md) : **Clean**
  + 2.7 [Implementierung einer Komponente mit den nativen Web Component APIs](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-2-w3c-web-components/7-beispiel.md) : **Clean**
- Kapitel 3 - Einführung in Polymer
  + 3.1 - [Architektur](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-3-polymer/1-polymer.md) : **Clean**
  + 3.2 - [Elemente Katalog](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-3-polymer/1-polymer.md) : **Clean**
- Kapitel 4 - Analogie zu nativen Web Components
  + 4.1 [Custom Elements](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-4-analogie/1-analogie.md) : **Clean**
  + 4.2 [Shadow DOM / Templates](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-4-analogie/1-analogie.md) : **Clean**
  + 4.3 [HTML Imports](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-4-analogie/1-analogie.md) : **Clean**
- Kapitel 5 - Zusätzliche Polymer Funktionalitäten
  + 5.1 [One-Way und Two-Way Data-Binding](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-5-additional-sugar/1-additional-sugar.md) : **Clean**
  + 5.2 [Behaviors](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-5-additional-sugar/1-additional-sugar.md) : **Clean**
  + 5.3 [Events](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-5-additional-sugar/1-additional-sugar.md) : **Clean**
- Kapitel 6 - Polymer Best Practices
  + 6.1 [UI Performance Patterns](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-6-best-practices/1-best-practices.md) : **Clean**
  + 6.2 [Gesture System](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-6-best-practices/1-best-practices.md) : **Clean**
  + 6.3 [A11y - Barrierefreiheit in Polymer](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-6-best-practices/1-best-practices.md) : **Clean**
- Kapitel 7 - Komponenten Entwicklung
  + 7.1 [Entwicklung und Deployment einer Polymer Komponente](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-7-komponenten-entwicklung/1-polymer-komponente.md) : **Clean**
  + 7.2 [Vergleich mit Komponenten-Entwicklung in AngularJS](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-7-komponenten-entwicklung/2-angular-vergleich.md) : **Contents**
- Kapitel 8 - [Zukunftsprognose](https://github.com/glur4k/BATHWebComponents/blob/master/docs/release/kapitel-8-zukunftsprognose/1-zukunftsprognose.md) : **Clean**
- Anhang : **In Progress**


```
TODO:        Der Inhalt muss noch erstellt werden
Contents:    Der Inhalt ist vorhanden, muss aber noch reingeschrieben werden
Clean:       Der Inhalt ist reingeschrieben
In Progress: Der Inhalt wird erstellt
```


## Sonstige TODOs

- Bilder im Text referenzieren
- HTML Templates vor Shadow DOM


## Konventionen

### Schreibweisen

- Englische Namen ohne Bindestrich - Shadow DOM, Custom Element
- Zusammengesetzte Wörter (Englisch/Code/Abkürzung/Deutsch) mit Bindestrich - CSS-Regeln, `<div>`-Tag
- Nur **Code**-Bestandteile mit \`\` markieren - `` `<div>` ``


### Bilder

Die Bilder müssen immer im Text referenziert werden. Die Angabe der Quelle des Bildes ist ebenfalls im Text zu machen.

`![Bild: <Beschreibung>](*link* "<Beschreibung>")`


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
