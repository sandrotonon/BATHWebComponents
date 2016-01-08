
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
