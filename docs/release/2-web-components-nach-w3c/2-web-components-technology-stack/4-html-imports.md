# HTML Imports

HTML Imports ist eine Technologie, die es erlaubt HTML Dateien in einer Webseite zu inkludieren. Sie sollen es ermöglichen die Webseite in einzelne, kleine, auswechselbare Teile aufzuteilen. In dem folgenden Kapitel wird auf den Begriff HTML Imports des Web Components Technology Stacks im Genaueren eingegangen.

- TODO:
  + Vulcanize
  + Performance

- Ausformulieren
  + Complete


## Einleitung

Bisher erlauben es praktisch alle Plattformen, Codeteile zu Importieren und zu verwenden, nur nicht das Web, bzw. HTML. Das heutige HTML ermöglicht es externe Stylesheets, JavaScript Dateien, Bilder etc. in ein HTML Dokument zu importieren, HTML-Dateien selbst können jedoch nicht importiert werden. Auch ist es nicht möglich, alle benötigten Dateien in einer Ressource zu bündeln und als einzige Abhängigkeit zu importieren. HTML Imports versuchen eben dieses Problem zu lösen. So soll es möglich sein, HTML-Dateien und wiederum HTML-Dateien in HTML-Dateien zu importieren. So können auch verschiedene benötigte Dateien in einer HTML-Datei gesammelt, und mit nur einem Import in die Seite eingebunden werden. Doppelte Abhängigkeiten sollen dadurch automatisch aufgelöst werden, sodass Dateien, die mehrmals eingebunden werden sollten, automatisch effektiv nur einmal heruntergeladen werden.


## HTML Dateien importieren

Imports von HTML Dateien selbst werden, wie andere Imports auch, per `<link>` Tag deklariert. Neu ist jedoch der Wert des `rel`-Attributes, welcher auf `import` gesetzt wird.

```html
<head>
  <link rel="import" href="/myimport.html">
</head>
```

Sollte nun ein HTML Import mehrfach aufgeführt sein, oder eine HTML-Datei anfordern die schon geladen wurde, so wird die Abhängigkeit automatisch ignoriert und die Datei nur ein einziges Mal übertragen. Dadurch wird eventuell in den HTML-Dateien enthaltenes JavaScript auch nur ein mal ausgeführt. Es ist jedoch zu beachten, dass HTML Imports nur auf Ressourcen der gleichen Quelle, also dem gleichen Host, respektive der gleichen Domain zugreifen können. Imports von HTML-Dateien von verschiedenen Quellen stellen eine Sicherheitslücke dar, da Webbrowser die SOP verfolgen. 

> The same-origin policy restricts how a document or script loaded from one origin can interact with a resource from another origin. It is a critical security mechanism for isolating potentially malicious documents.

[citeulike:13853253]

Sollte das jedoch dennoch erlaubt werden, so muss das CORS für die entsprechende Domain auf dem Server aktiviert werden.

> These restrictions prevent a client-side Web application running from one origin from obtaining data retrieved from another origin, and also limit unsafe HTTP requests that can be automatically launched toward destinations that differ from the running application's origin.

[citeulike:13853643]


## Vorteil

Durch HTML Imports ist es möglich komplette Applikationen mit mehreren oder gar nur einer einzigen Anweisung zu importieren. Dies gilt sowohl für eigene Applikationen oder kleinere Komponenten, wie beispielsweise einem Slider oder ähnlichem, als auch fremde Frameworks oder Komponenten. Durch die HTML Imports wird die Abhängigkeiten-Verwaltung stark vereinfacht und automatisiert.

> Using only one URL, you can package together a single relocatable bundle of web goodness for others to consume.
[citeulike:13853647]

So kann beispielsweise das Bootstrap-Framework statt, wie bisher, mit mehreren Imports mit nur einem Import eingebunden werden. Bisher könnte die Einbindung unter Berücksichtigung der Abhängigkeiten wie folgt aussehen.

```html
<link rel="stylesheet" href="bootstrap.css">
<link rel="stylesheet" href="fonts.css">
<script src="jquery.js"></script>
<script src="bootstrap.js"></script>
<script src="bootstrap-tooltip.js"></script>
<script src="bootstrap-dropdown.js"></script>
```


Stattdessen kann dieses Markup nun in ein einziges HTML Dokument, welches alle Abhängigkeiten verwaltet, geschrieben werden. Dieses wird dann mit einem einzigen Import in das eigene HTML Dokument importiert.

```html
<head>
  <link rel="import" href="bootstrap.html">
</head>
```


## HTML Imports verwenden

Importierte HTML Dateien werden nicht nur in das Dokument eingefügt, sondern vom Parser verarbeitet, das bedeutet, dass mit JavaScript auf den DOM des Imports zugegriffen werden kann. Wenn sie vom Parser verarbeitet worden sind, sind sie zwar verfügbar, allerdings werden die Inhalte nicht angezeigt bis sie mittels JavaScript in den DOM eingefügt werden. Ihre enthaltenen Scripte werden also ausgeführt, Styles und HTML Knoten werden jedoch ignoriert. Um nun die Inhalte eines Imports auf der Seite einzubinden und auf sie zuzugreifen muss auf die `.import` Eigenschaft des `<link>`-Tags mit dem Import zugegriffen werden `var content = document.querySelector('link[rel="import"]').import;`. Nun kann mit auf den DOM des Imports, dem `content`, zugegriffen werden. Beispielsweise kann ein enthaltenes Element mit der Klasse `.element` mit `var el = element.querySelector('.element');` geklont und anschließend durch `document.body.appendChild(el.cloneNode(true));` in den eigenen DOM eingefügt werden. Falls es nun jedoch mehrere Imports geben sollte, können den Imports IDs zugewiesen werden, anhand derer die Imports voneinander unterschieden werden können [citeulike:13853724]. Der komplette Prozess wird in dem folgenden Beispiel skizziert.

```html
<head>
  <link rel="import" href="element.html">
</head>
<body>
  <script>
    var element = document.querySelector('link[rel="import"]').import;

    var el = element.querySelector('.element');

    document.body.appendChild(el.cloneNode(true));
  </script>
</body>
```


## Abhängigkeiten verwalten

Doch wie sieht es nun mit Abhängigkeiten von Imports selbst aus? So kommt es des öfteren vor, dass verschiedene Bibliotheken die auf der Seite eingebunden werden die gleichen Abhängigkeiten haben und diese verwaltet werden müssen. Sollte dies nicht sauber gemacht werden, können unerwartete Fehler auftreten, die mitunter nur schwer zu identifizieren sind. HTML Imports verwalten diese automatisch. Um das zu erreichen, wird jede Abhängigkeit in eine zu importierende HTML-Datei geschrieben, welche diese bündelt. Haben nun mehrere solcher Imports die gleichen Abhängigkeiten, werden diese vom Browser erkannt und nur einmal heruntergeladen und eingebunden. Mehrfachdownloads und Konflikte der Abhängigkeiten werden so verhindert. Das folgende Beispiel von [citeulike:13853700] verdeutlicht dieses Szenario.

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

Selbst wenn die jQuery Bibliothek in mehreren Dateien eingebunden wird, wird hier sie dennoch nur einmal übertragen. Wenn nun fremde HTML-Dateien eingebunden werden muss auch nicht auf die auf die Reihenfolge der Imports geachtet werden, da diese selbst ihre Abhängigkeiten beinhalten.


## Sub-Imports

Das obige Beispiel zeigt, dass HTML Imports selbst auch HTML Imports beinhalten können. Diese Imports werden Sub-Imports genannt und ermöglichen einen einfachen Austausch oder eine Erweiterungen von Abhängigkeiten innerhalb einer Komponente. Wenn eine Komponente A eine Abhängigkeit von einer Komponenten B hat und eine neue Version von Komponente B verfügbar ist, kann dies einfach in dem Import des Sub-Imports angepasst werden ohne den Import in der Eltern-HTML-Datei anpassen zu müssen [citeulike:13853647].


## Performance - TODO

> Sind Web Components nicht eine Katastrophe für die Performance? So spaltet sich doch die komplette Seite in hundert Einzel-Downloads auf, jede Komponente lädt jedes Mal neu jQuery … oder gibt es da einen Trick?

> Heutzutage ist das möglicherweise tatsächlich ein Problem, das sich aber in Zukunft von selbst in Luft auflösen wird. Das Doppel-Download-Problem besteht in Browsern mit nativer Unterstützung für Web Components gar nicht erst, da hier Doppel-Requests automatisch dedupliziert werden (so liest man jedenfalls allerorten; in konkreten Specs habe ich nichts gefunden, das das verlangt). Im Polymer-Polyfill passiert das einfach anhand des Ressourcen-Pfades, die native Implementierung soll auch identische Ressourcen aus unterschiedlichen Quellen deduplizieren können.

> Dass Web Components dann immer noch zu vielen Einzel-Requests führen, ist in nicht all zu ferner Zukunft ein Feature und kein Bug. Mit HTTP/2 bzw. SPDY als Netzwerkprotokoll hat man, anders als beim HTTP 1.1 von heute, keinen Vorteil mehr, wenn man Ressourcen zusammenfasst. Im Gegenteil: wenn man sein Frontend in viele kleine Teile aufsplittet, hat man den Vorteil, dass bei der Änderung einer einzigen Icongrafik der Nutzer nicht mehr das komplette Bild-Sprite, sondern wirklich nur eine einzige Winzdatei neu herunterladen muss. Anders gesagt übernimmt HTTP/2 das Zusammenfassen von Dateien auf Protokollebene und Webentwickler müssen es nicht mehr selbst machen. Und nur die üblichen Verdächtigen (d.h. IE und Safari) können das nicht bereits heute. Mehr Infos zum Thema gibt es in einem epischen Slide Deck aus der Feder von Performance-Papst Schepp.

> Die Web-Component-Performance-Problematik löst sich also im Laufe der Zeit von selbst. Bis dahin kann man sich mit *Vulcanize*, einem Tool zum Zusammenfassen von HTML-Imports inklusive aller Ressourcen in eine einzige Datei, behelfen.

[citeulike:13853714]


### HTTP/2 - TODO

### "Vulcanize" - TODO


## Anwendungen

Besonders einfach machen HTML Imports das einbinden ganzer Web Applikationen mit HTML/JavaScript/CSS. Diese können in eine Datei geschrieben, ihre Abhängigkeiten definieren und von anderen Importiert werden. Dies macht es sehr einfach den Code zu organisieren, so können etwa einzelne Abschnitte einer Anwendung oder von Code in einzelne Dateien ausgelagert werden, was Web Applikationen modular, austauschbar und wiederverwendbar macht. Falls nun ein oder mehrere Cutom Elements in einem HTML Import enthalten sind, so werden dessen Interface und Definitionen automatisch gekapselt. Auch wird die Abhängigkeitsverwaltung in Betracht auf die Performance stark verbessert, da der Browser nicht eine große JavaScript Bibliothek, sondern einzelne kleinere JavaScript Abschnitte parsen und ausführen muss. Diese werden durch die HTML Imports parallel geparst, was mit einen enormen Performance-Schub einher geht [citeulike:13853647].


## Browserunterstüzung

HTML Imports sind noch nicht vom W3C standardisiert, sondern befinden sich noch im Status eines "Working Draft" [citeulike:13853711]. Sie werden deshalb bisher nur von Google Chrome ab Version 43 und Opera ab Version 33 nativ unterstützt.

![Bild: HTML Imports Browserunterstützung](images/4-html-imports-browserunterstuetzung.jpg "HTML Imports Browserunterstützung. Quelle: http://caniuse.com/#search=imports")


## Quellen

- [Developing Web Components 2015] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.139-147
- [citeulike:13853647] http://www.html5rocks.com/en/tutorials/webcomponents/imports/
- [citeulike:13853711] Can I Use, http://caniuse.com/#search=imports
- http://www.w3.org/TR/html-imports/
- [citeulike:13853714] Peter Kröner, http://www.peterkroener.de/fragen-zu-html5-und-co-beantwortet-15-web-components-performance-css-variablen-data-urls-async/
- [citeulike:13853724] http://www.hongkiat.com/blog/html-import/
- [citeulike:13853700] http://webcomponents.org/articles/introduction-to-html-imports/
- [citeulike:13853253] https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy
- [citeulike:13853643] http://www.w3.org/TR/cors/

