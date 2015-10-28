# Notizen
- Shadow Dom ist für Screenreader uä. kein problem

## Erste Schritte

- webcomponents.js mit bower installieren (http://webcomponents.org/polyfills/)


## HTML Templates
- Sind bereits standard (alle anderen APIs nicht - https://html.spec.whatwg.org/multipage/scripting.html#the-template-element)

## Shadow DOM

- Passwort in einem <input type="password"> sichtbar!
- Insertion Points nachsehen!
   - Es kann mehrere contents geben, die ein select attribut haben um nur spezielle inhalte "durchlassen"


## Performance

Sind Web Components schlecht für die Performance?
Sind Web Components nicht eine Katastrophe für die Performance? So spaltet sich doch die komplette Seite in hundert Einzel-Downloads auf, jede Komponente lädt jedes Mal neu jQuery … oder gibt es da einen Trick?

Heutzutage ist das möglicherweise tatsächlich ein Problem, das sich aber in Zukunft von selbst in Luft auflösen wird. Das Doppel-Download-Problem besteht in Browsern mit nativer Unterstützung für Web Components gar nicht erst, da hier Doppel-Requests automatisch dedupliziert werden (so liest man jedenfalls allerorten; in konkreten Specs habe ich nichts gefunden, das das verlangt). Im Polymer-Polyfill passiert das einfach anhand des Ressourcen-Pfades, die native Implementierung soll auch identische Ressourcen aus unterschiedlichen Quellen deduplizieren können.

Dass Web Components dann immer noch zu vielen Einzel-Requests führen, ist in nicht all zu ferner Zukunft ein Feature und kein Bug. Mit HTTP/2 bzw. SPDY als Netzwerkprotokoll hat man, anders als beim HTTP 1.1 von heute, keinen Vorteil mehr, wenn man Ressourcen zusammenfasst. Im Gegenteil: wenn man sein Frontend in viele kleine Teile aufsplittet, hat man den Vorteil, dass bei der Änderung einer einzigen Icongrafik der Nutzer nicht mehr das komplette Bild-Sprite, sondern wirklich nur eine einzige Winzdatei neu herunterladen muss. Anders gesagt übernimmt HTTP/2 das Zusammenfassen von Dateien auf Protokollebene und Webentwickler müssen es nicht mehr selbst machen. Und nur die üblichen Verdächtigen (d.h. IE und Safari) können das nicht bereits heute. Mehr Infos zum Thema gibt es in einem epischen Slide Deck aus der Feder von Performance-Papst Schepp.

Die Web-Component-Performance-Problematik löst sich also im Laufe der Zeit von selbst. Bis dahin kann man sich mit *Vulcanize*, einem Tool zum Zusammenfassen von HTML-Imports inklusive aller Ressourcen in eine einzige Datei, behelfen.


## Production?
- JA: http://developer.telerik.com/featured/web-components-ready-production/
- NEIN: http://developer.telerik.com/featured/web-components-arent-ready-production-yet/


## Github benutzt Web Components
https://github.com/github/time-elements


## Vorteile / Nachteile
+ Wartbar
+ Vorteile hier: https://medium.com/@kaelig/why-web-components-will-make-the-web-a-better-place-for-our-users-38dc3154fc1d#.vnd37gx9h
- Einige Nachteile hier: http://ianfeather.co.uk/practical-questions-around-web-components/


## Styling
- http://philipwalton.com/articles/extending-styles/
- https://www.polymer-project.org/1.0/docs/devguide/styling.html#style-modules
  |- Shared Styles (Polymer - Auch ohne Polymer umsetzbar?)


- Mozilla - The state of WebComponents: https://hacks.mozilla.org/2015/06/the-state-of-web-components/


## Microsoft und WebComponents
- https://entwickler.de/online/web/web-components-microsoft-edge-167732.html


## Polymer Methapher
HTML standard-Tags sind Atome. Polymer / Web Components bauen Atome zusammen zu Molekülen, die Komponenten
Aus der verdrahtung der kleinen Teile wird zu Engeneering
ermöglich libraries, plattformen die wiederverwendbar sind


## https://blogs.windows.com/msedgedev/2015/07/14/bringing-componentization-to-the-web-an-overview-of-web-components/
Bringing Componentization to the Web: An Overview of Web Components (part 1):

The goal of web components is to reduce complexity by isolating a related group of HTML, CSS, and JavaScript to perform a common function within the context of a single page.

### CSS style isolation
There is no great way to componentize CSS natively in the platform today (though tools like Sass can certainly help). A component model must support a way to *isolate some set of CSS from another* such that the rules defined in one don’t interfere with the other. Additionally, component styles should apply only to the necessary parts of the component and nothing else.

## Accessebility - https://css-tricks.com/modular-future-web-components/
Obviously when you're hiding markup in secret shadow DOM sandboxes the issue of accessibility becomes pretty important. Steve Faulkner took a look at accessibility in shadow DOM and seemed to be satisfied with what he found.

Results from initial testing indicate that inclusion of ARIA roles, states and properties in content wholly inside the Shadow DOM works fine. The accessibility information is exposed correctly via the accessibility API. Screen readers can access content in the Shadow DOM without issue.
The full post is available here.

Marcy Sutton* has also written a post exploring this topic in which she explains:

Web Components, including Shadow DOM, are accessible because assistive technologies encounter pages as rendered, meaning the entire document is read as “one happy tree”.
*Marcy also points out that the img-slider I built in this post is not accessible because our css label trick makes it inaccessible from the keyboard. Keep that in mind if you're looking to reuse it in a project.
