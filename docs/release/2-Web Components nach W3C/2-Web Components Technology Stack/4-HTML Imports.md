# HTML Imports

- TODO:
  + Vulcanize
  + Performance

- Ausformulieren
  + Complete


## Einführung
- Praktisch alle Plattformen erlauben es, Code zum Importieren, nur nicht das Web.
- Bisher ist es nur möglich JavaScript, CSS, Images etc. in ein HTML Dokument zu importieren, HTML selbst hingegen nicht
- ebenso gibt es keine Möglichkeit JavaScript, CSS, HTML, etc. via einer einzigen Resource zu importieren
- HTML Imports sollen dieses Problem lösen


## HTML importieren

- HTML Imports werden, wie andere Imports auch, per `<link>` Tag deklariert
- Als `rel` Attribut wird "import" angegeben

```html
<head>
  <link rel="import" href="/imports/myimport.html">
</head>
```

- Ein HTML Import wird nur einmal geladen, auch wenn ein Request auf eine HTML Datei mehrmals erfolgt, d.h. enthaltenes JavaScript wird nur einmal ausgeführt
- HTML Imports von einer anderen Domain sind eine Sicherheitslücke, wenn man aber dennoch eine HTML Datei von einer anderen Seite importieren will, muss CORS (Cross Origin Resource Sharing) aktiviert sein
[Developing Web Components 2015]

> Using only one URL, you can package together a single relocatable bundle of web goodness for others to consume.
[Eric Bidelman 2013]


## Vorteil

- HTML Imports ermöglichen es eine gesamte App via HTML Import zu importieren
- So kann beispielsweise das Einbinden von Bootstrap stark vereinfacht werden

Bisher:

```html
<link rel="stylesheet" href="bootstrap.css">
<link rel="stylesheet" href="fonts.css">
<script src="jquery.js"></script>
<script src="bootstrap.js"></script>
<script src="bootstrap-tooltip.js"></script>
<script src="bootstrap-dropdown.js"></script>
```

- Stattdessen kann dieses Markup nun in ein einziges HTML Dokument, welches alle Abhängigkeiten verwaltet, geschrieben werden
- Dieses wird dann mit einem einzigen Import in das eigene HTML Dokument importiert

HTML Import:

```html
<head>
  <link rel="import" href="bootstrap.html">
</head>
```


## HTML Imports verwenden

- Importierte HTML Dateien werden nicht nur in das Dokument eingefügt, sondern vom Parser verarbeitet, das bedeutet, dass mit JavaScript auf den DOM des Imports zugegriffen werden kann
- Um auf den Inhalt des Imports zuzugreifen muss die `.import` Eigenschaft des `<link>` zugegriffen werden `var content = document.querySelector('link[rel="import"]').import;`
- Nun kann auf den DOM des `content` zugegriffen werden. Beispielsweise kann ein Element mit der Klasse `.element` geklont und dann in das eigene HTML eingefügt werden

```html
<head>
  <link rel="import" href="element.html">
</head>
<body>
  <script>
    var content = document.querySelector('link[rel="import"]').import;

    var el = content.querySelector('.element');

    document.body.appendChild(el.cloneNode(true));
  </script>
</body>
```


## Abhängigkeiten verwalten und Sub-Imports

### Sub-Imports

- HTML Dateien die in einem HTML Dokument importiert werden, können selbst auch HTML Dateien importieren
- Somit können andere Komponenten wiederverwendet und erweitert werden
- Wenn eine Komponente A eine Abhängigkeit von einer Komponenten B hat und es eine neue Version von Komponente B gibt, kann diess einfach in dem Import des Sub-Imports angepasst werden ohne JavaScript ändern zu müssen


### Abhänigkeiten verwalten

- Wenn mehrere HTML Imports die gleichen Abhängigkeiten - z.B. jQuery - haben, wird das jQuery.js dennoch automatisch nur einmal vom Browser heruntergeladen

index.html
```html
<link rel="import" href="component1.html">
<link rel="import" href="component2.html">
```

component1.html
```html
<script src="jQuery.html"></script>
```

component2.html
```html
<script src="jQuery.html"></script>
```

jQuery.html
```html
<script src="js/jquery.js"></script>
```

- Des Weiteren muss auch nicht auf die Reihenfolge der Imports geachtet werden, da diese selbst ihre Abhängigkeiten beinhalten

[Eiji Kitamura 2015]


## Performance - TODO

> Sind Web Components nicht eine Katastrophe für die Performance? So spaltet sich doch die komplette Seite in hundert Einzel-Downloads auf, jede Komponente lädt jedes Mal neu jQuery … oder gibt es da einen Trick?

> Heutzutage ist das möglicherweise tatsächlich ein Problem, das sich aber in Zukunft von selbst in Luft auflösen wird. Das Doppel-Download-Problem besteht in Browsern mit nativer Unterstützung für Web Components gar nicht erst, da hier Doppel-Requests automatisch dedupliziert werden (so liest man jedenfalls allerorten; in konkreten Specs habe ich nichts gefunden, das das verlangt). Im Polymer-Polyfill passiert das einfach anhand des Ressourcen-Pfades, die native Implementierung soll auch identische Ressourcen aus unterschiedlichen Quellen deduplizieren können.

> Dass Web Components dann immer noch zu vielen Einzel-Requests führen, ist in nicht all zu ferner Zukunft ein Feature und kein Bug. Mit HTTP/2 bzw. SPDY als Netzwerkprotokoll hat man, anders als beim HTTP 1.1 von heute, keinen Vorteil mehr, wenn man Ressourcen zusammenfasst. Im Gegenteil: wenn man sein Frontend in viele kleine Teile aufsplittet, hat man den Vorteil, dass bei der Änderung einer einzigen Icongrafik der Nutzer nicht mehr das komplette Bild-Sprite, sondern wirklich nur eine einzige Winzdatei neu herunterladen muss. Anders gesagt übernimmt HTTP/2 das Zusammenfassen von Dateien auf Protokollebene und Webentwickler müssen es nicht mehr selbst machen. Und nur die üblichen Verdächtigen (d.h. IE und Safari) können das nicht bereits heute. Mehr Infos zum Thema gibt es in einem epischen Slide Deck aus der Feder von Performance-Papst Schepp.

> Die Web-Component-Performance-Problematik löst sich also im Laufe der Zeit von selbst. Bis dahin kann man sich mit *Vulcanize*, einem Tool zum Zusammenfassen von HTML-Imports inklusive aller Ressourcen in eine einzige Datei, behelfen.

[Peter Kröner 2014]


### HTTP/2 - TODO

### "Vulcanize" - TODO


## Anwendungen

- Ganze Web Applikationen mit HTML/JavaScript/CSS können in eine Datei geschrieben und von anderen Importiert werden
- Code Organisation: Einzelne Abschnitte einer Anwendung oder von Code können in einzelne Dateien ausgelagert werden, was Web Applikationen modular und wiederverwendbar macht
- HTML Imports können ein oder mehrere Custom Elements beinhalten und in eine Applikation einbinden. Somit wird das Interface des Elements und dessen Definition gekapselt
- Abhängigkeitsverwaltung: Resourcen werden automatisch nur einmal geladen
- Einzelne kleine JavaScripts werden schneller ausgeführt als wenn der Browser eine große JavaScript Library parsen und dann ausführen muss

[Eric Bidelman 2013]


## Browserunterstüzung

- HTML Imports wurden noch nicht vom W3C standardisiert, sondern sind noch ein Working Draft (http://www.w3.org/TR/html-imports/)
- Deshalb werden sie bisher auch nur in Chrome und Opera unterstützt

![Bild: HTML Imports Browserunterstützung](https://raw.githubusercontent.com/glur4k/BATHWebComponents/93d15c398717d7124f42d193f99000a1e4979cbe/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/4-HTML-Imports_Browserunterstuetzung.jpg "HTML Imports Browserunterstützung. Quelle: http://caniuse.com/#search=imports")

[Can I Use 2015]


## Quellen

- [Developing Web Components 2015] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.139-147
- [Eric Bidelman 2013] http://www.html5rocks.com/en/tutorials/webcomponents/imports/
- [Can I Use 2015] Can I Use, http://caniuse.com/#search=imports
- http://www.w3.org/TR/html-imports/
- [Peter Kröner 2014] Peter Kröner, http://www.peterkroener.de/fragen-zu-html5-und-co-beantwortet-15-web-components-performance-css-variablen-data-urls-async/
- http://www.hongkiat.com/blog/html-import/
- [Eiji Kitamura 2015] Eiji Kitamura, Introduction to HTML Imports, http://webcomponents.org/articles/introduction-to-html-imports/

