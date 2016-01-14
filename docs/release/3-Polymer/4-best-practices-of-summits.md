
    * Zusätzliche Punkte aus Polymer summits (performance, gestures etc.)


# UI Performance Patterns

- Eine App muss performant sein, damit sie genutzt wird
- Siehe Bild: performance-user-perception-reaction-times.jpg


## Load - optimize load & first paint

- Alles wird synchron geladen, die seite bleibt lange weiß und der inhalt wird plötzlich angezeigt
- Bereits das Laden der webcomponents Polyfills blockiert in einem script-tag das weitere Laden der Seite -> Lösung: <script src="webcomponents.js" async></script> (async Attribut)
- HTML Imports blockieren zwar nicht das Laden, aber das rendern der Webseite, da Scripts und Stylesheets in den Imports das rendern blockieren können -> Lösung: <link rel="stylesheet" href="element.html" async> (async attribut)
- -> Nichts blockiert das Rendern
- `unresolved` Attribut auf dem body muss entfernt werden (es versteckt alle inhalte bis sie komplett geladen wurden)
- Lazy load scripts - webcomponents.js nur laden wenn sie benötigt werden
```var webComponentsSupported = ('registerElement' in document
     && 'import' in document.createElement('link')
     && 'content' in document.createElement('template'));
```
- Dadurch werden die Inhalte direkt angezeigt, allerdings ungestyled
- Der dadurch entstehende FOUC muss manuell gehandhabt werden
- Lösung: Grobe Styles für das ungefähre aussehen der App als `<style>` definieren
- Die custom elements werden denn nach und nach in die Container geladen, die grobe app wird direkt angezeigt und die app wird schnell geladen


## Render - Optimization tips for a fluent app

- Shadow DOM statt dem shady DOM benutzen -> c++ schneller als JS, scoping schneller, rendert schneller `window.Polymer = window.Polymer || {dom: 'shadow'};`
- touch events statt click events wegen der 300ms zeitverzögerung
- lazy render elements -> elemente nur rendern wenn sie auch gebraucht werden, da sonst viel zu viele initial geladen werden. wenn der user dann mit der seite interagiert werden nach und nach die benötigten elemente gerendert
- z.b. iron list -> rendert nur den DOM im viewport oder `<template is='dom-if' if='{{open}}'>` (template dom-if), rendert nur wenn element ist aktiv (z.b. dom des dropdown wird nur generiert wenn es ausgeklappt ist)


## Future

- Preload: Browser cached die ressource für später `rel="preload"`
- http/2 push: der server pusht die benötigten datein in den cache des browsers die er benötigen wird. dadurch muss er nicht jedes file selbst anfordern -> macht das laden der seite extrem schneller
https://http2.github.io/faq/#whats-the-benefit-of-server-push


## Tools

- Polymer DevTools Extension gibt Informationen über polymer Elemente auf einer Seite

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
- normaler weise sind dafür vier Events nötig: touchstart, touchend, mousedown, mouseup
- touch events hören nur auf das getouchte Element, die mouse events ändern ihr ziel beim bewegen des cursors d.h. man hört auf das gesamte dokument um auf den mouseup zu warten
- mit polymer braucht man 2 listeners `down` und `up`
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
- funktioniert gleich für Maus und touch, gesture layer kümmert sich um die Plattform Unterschiede
- wird am meisten benutzt weil die meisten Aktionen der User tap/click sind


## Track

- wird gefeuert wenn der Finger / die Maus beim drücken eines Elements bewegt wird
- Wird bei allen Aktionen eingesetzt die dragging benötigen (z.b. slider)
- funktioniert bei der Maus nativ mit HTML5 drag&drop, manche Plattformen haben touch events aber das funktioniert meist nicht überall und ist sehr kompliziert
- mouse und touch unterscheiden sich beim draggen stark
- Elemente mit dem `track` event listener verhindern standardmäßig das scrollen da bei touch devices zwischen scrollen und draggen untschieden werden muss
- beim initialisieren des Elements sollte das Scrollverhalten wieder hergestellt werden `this.setScrollDirection(direction, node);` wird für `direction` der wert `'y'` angegeben, so kann über dem element auf der vertikalen Achse gescrollt werden, wobei das draggen des Elements in horizontaler Achse funktioniert
- `node` ist hier standardmäßig `this`, also das zu trackende Element
- das track event hat 3 verschiedene stati `start` `track` und `end` mit denen das Verhalten für den aktuellen Status definiert werden kann


## Quellen

- https://www.youtube.com/watch?v=EUpUz3RUvdc&list=PLNYkxOF6rcICdISJclfQhj2S8QZGjXV8J&index=13
- https://www.polymer-project.org/1.0/docs/devguide/events.html#gestures


# A11y - Barrierefreiheit in Polymer

- Besonders wichtig im öffentlichen Sektor
- Tool: Chrome Plugin "Accessibility Developer Tools" weist auf verschiedene Probleme bezüglich der Barrierefreiheit einer Webseite hin (Kann auch einen Test laufen lassen und die Seite analysieren, bietet Inspector für accessibility Eigenschaften von Elementen)
- Wird groß geschrieben bei Polymer
- Paper Elements werden nach und nach alle barrierefrei refactored
- Iron Elements bieten accessibility bahaviors welche von eigenen Elementen importiert werden können und das programmieren von barrierefreien Elementen vereinfachen
- Wenn Barrierefreiheit komplett unabhängig erreicht werden soll bietet sich das Polymer `hostAttributes` Objekt an (Siehe "Fokus / Tastatur" und "analogie custom Elements hostAttributes")


## Fokus / Tastatur

- Focusable
- Focus visible
- Keyboard support

- Interaktive Applikationen müssen mit der Tastatur bedienbar sein
- wenn der User keine Maus bedienen kann oder nur eine Tastatur benutzen will
- Elemente müssen hierfür mit der Tastatur fokussierbar sein
- hierfür hilft das `tabindex` Attribut, welches drei verschiedene Werte annehmen kann:
    + -1, es kann fokussiert werden, aber nicht in einer speziellen Reihenfolge der umliegenden Elemente
    + 0, das Element kann in der normalen Reihenfolge des DOMs fokussiert werden
    + > 0 das Element kann in einer manuellen Reihenfolge fokussiert werden
- letzteres sollte allerdings in einem Shadow DOM vermieden werden weil man nicht weiß in welcher Reihenfolge das Element auf der Seite zum Einsatz kommt
- Der Tabindex des Elements kann in dem Polymer `hostAttributes` Objekt definiert werden (Siehe Zeile X Beispiel)
- Wenn ein Element fokussierbar ist, muss der Fokus auch sichtbar sein
- Hierfür kann in den Styles des Elements die Pseudoklasse `:focus` definiert werden (Siehe Zeile X Beispiel) oder alternativ das Behavior (Siehe Behaviors) `PaperInkyFocusBehavior` dem Element hinzugefügt werden
- Nachdem ein Element fokussiert ist muss auch damit interagiert werden können
- Polymer bietet hierfür das Element `iron-a11y-keys-behavior` an, welches ein Mix-in für Tastatur Interaktionen darstellt
- Abstrahiert mit einer einfachen Syntax Unterschiede der Implementierungen in verschiedenen Browsern
- Ermöglicht das definieren von Aktionen beim drücken von verschiedenen Tasten auf der Tastatur


## Semantik

- Declared Semantics
- Meaningful structure
- Labels

- Wichtig für User mit eingeschränktem Sehvermögen
- Diese benutzen Screenreader und die Tastatur um durch die Seite zu navigieren
- Elemente werden zu einem Accessibility Node im Accessibility Tree der assistierenden Software wie dem Screenreader (http://www.w3.org/WAI/PF/aria-implementation/#intro_treetypes)
- Dieser Knoten kann die ARIA Attribute Role, Value, State und Properties haben, welches Das Element im Detail beschreiben und wird ebenso wie der `tabindex` im `hostAttributes` Objekt definiert (siehe Zeile X Beispiel)
- Alternativ können die Attribute auch deklarativ im HTML Markup des Templates gemacht werden `<dom-module>`
- Wenn der Screenreader ein ihm unbekanntes Element findet und diese Attribute nicht definiert sind, wird standardmäßig die Rolle `group` angenommen, beim Vorlesen des Elementes bekommt der User also nur `group` zu hören und weiß somit nicht was der Sinn des Elementes sein soll
- Falls das Element keinen Text beinhalten, keine sichtbare Beschreibung haben sollte oder nur als Interaktions-Mittel für einen Inhalt dient (wie z.b. eine Checkbox oder ein Input-Feld) ist es wichtig ein ARIA `label` oder `labelledby` zu definieren, was eben diesen Inhalt angibt (siehe Zeile X Beispiel)


## Flexibles UI

- redundante Farben
- redundanter Sound
- ausreichender Kontrast
- Vergrößerung

- Die App sollte auch für User mit einer Farbschwäche angepasst sein
- Farben sollten nicht als einziges Medium zum Übertragen von Informationen dienen
- zusätzlich muss eine weitere Farben-unabhängige Darstellung gewählt werden, wie z.b. ein Hinweistext bei einem falsch ausgefüllten Input-Feld
- Abgesehen von Farbtönen können User auch Probleme mit der Farbintensität haben, verschiedene Grautöne beispielsweise können nicht mehr wahrgenommen werden
- Deshalb sollte immer ein ausreichend großer Kontrast für die Informationen gewählt werden .z.b dunkler Text auf hellem Hintergrund
- `Contrast (Minimum): The visual presentation of text and images of text has a contrast ratio of at least 4.5:1` (http://www.w3.org/TR/WCAG20/)
- User mit einer schwachen Sehstärke o.ä. müssen unter Umständen die Seite vergrößern um sie lesen zu können
- Es muss gewährleistet werden, dass die Seite auch bei einem Zoom-Faktor größer 100 korrekt dargestellt wird


## Beispiel

```
<link rel="import" href="../iron-a11y-keys-behavior.html">
<dom-module id="my-element">
    <template>
        <style>
            :host:focus #element {
                boder: 1px solid red;
            }
        </style>
        <div id="element" aria-label="Impoartant article">Some important text</div>
    </template>
    <script>
        Polymer({
            is: 'my-element',
            hostAttributes: {
                tabindex: '0',
                role: 'article',
            },
            keyBindings: {
                'space enter': '_action'
            },
            _action: function(event) { ... }
        });
    </script>
</dom-module>
```


## Quellen

- https://www.youtube.com/watch?v=o6yLWihykVA&list=PLNYkxOF6rcICdISJclfQhj2S8QZGjXV8J&index=14
- https://elements.polymer-project.org/elements/
