# HTML Imports

- TODO:
  - Einführung
  - Performance


## Einführung
- Praktisch alle Plattformen erlauben es, Code zum Importieren, nur nicht das Web.


## Performance

> Sind Web Components nicht eine Katastrophe für die Performance? So spaltet sich doch die komplette Seite in hundert Einzel-Downloads auf, jede Komponente lädt jedes Mal neu jQuery … oder gibt es da einen Trick?

> Heutzutage ist das möglicherweise tatsächlich ein Problem, das sich aber in Zukunft von selbst in Luft auflösen wird. Das Doppel-Download-Problem besteht in Browsern mit nativer Unterstützung für Web Components gar nicht erst, da hier Doppel-Requests automatisch dedupliziert werden (so liest man jedenfalls allerorten; in konkreten Specs habe ich nichts gefunden, das das verlangt). Im Polymer-Polyfill passiert das einfach anhand des Ressourcen-Pfades, die native Implementierung soll auch identische Ressourcen aus unterschiedlichen Quellen deduplizieren können.

> Dass Web Components dann immer noch zu vielen Einzel-Requests führen, ist in nicht all zu ferner Zukunft ein Feature und kein Bug. Mit HTTP/2 bzw. SPDY als Netzwerkprotokoll hat man, anders als beim HTTP 1.1 von heute, keinen Vorteil mehr, wenn man Ressourcen zusammenfasst. Im Gegenteil: wenn man sein Frontend in viele kleine Teile aufsplittet, hat man den Vorteil, dass bei der Änderung einer einzigen Icongrafik der Nutzer nicht mehr das komplette Bild-Sprite, sondern wirklich nur eine einzige Winzdatei neu herunterladen muss. Anders gesagt übernimmt HTTP/2 das Zusammenfassen von Dateien auf Protokollebene und Webentwickler müssen es nicht mehr selbst machen. Und nur die üblichen Verdächtigen (d.h. IE und Safari) können das nicht bereits heute. Mehr Infos zum Thema gibt es in einem epischen Slide Deck aus der Feder von Performance-Papst Schepp.

> Die Web-Component-Performance-Problematik löst sich also im Laufe der Zeit von selbst. Bis dahin kann man sich mit *Vulcanize*, einem Tool zum Zusammenfassen von HTML-Imports inklusive aller Ressourcen in eine einzige Datei, behelfen.

Quelle: 1)


## Quellen
1) http://www.peterkroener.de/fragen-zu-html5-und-co-beantwortet-15-web-components-performance-css-variablen-data-urls-async/
- http://www.hongkiat.com/blog/html-import/
- http://webcomponents.org/articles/introduction-to-html-imports/
