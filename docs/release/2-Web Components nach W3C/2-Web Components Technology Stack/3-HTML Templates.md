# HTML Templates

- TODO:

- Ausformulieren:
  - Complete

## Einführung

- Bisher nur im Backend verfügbar in PHP oder Ruby z.B.
- Kommt jetzt auch in den Browser
- Bisher durch Mustache.js oder Handlebars.js


## Bisherige templatetisierung im Browser

### Via hidden div-Element

```html
<div id="mydivtemplate" style="display: none;">
  <div>
    <img src="myimage.jpg">
  </div>
</div>
```

*Nachteil:*
- Resources werden geladen, auch wenn man sie nicht braucht, da sie ja nicht angezeigt werden sollen
- Resourcen und Performance Verschwendung
- Schwieriges Stylen und Themen. Eine Seite die das Template verwendet muss alle CSS Regeln für das Template mit `#mydivtemplate` erstellen


### Via script-Element:

```html
<script type="text/template">
  <div>
    <img src="myimage.jpg">
  </div>
</script>
```

*Nachteil:*
- Sicherheit: Das Template wird via `innerHTML` in einen DOM konvertiert, was eine Cross Site Scripting Sicherheitslücke darstellen kann


## `<template>` Tag

```html
<template id="mytemplate">
  <style>
    // Styles
  </style>
  <script>
    // JavaScript
  </script>
  <img src=""> <!-- Kann zur Laufzeit dynamisch gesetzt werden -->
  <div class="text"></div>
</template>
```

### Benutzung

- Im Quelltext steht an beliebiger Stelle ein `<template>`-Tag
- Der `template`-Knoten des DOM wird ausgewählt (1)
- Der "content", also der Inhalt des `<template>` wird geklont (2) und an einer anderen Stelle im DOM wieder eingefügt (3)

```javascript
var template = document.querySelector('#mytemplate');             // (1)
var templateClone = document.importNode(template.content, true);  // (2)
document.body.appendChild(templateClone);                         // (3)
```

### Vorteile

- Templates sind ein fertiges Gerüst an HTML
- Templates werden in DOM geladen, aber nicht angezeigt bis sie aktiviert werden
- `<script>` Tags werden nicht ausgeführt, Stylesheets/Bilder nicht geladen, Medien nicht abgespielt, bis das Template benutzt wird
- Es können beliebig viele `<template>` Tags benutzt werden, ohne dass sich die Performance signifikant verschlechtert
- Sie können an beliebiger Stelle im Quelltext stehen, die `display` Eigenschaft muss nicht getoggelt werden und es entsteht kein Overhead an Markup das nicht vom Browser geparst wird
- Sind im Dokument versteckt, man kann nicht in den DOM des `<templates>` traversieren
  z.B. `document.getElementById('#mytemplate') == null`
- Mit JavaScript kann auf das Template zugegriffen werden und es an anderer Stelle dynamisch einbinden
- Es muss mit Javascript kein Code erzeugt werden, man kann ihn einfach aus dem DOM nehmen und wiederbenutzen
- Sind standartisiert (http://www.w3.org/TR/html5/scripting-1.html#the-template-element) (als einzige Technologie des Web Components Technology Stacks)
- Browserunterstüzung gut, bis auf Internet Explorer und Edge

*Hinweis:*
Geschachtelte `<template>` Tags müssen manuell aktiviert werden!

![Bild: Brwoserunterstützung des HTML Template Tags](https://raw.githubusercontent.com/Glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/Templates_Browserunterstuetzung.jpg "Template Tag Browserunterstzützung. Quelle: http://caniuse.com/#search=template")


## Quellen
- O'Reilly Buch "Developing Web Components"
- https://developer.mozilla.org/de/docs/Web/HTML/Element/template
- http://www.html5rocks.com/en/tutorials/webcomponents/template/
- http://webcomponents.org/articles/introduction-to-template-element/
- http://caniuse.com/#search=template
- http://www.webcomponentsshift.com/#13
