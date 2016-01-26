# Einführung in Polymer

- TODO: Architektur: Abbildung X

- In Kapitel 2 wurden die nativen HTML Web Component Standards gezeigt
- Auf diese setzt die Bibliothek Polymer auf, die den Umgang mit ihnen vereinfachen sowie deren Funktionalitäten erweitern soll
- Dadurch will polymer es ermöglichen gekapselte Komponenten zu bauen welche wiederum von Komponenten verwendet, oder mit anderen Komponenten verbunden werden können um komplexe Applikationen zu entwickeln
- Polymer ("Poly" - mehrere, "mer" - Teile) ist dabei eine Metapher für die Polymerisation von einzelnen Monomeren, den nativen HTML Elementen, zu einem großen Molekül, einer Web Komponente
- Abschnitt 3.1 zeigt die Architektur von Polymer
- In abschnitt 3.2. wird gezeigt, wie Polymer Funktioniert in Anbetracht der Analogien zu den Nativen Web Components 
- In Abschnitt 3.3 werden zusätzliche Features von Polymer dargestellt
- In Abschnitt 3.4 werden Best practices für performante und optimal bedienbare Applikationen, die mit Polymer gebaut wurden, gezeigt


## Architektur

- Eine Applikation, welche mittels Polymer implementiert wird lässt sich in folgende Schichten, wie in Abbildung X illustriert, aufteilen
- Die Browser Schicht stellt die nativen APIs der Web Technologien dar, welche von der webcomponents.js Schicht (siehe Abschnitt 2.6 - Polyfills mit webcomponents.js) ersetzt oder erweitert werden können, falls der Browser die notwendige Technologie nicht unterstützen sollte
- Polymer kann dabei als Konformitäts-Schicht aufgefasst werden, welche auf die nativen Technologien bzw. den Polyfills aufsetzt
- Diese selbst setzt sich wiederum aus folgenden drei Schichten zusammen [citeulike:13915080]
- Der `polymer-micro` Schicht, welche die fundamentalen Funktionalitäten für das Erzeugen von Custom Elements bietet, die `polymer-mini` Schicht, welche den Umgang mit einem lokalen DOM in einer Polymer Komponente erweitert und erleichtert, und zuletzt der `polymer` Schicht, der Standard Schicht die zusätzliche, allgemeine Funktionalitäten für den Umgang mit Web Components bietet
- Die Polymer Elemente bilden eine weitere Schicht, welche auf die Polymer Schicht aufgesetzt werden kann und mittels dem Elemente Katalog, welcher im folgenden Abschnitt erläutert wird, repräsentiert wird
- Diese sind diverse Komponenten sowohl für das UI, als auch für Kernfunktionen, welche mit Polymer umgesetzt wurden und für die Applikation verwendet werden können

![Bild: Schichtenmodell von Polymer](images/1-architecture.jpg "Schichtenmodell von Polymer. Quelle: http://hiloki.github.io/s/150221-frontrend_conference/src/polymer.png")



### Elemente Katalog

- `There is an element for that`

- Die oberste Schicht von Polymer bilden die Polymer Elemente
- Sie bilden eine Sammlung von Komponenten, welche die von Google vorgeschlagenen Lösungen für wiederkehrende Probleme implementieren
- Alle Elemente werden von Google in dem Elemente Katalog [citeulike:13916374] gesammelt und können von Entwicklern optional benutzt und angepasst werden, sind für den Bau einer Applikation mit Hilfe von Polymer aber nicht zwingend notwendig
- Der Elemente Katalog versucht das Google Polymer Manifest `There is an element for that` zu verwirklichen
- Er wurde seit Beginn des Projekts stark ausgebaut und nach wie vor stets erweitert und aktualisiert
- Der Katalog besteht aus 7 Kategorien (Stand Januar 2016), welche die Komponenten nach Anwendungsfällen kategorisieren
- Nachfolgend werden die Kategorien aufgelistet und erläutert


**Iron Elements - Fe**

- Iron Elemente bilden den Kern von Polymer und das Zentrum der Polymer Elemente
- Sie sind die wichtigsten Elemente, welche man in vielen Projekten brauchen kann
- Richten sich nach der Metapher von Elementen
- Metaphorisch für den Erdkern, der das Zentrum der Erde ist


**Paper Elements - Md**

- Elemente die Googles Design Philosophie Material Design gehorchen, wie Listen, Menüs, Tabs
- Paper ist eine Metapher für erweitertes Papier, es kann zusammengesteckt werden, sich transformieren, Schatten werden etc.


**Google Web Components - Go**

- Google kapselt Komponenten für eigene Services und APIs
- Dadurch können Maps, Drive etc. eingebunden und einfach angesprochen werden


**Gold Elements - Au**

- Sammlung an Elementen, welche im Bereich E-Commerce eingesetzt werden können, wie Zahlungsmethoden, Kreditkarteninformationen etc.
- Sind golden da sich mit ihnen Geld verdienen lässt


**Neon Elements - Ne**

- Bunt und verspielt
- Elemente um andere Elemente zu animieren


**Platinum Elements - Pt**

- sehr wertvoll
- nicht UI orientiert, sondern für Services die im Hintergrund laufen wie push, offline etc.
- Bringen viele neue Lösungen für sehr komplexe Probleme


**Molecules - Mo**

- Weitere Elemente, welche Wrapper für third-party Bibliotheken bilden


**Carbon Elements - C (in Entwicklung)**

- Sind noch nicht fertiggestellt
- Metaphorisch sehr gewichtige Elemente, besitzen Fähigkeit zur Bildung komplexer Moleküle, sind somit essenziell für lebende Strukturen
- Framework orientierte Elemente, Werden sich um strukturelle Probleme auf Applikations-Ebene kümmern


### Alternative Sammlung von Komponenten

- Statt den Polymer Komponenten können auch selbst entwickelte oder aus anderen Quellen stammende Komponenten verwendet werden
- Der Elemente Katalog wird nur von Google vertrieben und erlaubt keine Komponenten, welche nicht von Google entwickelt wurden
- Als Alternative hierfür kann der Customelements Katalog [citeulike:13916423] angesehen werden
- In diesem sind bereits mehrere tausend Komponenten gesammelt, welche von google unabhängigen Entwicklern für die unterschiedlichsten Anwendungsfälle entwickelt wurden

