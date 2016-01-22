# Polyfills mit webcomponents.js

- In Kapitel 2.2 wurde gezeigt wie Web Components funktionieren
- es wurde darauf hingewiesen, dass sie nicht in allen Browsern unterstützt werden
- In diesem Kapitel wird auf den aktuellen Stand der Browser, was Polyfills sind und deren Browserunterstützung und Performanz eingegangen


## Native Browserunterstützung von Web Components

- In den einzelnen Unterkapiteln zu den Technologien wurde jeweils kurz gezeigt, ob sie von den Browsern unterstützt wird oder nicht
- Gute Alternative: [citeulike:13914233]
- Deutlich: nur Chrome einziger Vorreiter im Allgemeinen. Nur Templates sind bisher in allen modernen Browsern unterstützt [CBateman]

    - Chrome: Hat alle Spezifikationen komplett ab Version 36 implementiert
    - Firefox: Unterstützt Templates, Custom Elements und Shadow DOM sind zwar implementiert, müssen aber erst noch manuell mit dem Flag `dom.webcomponents.enabled` aktiviert werden, HTML Imports werden, wie in Kapitel (HTML Imports) erwähnt, bis auf weiteres nicht unterstützt
    - Safari: Templates werden ab Version 8 unterstützt, Custom Elements und Shadow DOM befinden sich in der Entwicklung, HTML Imports werden jedoch nicht unterstützt
    - Internet Explorer: Keine Unterstützung der Web Components
    - Edge: Templates werden ab Version 13 unterstützt, über die Entwicklung der restlichen Technologien kann abgestimmt werden [citeulike:13914237]
    - Mobile Browser: Alle Technologien werden bisher nur auf Android in den Browsern, Chrome für Android, Opera und Android Browser unterstützt

- Doch ältere Browser unterstützen nativ keine Technologie der Web Components
- Dennoch besteht die Möglichkeit, mittels JavaScript, ihnen die Funktionalitäten beizubringen
- Mit Hilfe von Polyfills auf ältere Browser portiert werden


## Polyfill webcomponents.js

> A polyfill, or polyfiller, is a piece of code (or plugin) that provides the technology that you, the developer, expect the browser to provide natively. Flattening the API landscape if you will. [citeulike:13914241]

- Mit Hilfe von JavaScript kann eine Technologie also auch in Browsern benutzt werden, welche die Technologie nicht unterstützen
- Mit Hilfe von Polyfills können Technologie-Lücken in Browsern auf mehrere, unterschiedliche Arten "Poly" gestopft "fill" werden [citeulike:13914234]
- Eine Sammlung an Polyfills für die Verschiedenen Technologien der Web Components bildet das JavaScript webcomponents.js
- Wurde von Google im Rahmen der Polymer Entwicklung entwickelt, findet allerdings einen starken Anklang und wurde ausgegliedert, damit es auch unabhängig von der Benutzung von Polymer eingesetzt werden kann

[citeulike:13914239]


### Browserunterstüzung

- Mit dem Einsatz der webcomponents.js Polyfills werden die Web Components auch auf den Internet Explorer, Firefox und Safari Portiert
- Eine genaue Matrix der Browserunterstützung ist in dem folgenden Bild dargestellt

![Bild: Browserunterstützung der Web Components Technologien mit webcomponents.js](images/6-webcomponentsjs-browserunterstützung.jpg "Browserunterstützung der Web Components Technologien mit webcomponents.js. Quelle: [citeulike:13914238]")

- Jedoch werden auch trotz Einsatz des Polyfills nur die aktuelleren Versionen des jeweiligen Browsers unterstützt
- Darin sind nach wie vor beispielsweise nicht der Internet Explorer in Version 8 oder 9 enthalten
- Auch werden einige Technologien nicht komplett nachgestellt
- Custom Elements: die CSS Pseudoklasse :unresolved wird nicht unterstützt
- Shadow DOM: Kann auf Grund der Kapselung nicht komplett künstlich simuliert werden, dennoch versucht das webcomponents.js Polyfill einige der Features zu simulieren, CSS Regeln sprechen alle Elemente in einem künstlichen Shadow an - Als würde man den `>>>` Selektor benutzen - auch die `::shadow` und `::content` Pseudoelemente verhalten sich so
- HTML Templates: Templates die mit einem Polyfill erzeugt werden sind nicht unsichtbar für den Browser, ihre enthaltenen Ressourcen werden also schon beim initialen Laden der Seite heruntergeladen
- HTML Imports: werden mit einem XHR Request heruntergeladen, werden asynchron geladen - auch wenn das `async`-Attribut (wie in Kapitel 2-web-components-technology-stack/4-html-imports gezeigt) nicht gesetzt ist


### Performance

- webcomponents.js ist 116KB groß, viel Code [citeulike:13914238]
- Die CSS Regeln die von den Browsern nicht unterstützt werden, werden ignoriert, deshalb müssen diese mit RegularExpressions nachgebaut werden, aktuell 40 dafür notwendig
- Die Funktionen um im DOM zu traversieren müssen angepasst werden, damit nur die richtigen Elemente angezeigt werden, aktuell in 42 Wrappern umgesetzt -> sehr komplex
- Manche Funktionen wie `window.document` können nicht überschrieben werden
- Dadurch wird die DOM API verlangsamt
- Die Performanz sinkt dadurch, speziell in mobilen Browsern, drastisch ab und ist nicht tolerierbar [citeulike:13886251]


## Quellen

- [citeulike:13914234] - http://www.amazon.de/gp/product/144937073X?keywords=polyfills&qid=1450181081&ref_=sr_1_3&sr=8-3, http://cdn.oreillystatic.com/oreilly/booksamplers/9781449370732_sampler.pdf
- [citeulike:13914237] https://dev.windows.com/en-us/microsoft-edge/platform/status/?filter=f3f0000bf&search=web%20components
- [citeulike:13914238] https://github.com/webcomponents/webcomponentsjs
- [citeulike:13914233] http://jonrimmer.github.io/are-we-componentized-yet/
- [CBateman] http://cbateman.com/blog/a-no-nonsense-guide-to-web-components-part-2-practical-use/
- [citeulike:13914239] http://webcomponents.org/polyfills/
- [citeulike:13914241] https://remysharp.com/2010/10/08/what-is-a-polyfill
- [citeulike:13886251] https://www.polymer-project.org/1.0/articles/shadydom.html


