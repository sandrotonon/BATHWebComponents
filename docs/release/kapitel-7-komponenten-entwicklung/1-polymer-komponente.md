# Komponenten Entwicklung

- TODO
- auf abschnitte eingehen



## Entwicklung und Deployment einer Polymer Komponente

- Als Beispielimplementierung eines Polymer-Elements wird eine responsive SPA Navigation mit erster und zweiter Navigationsebene implementiert
- Dabei soll sich die zweite Navigationsebene an die Auswahl der ersten Navigationsebene, sowie der Inhalt der Seite an die Auswahl der zweiten Navigationsebene anpassen
- Vergleichend dazu wird das Selbe in AngularJS implementiert und mit der Polymer-Implementierung verglichen
- Unterabschnitte erläutern


### Entwicklungsumgebung

auf Computer installieren:
- node.js
- grunt
- bower
- yeoman


### Yeoman

- Yeoman [citeulike:13916358] ist ein Node CLI Modul, welches Entwicklern beim Entwickeln neuer Projekte unter die arme greift
- es besteht aus drei Werkzeugen, zum einem dem `yo`, welches beim Erstellen eines neuen Projektes hilft und dies beschleunigt, dem Werkzeug `grunt`, einem Build Prozess der automatisierte Aufgaben und watch-tasks ausführen kann und schließlich `bower`, einem Package Manager welcher Packages herunterladen und verwalten kann
- Polymer bietet für Entwickler das "Polymer Starter Kit" (https://github.com/PolymerElements/polymer-starter-kit) zum schnellen Erstellen eines Polymer Projektes
- Es beinhaltet dabei allerlei Elemente, ein Material Design Layout, Routing mit einem externen Framework und ein umfangreiches Tooling mittels Gulp
- Das ist viel mehr als benötigt und bietet keinen Yeoman Support
- Stattdessen den "Yeoman generator for Polymer projects" (https://github.com/yeoman/generator-polymer) benutzt, der einen Yeoman Generator für ein Boilerplate einer Polymer Komponente liefert
- Mittels `yo polymer:seed my-element` wird der Generator für das `my-element` gestartet und die HTML Datei mit der entsprechenden Polymer Grundstruktur generiert (siehe Anhang)


### Die multi-navigation-app Komponente

- Nachdem das Seed-Element generiert wurde, wird zunächst das überflüssige HTML-Markup des Templates, die Lifecycle-Callbacks `attached`und `detached`, sowie die exemplarischen Eigenschaften `fancy`, `author` und die Funktionen `sayHello` und `fireLasers` entfernt, da diese nicht benötigt werden
- Nun werden die von der Komponente benötigten HTML Import für die Elemente `paper-tabs`, `paper-toolbar`, `iron-pages`, `paper-drawer-panel`, `paper-button`, `paper-icon-button`, `paper-card` und `iron-icons` mittels Bower heruntergeladen und der Komponente hinzugefügt
- Dabei kann der Import für das `polymer`-Element entfernt werden, da dieser schon in den importierten Elementen vorhanden ist
- Nun kann mit dem Aufbau des Layouts mittels den `paper`-Elementen begonnen werden
- Als Wrapper für die gesamte Applikation dient das `paper-drawer-panel`-Element, welches die komplette Applikation in einen `Drawer`-Bereich, einer Marginal-Spalte auf der linken Seite, sowie einem `Main`-Bereich, dem Inhalts-Bereich aufteilt
- Dem `Main`-Bereich wird nun die erste Navigations-Ebene in Form einer `paper-tabs`-Komponente, welche in einer `paper-toolbar` geschachtelt wird, hinzugefügt
- Als Inhalt der `paper-tabs` dient ein `<content>`-Tag-Insertion Point, welcher alle `<paper-tab>`-Elemente des Light DOMs selektiert
- Somit können die Navigationspunkte der ersten Ebene von Außerhalb bestimmt injiziert werden
- Diese Navigations-Punkte werden anschließend mit einem `iron-pages`-Element verbunden, welches die mittels einem `<content>` Inhalte mit der CSS-Klasse `main` in die Komponente injiziert und zwischen diesen umschalten kann
- In den `Drawer`-Bereich wir nun ebenfalls ein `paper-toolbar`-Element hinzugefügt, was jedoch nur optischen Gründen geschuldet ist
- Ebenso wie in den `Main`-Bereich wird nun ein `iron-pages`-Element hinzugefügt, welches als Inhalt einen `<content>`-Tag enthält, der alle `<iron-selector>`-Elemente des Light DOM selektiert
- Die Kinder des `<iron-selector>` bilden dabei die zweite Navigations-Ebene
- Diese `<iron-selector>`-Elemente wiederum können jegliche Art von `paper`-Elementen oder nativen HTML-Elementen enthalten, zwischen denen hin- und her- gewechselt werden können soll
- Somit kann der Inhalt der gesamten Applikation dynamisch beim Verwenden der Komponente mittels Kind-Elementen dieser übergeben werden
- Dabei ist jedoch zu beachten, dass die Struktur des Light DOM einige Regeln befolgen muss
- Die Elemente der ersten Navigations-Ebene (in der oberen Navigation) müssen `paper-tab` Elemente sein, die Anzahl dieser ist jedoch variabel
- Die Elemente der zweiten Navigations-Ebene der Anzahl an Inhalts-Seiten entsprechen und nach Anzahl der Elemente der ersten Navigations-Ebene mittels `iron-selector`-Elementen gegliedert werden
- Welche Elemente die Navigationspunkte selbst sind, spielt dabei keine Rolle
- Der Inhalt selbst kann mit beliebigen Elementen definiert werden, jedoch muss für jedes Element die Klasse `main` definiert werden
- Damit die Applikation das gewünschte Verhalten aufzeigt wurden die Properties `selectedTop` (das ausgewählte Element der ersten Navigations-Ebene) und `selectedContent` (das ausgewählte Element der zweiten Navigations-Ebene) definiert
- Ebenso wurde der `ready`-Callback definiert, welcher beim abgeschlossenen Laden der Komponente die Hilfsfunktionen `_countLinks` und `_addSelectedHandler` ausführt
- Die `_countLinks`-Methode ermöglicht es zwischen den übergebenen Links der zweiten Navigations-Ebene zu wechseln, sodass immer der korrekte Inhalt angezeigt wird, wobei Die `_addSelectedHandler`-Funktion dieses Verhalten auf die erste Navigations-Ebene abbildet
- Sie bedient sich dabei dem automatic node finding um das jeweils aktive Element der Navigationsebenen zu ermitteln
- Abschließend werden in dem Template noch einige Style-Regeln definiert, welche die Applikation auf mobilen Geräten funktionsfähig machen und die Oberfläche optimieren
- Die fertige Polymer-Komponente wird in Abbildung X dargestellt

`![Bild: <Darstellung der multi-navigation-app Komponente>](images/1-multi-navigation-app.jpg "<Darstellung der multi-navigation-app Komponente>")`

- Die Komponente steht unter Versionskontrolle und ist auf GitHub unter der Adresse https://github.com/glur4k/multi-navigation-app sowie im Anhang zu finden
- Sie kann nun mittels dem Tag `<multi-navigation-app>` auf allen Webseiten und Applikationen eingebunden werden


### Deployment mit Bower

- Um die Komponente für andere Entwickler verfügbar zu machen, damit diese sie einfach mit `bower install multi-navigation-app` installieren können, muss sie bei Bower registriert werden
- Hierfür muss zunächst die `bower.json`-Datei um die korrekten Informationen ergänzt werden, da die Komponente sonst nicht von Bower indiziert werden kann
- Entspricht die `bower.json` den Bower-Spezifikationen und wird auf GitHub gepusht, so wird die Komponente mittels dem Befehl `bower register multi-navigation-app git://github.com/glur4k/multi-navigation-app.git` bei Bower registriert
- Nach einer kurzen Zeit wird es von Bower erfasst und ist unter der Adresse `http://bower.io/search/?q=multi-navigation-app` auffindbar
- Mittels `bower info multi-navigation-app` kann die aktuelle Version der Komponente auf Bower ermittelt werden, welche dabei immer das aktuellste Release auf GitHub ist
- Die Komponente kann nun von allen Entwicklern heruntergeladen und in die eigene Webseite oder Applikation eingebunden werden
- Wurde die `bower.json`-Datei um den Eintrag `"keywords": [ "web-components" ]` erweitert, ist sie ebenso in dem customelements.io Elemente-Katalog unter der Adresse `https://customelements.io/glur4k/multi-navigation-app/` zu finden

