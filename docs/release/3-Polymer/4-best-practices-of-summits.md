
    * Zusätzliche Punkte aus Polymer summits (performance, gestures etc.)


#Performance

## Performance Patterns

- Eine App muss performant sein, damit sie genutzt wird
- Siehe Bild: performance-user-perception-reaction-times.jpg


Load - optimize load & first paint

- Bereits das Laden der webcomponents Polyfills blockiert in einem script-tag das weitere Laden der Seite -> <script src="webcomponents.js" async></script> (async Attribut)
- HTML Imports blockieren zwar nicht das Laden, aber das rendern der Webseite, da Scripts und Stylesheets in den Imports das rendern blockieren können -> <link rel="stylesheet" href="element.html" async> (async attribut)
- Lazy load scripts


Render - Optimization tips for a fluent app


# Quellen:

- https://aerotwist.com/blog/polymer-for-the-performance-obsessed/
- Google Polymer Summit Performance Patterns - https://www.youtube.com/watch?v=Yr84DpNaMfk



# Gesture System
