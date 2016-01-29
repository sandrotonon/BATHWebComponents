# Komponenten Entwicklung

- TODO
- auf abschnitte eingehen



## Entwicklung und Deployment einer Polymer Komponente

- Als Beispielimplementierung eines Polymer-Elements wird eine SPA Navigation mit erster und zweiter Navigationsebene implementiert
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
- Mittels `yo polymer:seed my-element` wird der Generator für das `my-element` gestartet und die HTML Datei mit der entsprechenden Polymer Grundstruktur generiert (in Anhang machen?)


### Die multi-navigation-app Komponente

- `polyserve`
- GitHub: https://github.com/glur4k/multi-navigation-app


### Deployment mit Bower

- Um die Komponente für andere Entwickler verfügbar zu machen, damit diese sie einfach mit `bower install multi-navigation-app` installieren können, muss sie bei Bower registriert werden
- Hierfür muss zunächst die `bower.json`-Datei um die korrekten Informationen ergänzt werden, da die Komponente sonst nicht von Bower indiziert werden kann
- Entspricht die `bower.json` den Spezifikationen und auf GitHub gepusht, so wird die Komponente mittels dem Befehl `bower register multi-navigation-app git://github.com/glur4k/multi-navigation-app.git` bei Bower registriert
- Nach einer kurzen Zeit wird es von Bower erfasst und ist unter der Adresse `http://bower.io/search/?q=multi-navigation-app` auffindbar
- Mittels `bower info multi-navigation-app` kann die aktuelle Version der Komponente auf Bower ermittelt werden, welche dabei immer das aktuellste Release auf GitHub ist
- Die Komponente kann nun von allen Entwicklern heruntergeladen und in die eigene Webseite oder Applikation eingebunden werden
- Wurde die `bower.json`-Datei um den Eintrag `"keywords": [ "web-components" ]` erweitert, ist sie ebenso in dem customelements.io Elemente-Katalog unter der Adresse `https://customelements.io/glur4k/multi-navigation-app/` zu finden

