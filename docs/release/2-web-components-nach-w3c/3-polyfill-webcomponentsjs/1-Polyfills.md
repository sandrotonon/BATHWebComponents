# Polyfills mit webcomponents.js

- In Kapitel 2.2 wurde gezeigt wie Web Components funktionieren
- es wurde darauf hingewiesen, dass sie nicht in allen Browsern unterstützt werden
- In diesem Kapitel wird auf den aktuellen Stand der Browser, was Polyfills sind und deren Browserunterstützung, Performanz und Barrierefreiheit, sowie praktische Implementierungen eingegangen


## Native Browserunterstützung von Web Components

- In den einzelnen Unterkapiteln zu den Technologien wurde jeweils kurz gezeigt, ob sie von den Browsern unterstützt wird oder nicht
- Gute Alternative: [AreWeComponentizedYet]
- Deutlich: nur Chrome einziger Vorreiter im Allgemeinen. Nur Templates sind bisher in allen modernen Browsern unterstützt [CBateman]

    - Chrome: Hat alle Spezifikationen komplett ab Version 36 implementiert
    - Firefox: Unterstützt Templates, Custom Elements und Shadow DOM sind zwar implementiert, müssen aber erst noch manuell mit dem Flag `dom.webcomponents.enabled` aktiviert werden, HTML Imports werden, wie in Kapitel (HTML Imports) erwähnt, bis auf weiteres nicht unterstützt
    - Safari: Templates werden ab Version 8 unterstützt, Custom Elements und Shadow DOM befinden sich in der Entwicklung, HTML Imports werden jedoch nicht unterstützt
    - Internet Explorer: Keine Unterstützung der Web Components
    - Edge: Templates werden ab Version 13 unterstützt, über die Entwicklung der restlichen Technologien kann abgestimmt werden [Microsoft Edge Platform Status]
    - Mobile Browser: Alle Technologien werden bisher nur auf Android in den Browsern, Chrome für Android, Opera und Android Browser unterstützt

- Doch ältere Browser unterstützen nativ keine Technologie der Web Components
- Dennoch besteht die Möglichkeit, mittels JavaScript, ihnen die Funktionalitäten beizubringen
- Mit Hilfe von Polyfills auf ältere Browser portiert werden


## Polyfill webcomponents.js

> A polyfill, or polyfiller, is a piece of code (or plugin) that provides the technology that you, the developer, expect the browser to provide natively. Flattening the API landscape if you will. [Remi Sharp]

- Mit Hilfe von JavaScript kann eine Technologie also auch in Browsern benutzt werde, welche die Technologie nicht unterstützen
- Mit Hilfe von Polyfills können Technologie-Lücken in Browsern auf mehrere, unterschiedliche Arten "Poly" gestopft "fill" werden [Building Polyfills]
- Eine Sammlung an Polyfills für die Verschiedenen Technologien der Web Components bildet das JavaScript webcomponents.js
- Wurde von Google im Rahmen der Polymer Entwicklung entwickelt, findet allerdings einen starken Anklang und wurde ausgegliedert, damit es auch unabhängig von der Benutzung von Polymer eingesetzt werden kann

[webcomponents.org]


## Performance

- http://developer.telerik.com/featured/web-components-arent-ready-production-yet/
- http://www.websitemagazine.com/content/blogs/posts/archive/2014/11/20/web-components-the-dos-and-don-ts-for-production.aspx
- http://cbateman.com/blog/a-no-nonsense-guide-to-web-components-part-2-practical-use/


## Quellen

- [Building Polyfills] - http://www.amazon.de/gp/product/144937073X?keywords=polyfills&qid=1450181081&ref_=sr_1_3&sr=8-3
- [Microsoft Edge Platform Status] https://dev.windows.com/en-us/microsoft-edge/platform/status/?filter=f3f0000bf&search=web%20components
- [webcomponents.js] https://github.com/webcomponents/webcomponentsjs
- [AreWeComponentizedYet] http://jonrimmer.github.io/are-we-componentized-yet/
- [CBateman] http://cbateman.com/blog/a-no-nonsense-guide-to-web-components-part-2-practical-use/
- [webcomponents.org] http://webcomponents.org/polyfills/
- [Remi Sharp] https://remysharp.com/2010/10/08/what-is-a-polyfill


