## Vergleich mit Komponenten-Entwicklung in AngularJS

- Die mit Polymer implementierte Multi-Navigation-Applikation wird möglichst ähnlich mit Angular nachgebaut (https://github.com/glur4k/angular-multi-navigation-app)
- Diese beiden unterschiedlichen Implementierungen, sowie generelle Unterschiede beider Frameworks bzw. Bibliotheken werden in diesem Abschnitt miteinander verglichen


### AngularJS Einstieg

- Häufig mit Polymer in Zusammenhang gebracht wird AngularJS
- AngularJS ist ein, ebenfalls von Google entwickeltes, clientseitiges open-source JavaScript-Framework zur Erstellung von dynamischen SPAs
- Ebenso wie Polymer erlaubt es Angular eigene HTML-Elemente, unter AngularJS `Directives` genannt, zu erstellen, welche die native Sammlung an HTML Elementen erweitern können
- Ist ein `Fat-Client`-Framework, welches die gesamte Logik, sowie die Präsentations-Schicht auf dem Client hält und an ein serverseitiges Model, welches die Daten hält, angebunden werden kann
- AngularJS verfolgt den MVVM-Ansatz, wie in Abbildung X dargestellt [citeulike:13920434]
- Eine Erweiterung des MVC-Ansatzes, wobei die Controller-Schicht durch eine ViewModel-Schicht ersetzt wird
- Die ViewModel-Schicht kann als eine Art Proxy aufgefasst werden, welche der View-Schicht nur die Daten des Models liefert, die sie tatsächlich benötigt und transformiert sie, damit sie von der View-Schicht ausgegeben werden können
- Ebenso stellt sie die von der View-Schicht benötigten Funktionalitäten zum ändern der Daten bereit

![Bild: Model-View-ViewModel Darstellung](images/1-model-view-viewmodel.png "Model-View-ViewModel Darstellung")

- Two-Way Data-Binding: Datenbindung in zwei Richtungen, Änderungen am Model werden automatisch im DOM abgebildet, Benutzerinteraktionen innerhalb des Views werden auf das Model angewendet. Dadurch fällt die Manipulation des DOMs mithilfe von JavaScript bzw. jQuery weg. Diese wird von Angular intern mittels der jQuery-lite, einer vereinfachten, leichteren Version von jQuery bewerkstelligt
- Controllers: definieren die Daten und Logik (ViewModel), die für einen bestimmten View benötigt werden Tun dies indem sie einen Scope halten, in dem die Variablen und Funktionen definiert werden, auf die aus dem View heraus zugegriffen wird
- Direktiven: HTML um eigene Elemente und Attribute erweitern, dessen Logik in den Direktiven gekapselt wird


### Vergleich der Intentionen hinter Polymer und AngularJS

- Polymer ist eine Library um Web Komponenten zu erstellen, welche eine Sammlung an sich noch in der Entwicklung befindenden Technologien und APIs sind um eigene HTML Elemente zu definieren
- Mit Hilfe von Polyfills und zusätzlichen Features kann es diese eigenen Elemente erstellen und sie auch auf Browsern zum Einsatz bringen, welche die Standards noch nicht unterstützen
- Angular hingegen stellt APIs auf Framework-Ebene bereit wie Services, Routing, Serverkommunikation etc.
- Polymer hat das nicht, sondern es gibt Iron Elemente, also mit Polymer entwickelte Komponenten, welche ähnliche Funktionalitäten bieten
- Es kümmert sich mehr darum, das Entwickeln solcher umfangreichen, mächtigen und wiederverwendbarer Komponenten zu ermöglichen
- Mit diesen wiederum können komplexe Applikationen gebaut werden, wie sie mit Angular gebaut werden
- Polymer muss als Library angesehen werden, Angular ist ein komplettes Framework
- Die durch Polymer erweiterten Web Components entsprechen Direktiven von Angular, Polymer ist eher ein Subset des Angular Funktionsumfangs, welches für das entwickeln von komplexen Applikationen entworfen ist (Polymer = Library < Angular = Framework (Funktionen))


### Vergleich der Technische Features

- Gleich: Two-Way Data Binding
- Gleich: Deklarative Templates

- Polymer bietet keine internen Mechanismen zum strukturieren einer Applikation, sondern nur mit Polymer gebaute Komponenten die hierfür eingesetzt werden können
- Polymer geschachtelt, hierarchisch (zwiebel), deklarativ, muss so (mediator-pattern) -> AngularJS erfordert keine hierarchische Gliederung der Applikation, da es nicht nur ein Typ von Komponenten gibt
- AngularJS ist ein Framework zum erstellen von SPAs, stellt hierfür Services, filter, Animationen, Depency Injection etc. bereit
- Angular ist besser für die Produktion geeignet, da ältere Browser unterstützt werden (IE8)
- Die Definition von Elementen ist in Polymer deklarativ orientiert, in AngularJS werden diese imperativ in JS definiert
- Polymer nutzt den Shadow DOM um Styles zu kapseln, AngularJS nicht -> kümmert sich nur die Kapselung der Daten in dem Scope (für )
- Mit Polymer entwickelte Komponenten können einfach mit anderen Custom Elements interagieren, da sie normaler DOM sind, AngularJS mit anderen SPA-Frameworks zu kombinieren ist nur sehr schwierig umsetzbar
- Deployment von AngularJS Direktiven ist nicht so einfach wie in Polymer, da die Templates immer relativ zum Projekt oder Domain-Root liegen müssen (Zusätzlicher Build schritt nötig, der das template in den Template-Cache schreiben muss, oder Template in die Direktive serialisieren)

