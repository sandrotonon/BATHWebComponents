# Einführung in Polymer

- TODO: Architektur: Abbildung X

Die Library Polymer setzt auf die in Kapitel zwei gezeigten Web Components Standards auf und soll den Umgang mit ihnen vereinfachen sowie deren Funktionalitäten erweitern. Dadurch will es Polymer ermöglichen gekapselte Komponenten zu bauen, welche wiederum von Komponenten verwendet oder mit anderen Komponenten verbunden werden können um komplexe Applikationen zu entwickeln. Der Name Polymer ("Poly" - mehrere, "mer" - Teile) ist dabei eine Metapher für die Polymerisation von einzelnen Monomeren, den nativen HTML Elementen, zu einem großen Molekül, einer Web Komponente. In diesem Kapitel wird in Abschnitt 3.1 die Architektur der Library gezeigt, in Abschnitt 3.2 wird der darauf aufsetzende Elemente Katalog dargestellt.


## Architektur

Eine mit Hilfe von Polymer implementierte Komponente lässt sich in die in Abbildung X dargestellten Schichten unterteilen. Die Browser-Schicht stellt die nativen APIs der Web Technologien dar, welche von der Polyfill-Schicht, den webcomponents.js Polyfills (siehe Abschnitt 2.6), ersetzt oder erweitert werden können, falls der Browser die notwendige Technologie nicht unterstützt. Polymer kann dabei als Konformitäts-Schicht aufgefasst werden, welche auf die nativen Technologien bzw. den Polyfills aufsetzt. Diese selbst setzt sich wiederum aus folgenden drei Schichten zusammen [citeulike:13915080]. Der `polymer-micro`-Schicht, welche die grundlegenden Funktionalitäten für das Erzeugen von Custom Elements bietet, die `polymer-mini`-Schicht, welche den Umgang mit einem lokalen DOM in einer Polymer Komponente erweitert und erleichtert, und zuletzt der `polymer`-Schicht mit allgemeinen und zusätzlichen Funktionalitäten für den Umgang mit Web Components. Auf die Polymer-Schicht können die Polymer Elemente aufgesetzt werden. Diese bilden eine weitere Schicht, welche durch den Elemente Katalog [citeulike:13916374] repräsentiert wird. In dem Elemente Katalog sind diverse mit Polymer umgesetzte Komponenten sowohl für das UI als auch für Kernfunktionen zum Entwickeln von Applikationen vorhanden.

![Bild: Schichtenmodell von Polymer](images/1-architecture.jpg "Schichtenmodell von Polymer. Quelle: http://hiloki.github.io/s/150221-frontrend_conference/src/polymer.png")


## Elemente Katalog

Der von Google verwaltete Elemente Katalog verkörpert die Polymer Philosophie `There is an element for that`. Sie bilden eine Sammlung an Komponenten, welche die von Google vorgeschlagenen Implementierungen als Lösungen von einfachen bis komplexen wiederkehrenden Problemen sind. Entwickler können diese in ihrer eigenen Applikation optional einsetzen, sie sind im Einsatz mit Polymer aber nicht zwingend notwendig. Es werden dabei allerlei Anwendungsmöglichkeiten angesprochen, von DOM Rendering in Form von Animationen, über Browser-API-Interaktionen durch Push-Nachrichten, bis hin zu Remote-API-Interaktionen mittels Ajax-Requests. Der Katalog besteht aus 7 Kategorien (Stand Januar 2016), welche die Komponenten nach Anwendungsfällen sortieren. Nachfolgend werden die Kategorien aufgelistet und erläutert.


**Iron Elements - Fe**

Eisen ist der Kern der Erde. Daran orientiert sich die Metapher der Iron Elements, welche den Kern von Polymer und das Zentrum der Polymer Elemente bilden. Sie sind die wichtigsten Elemente, welche in vielen Projekten benötigt werden.


**Paper Elements - Md**

Die Paper Elements sind Googles Design Philosophie Material Design (Md) gehorchende Elemente wie Listen, Menüs, Tabs. Sie ermöglichen das Erstellen einer UI. Paper ist dabei eine Metapher für ein erweitertes Papier, es kann zusammengesteckt werden, sich transformieren oder Schatten werfen.


**Google Web Components - Go**

Um die eigenen Services leichter verwendbar zu machen stellt Google die Google Web Components bereit. Sie kapseln diese Services und APIs in Komponenten, wodurch Google Maps oder auch Google Drive usw. in der eigenen Applikation eingebunden und verwendet werden können.


**Gold Elements - Au**

Die Gold Elements sind eine Sammlung an buchstäblich wertvollen, goldenen Elementen, welche im Bereich E-Commerce eingesetzt werden können. Sie sind Komponenten für das Arbeiten mit Zahlungsmethoden oder Kreditkarteninformationen und können dabei Helfen mit der Applikation Umsatz zu generieren.


**Neon Elements - Ne**

Die Neon Elements sind bunt und verspielt. Mit ihnen können beispielsweise Animationen erstellt werden.


**Platinum Elements - Pt**

Wie die Gold Elements sind auch die Platinum Elements sehr wertvoll, jedoch in einer anderen Hinsicht. Sie sind nicht kommerziell orientiert, sondern für im Hintergrund laufende Services wie Push- oder Offline-Funktionalitäten etc. gedacht. Sie sind Lösungen für sehr komplexe Probleme, welche nur schwer zu lösen sind.


**Molecules - Mo**

Die Molecules sind weitere Elemente als Wrapper für third-party Libraries.


**Carbon Elements - C (in Entwicklung)**

Die Carbon Elements befinden sich zum Stand dieser Arbeit noch in Entwicklung und sind noch nicht fertiggestellt. Sie sind metaphorisch sehr gewichtige Elemente und besitzen die Fähigkeit zur Bildung komplexer Moleküle die essenziell für lebende Strukturen sind. Im übertragenen Sinn sind sie Framework orientierte Elemente und werden sich um strukturelle Probleme auf Applikations-Ebene kümmern.


### Alternative Sammlung von Komponenten

Statt den Polymer Komponenten können auch selbst entwickelte oder aus anderen Quellen stammende Komponenten in eigenen Projekten verwendet werden. Der Elemente Katalog wird dabei nur von Google vertrieben und erlaubt keine nicht von Google entwickelten Komponenten. Als eine mögliche Alternative hierfür kann der customelements.io Katalog [citeulike:13916423] herangezogen werden. In diesem sind bereits mehrere tausend Komponenten gesammelt, welche von Google-unabhängigen Entwicklern für die unterschiedlichsten Anwendungsfälle entwickelt wurden.
