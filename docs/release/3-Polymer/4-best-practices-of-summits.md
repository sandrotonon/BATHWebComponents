
    * Zusätzliche Punkte aus Polymer summits (performance, gestures etc.)


# Performance

## Performance Patterns

- Eine App muss performant sein, damit sie genutzt wird
- Siehe Bild: performance-user-perception-reaction-times.jpg


### Load - optimize load & first paint

- Alles wird synchron geladen, die seite bleibt lange weiß und der inhalt wird plötzlich angezeigt
- Bereits das Laden der webcomponents Polyfills blockiert in einem script-tag das weitere Laden der Seite -> Lösung: <script src="webcomponents.js" async></script> (async Attribut)
- HTML Imports blockieren zwar nicht das Laden, aber das rendern der Webseite, da Scripts und Stylesheets in den Imports das rendern blockieren können -> Lösung: <link rel="stylesheet" href="element.html" async> (async attribut)
- -> Nichts blockiert das Rendern
- `unresolved` attribut auf dem body muss entfernt werden (es versteckt alle inhalte bis sie komplett geladen wurden)
- Lazy load scripts - webcomponents.js nur laden wenn sie benötigt werden
```var webComponentsSupported = ('registerElement' in document
     && 'import' in document.createElement('link')
     && 'content' in document.createElement('template'));
```
- Dadurch werden die inhalte direkt angezeigt, allerdings ungestyled
- Der dadruch entstehende FOUC muss manuell gehandhabt werden
- Lösung: Grobe Styles für das ungefähre aussehen der app als `<style>` definieren
- Die custom elements werden denn nach und nach in die container geladen, die grobe app wird direkt angezeigt und die app wird schnell geladen


### Render - Optimization tips for a fluent app

- Shadow DOM statt dem shady DOM benutzen -> c++ schneller als JS, scoping schneller, rendert schneller `window.Polymer = window.Polymer || {dom: 'shadow'};`
- touch events statt click events wegen der 300ms zeitverzögerung
- lazy render elements -> elemente nur rendern wenn sie auch gebraucht werden, da sonst viel zu viele initial geladen werden. wenn der user dann mit der seite interagiert werden nach und nach die benötigten elemente gerendert
- z.b. iron list -> rendert nur den DOM im viewport oder `<template is='dom-if' if='{{open}}'>` (template dom-if), rendert nur wenn element ist aktiv (z.b. dom des dropdown wird nur generiert wenn es ausgeklappt ist)


### Future

- Preload: Browser cached die ressource für später `rel="preload"`
- http/2 push: der server pusht die benötigten datein in den cache des browsers die er benötigen wird. dadurch muss er nicht jedes file selbst anfordern -> macht das laden der seite extrem schneller
https://http2.github.io/faq/#whats-the-benefit-of-server-push


### Tools

- Polymer DevTools Extension gibt informationen über polymer elemente auf einer seite

https://chrome.google.com/webstore/detail/polymer-devtools-extensio/mmpfaamodhhlbadloaibpocmcomledcg


## Quellen:

- https://aerotwist.com/blog/polymer-for-the-performance-obsessed/
- Google Polymer Summit Performance Patterns - https://www.youtube.com/watch?v=Yr84DpNaMfk
- http://chimera.labs.oreilly.com/books/1230000000545/ch10.html#_hypertext_web_pages_and_web_applications
- https://gist.github.com/ebidel/1ba71473d687d0567bd3


# Gesture System

- wichtig weil die App flüssig auf Input reagieren muss
- können auf Smartphones, Tablets, Desktop und Uhren benutzt werden
- Devices verhalten sich mit Maus und Touch unterschiedlich
- der Entwickler muss sich um beides kümmern
- das Polymer gesture system kümmert sich automatisch darum
- Vereint die Events von Maus und Touch in 4 Events die für alle Plattformen gleich sind
- `down & up`, `tap`, `track` Events feuern konsistent auf Touch und Klick Umgebungen, sollten also statt den spezifischen klick und touch events Gegenstücken benutzt werden


## Down & up

- Wird gefeuert wenn der Finger / die Maus auf das Element drückt oder es loslässt
- einfachsten Gesten aber sind bei den meisten Anforderungen ausreichend
- können eingesetzt werden um zu visualisieren welches Element gerade geklickt wird
- normaler weise sind dafür vier events nötig: touchstart, touchend, mousedown, mouseup
- touch events hören nur auf das getouchte Element, die mouse events ändern ihr ziel beim bewegen des cursors d.h. man hört auf das gesamte dokument um auf den mouseup zu warten
- mit polymer braucht man 2 lsiteners `down` und `up`
```
Polymer({
    is: 'my-element',
    listeners: {
        'down': 'startFunction',
        'up': 'endFunction'
    },
    startFunction: function() { ... },
    endFunction: function() { ... }
    });
```


## Tap

- Verbindet Down und up 
- ein Event für auswählen und pressen eines Elements auf allen Devices
- funktioniert gleich für Maus und touch, gesture layer kümmert sich um die plattformunterschiede
- wird am meisten benutzt weil die meisten Aktionen der User tap/click sind


## Track

- wird gefeuert wenn der Finger / die Maus beim drücken eines Elements bewegt wird
- Wird bei allen Aktionen eingesetzt die dragging benötigen (z.b. slider)
- funktioniert bei der maus nativ mit HTML5 drag&drop, manche Plattformen haben touch events aber das funktioniert meist nicht überall und ist sehr kompliziert
- mouse und touch unterscheiden sich beim draggen stark
- Elemente mit dem `track` event listener verhindern standardmäßig das scrollen da bei touch devices zwischen scrollen und draggen untschieden werden muss
- beim initialisieren des Elements sollte das Scrollverhalten wieder hergestellt werden `this.setScrollDirection(direction, node);` wird für `direction` der wert `'y'` angegeben, so kann über dem element auf der vertikalen Achse gescrollt werden, wobei das draggen des Elements in horizontaler Achse funktioniert
- `node` ist hier standardmäßig `this`, also das zu trackende Element
- das track event hat 3 verschiedene stati `start` `track` und `end` mit denen das Verhalten für den aktuellen Status definiert werden kann


# Quellen

- https://www.youtube.com/watch?v=EUpUz3RUvdc&list=PLNYkxOF6rcICdISJclfQhj2S8QZGjXV8J&index=13
- https://www.polymer-project.org/1.0/docs/devguide/events.html#gestures
