# HTML Templates

- TODO:
  - `<script>`-tag Nachteile
  - Benutzung

## Einführung

- Bisher nur im Backend verfügbar in PHP oder Ruby z.B.
- Kommt jetzt auch in den Browser
- Bisher durch Mustache.js oder AngularJS


## Bisherige templatetisierung im Browser

### Via hidden div-Element

```
<div style="display: none;">
  <div>
    <img src="myimage.jpg">
  </div>
</div>
```

*Nachteil:*
- Resources werden geladen, auch wenn man sie nicht braucht, da sie ja nicht angezeigt werden sollen
- Resourcen und Performance verschwendung


### Via script-Element:

```
<script type="text/template">
  <div>
    <img src="myimage.jpg">
  </div>
</script>
```

*Nachteil:*
- TODO


## `<template>` Tag

```
<template id="mytemplate">
  <img src=""> <!-- dynamically populate at runtime -->
  <div class="text"></div>
</template>
```

### Vorteile

- Fertiges Gerüst an HTML
- Werden in DOM geladen, aber nicht angezeigt
- `<script>` Tags werden nicht ausgeführt, Stylesheets/Bilder nicht geladen, Medien nicht abgespielt
- Sind im Dokument versteckt, man kann nicht in den DOM des `<templates>` traversieren
  z.B. `document.querySelector('#mytemplate .text') == null`
- Mit JavaScript kann auf das Template zugegriffen werden und es an anderer Stelle dynamisch einbinden
- Es muss mit Javascript kein Code erzeugt werden, man kann ihn einfach aus dem DOM nehmen und wiederbenutzen
- Sind standartisiert (http://www.w3.org/TR/html5/scripting-1.html#the-template-element) (als einzige Technologie des Web Components Technology Stacks)
- Browserunterstüzung gut, bis auf Internet Explorer und Edge

![Bild: Brwoserunterstützung des HTML Template Tags](https://raw.githubusercontent.com/Glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/Templates_Browserunterstuetzung.jpg "Template Tag Browserunterstzützung. Quelle: http://caniuse.com/#search=template")

### Benutzung


## Quellen
- O'Reilly Buch "Developing Web Components"
- https://developer.mozilla.org/de/docs/Web/HTML/Element/template
- http://www.html5rocks.com/en/tutorials/webcomponents/template/
- http://webcomponents.org/articles/introduction-to-template-element/
- http://caniuse.com/#search=template
- http://www.webcomponentsshift.com/#13
