# Polymer

    * Polymer Grundsätzliches (Architektur - Native, Polyfills, Polymer.js, Elemente Katalog)

- Polymer in Version 1.2 verfügbar
- `There is an element for that`


## Polymer Methapher

HTML Standard-Tags sind Atome. Polymer / Web Components bauen Atome zusammen zu Molekülen, den Komponenten
Aus der Verdrahtung der kleinen Teile wird Engineering
Ermöglicht Libraries, Plattformen die wiederverwendbar sind


## Architektur

Siehe Bild mit Layers

- Setzt sich zusammen aus den Schichten `polymer-micro`, `polymer-mini` und `polymer`




Feature layering
EXPERIMENTAL: API MAY CHANGE.

Polymer is currently layered into 3 sets of features provided as 3 discrete HTML imports, such that an individual element developer can depend on a version of Polymer whose feature set matches their tastes/needs. For authors who opt out of the more opinionated local DOM or data-binding features, their element’s dependencies would not be payload- or runtime-burdened by these higher-level features, to the extent that a user didn’t depend on other elements using those features on that page. That said, all features are designed to have low runtime cost when unused by a given element.

Higher layers depend on lower layers, and elements requiring lower layers will actually be imbued with features of the highest-level version of Polymer used on the page (those elements would simply not use/take advantage of those features). This provides a good tradeoff between element authors being able to avoid direct dependencies on unused features when their element is used standalone, while also allowing end users to mix-and-match elements created with different layers on the same page.

polymer-micro.html: Polymer micro features (bare-minimum Custom Element sugaring)

polymer-mini.html: Polymer mini features (template stamped into “local DOM” and tree lifecycle)

polymer.html: Polymer standard features (all other features: declarative data binding and event handlers, property nofication, computed properties, and experimental features)

This layering is subject to change in the future and the number of layers may be reduced.

Polymer micro features
The Polymer micro layer provides bare-minimum Custom Element sugaring.



### Elemente Katalog

- Die oberste Schicht von Polymer bilden die Elemente
- Sie bilden eine Sammlung von Komponenten, welche die von Google vorgeschlagenen Lösungen für wiederkehrende Probleme implementieren
- Alle Elemente werden von Google in dem Elemente Katalog gesammelt und können von Entwicklern optional benutzt und angepasst werden, sind für den Bau einer Applikation mit Hilfe von Polymer aber nicht zwingend notwendig
- Der Katalog besteht aus 7 Kategorien (Stand Januar 2016), welche die Komponenten nach Anwendungsfällen kategorisieren
- Nachfolgend werden die Kategorien aufgelistet und erläutert


**Iron Elements - Fe**

- Iron Elemente bilden den Kern von Polymer und das Zentrum der Polymer Elemente
- Sie sind die wichtigsten Elemente, welche man in vielen Projekten brauchen kann
- Richten sich nach der Metapher von Elementen
- Metaphorisch für den Erdkern, der das Zentrum der Erde ist


**Paper Elements - Md**

- Elemente die Googles Design Philosphie Material Design gehorchen, wie Listen, Menüs, Tabs
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
- nicht UI orientiert, sondern für services die im Hintergrund laufen wie push, offline etc.
- Bringen viele neue Lösungen für sehr komplexe Probleme


**Molecules - Mo**

- Weitere Elemente, welche Wrapper für third-party Bibliotheken bilden


**Carbon Elements - C (in Entwicklung)**

- Sind noch nicht fertiggestellt
- Metaphorisch sehr gewichtige Elemente, besitzen Fähigkeit zur Bildung komplexer Moleküle, sind somit essenziell für lebende Strukturen
- Framework orientierte Elemente, Werden sich um strukturelle Probleme auf Applikations-Ebene kümmern


## Quellen

- https://component.kitchen/blog/posts/an-evaluation-of-polymer-micro-as-a-minimal-web-component-framework
- https://www.polymer-project.org/1.0/docs/devguide/experimental.html
