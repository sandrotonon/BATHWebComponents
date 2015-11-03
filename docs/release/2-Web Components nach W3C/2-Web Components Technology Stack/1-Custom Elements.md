# Custom Elements

- TODO:
  - Beispiel für Seite mit Div-Suppe
  - Beispiel für bessere Seite

- Ausformulieren:
  - Complete

## Einführung

- Momentan: Suppe von Divs, die nicht aussagekräftig sind (Beispiel so einer Webseite)
- Besser: Elemente, die semantisch aussagekräftig sind (Beispiel wie man es besser machen kann)
  -> Beispiel von http://www.html5rocks.com/en/tutorials/webcomponents/customelements/ verwenden?
- Custom Elements ermöglichen es
  - neue DOM Elemente zu definieren
  - Elemente zu definieren, die vorhandene Elemente erweitern
  - eigene Funktionalitäten in einem Element zu bündeln
  - die APIs vorhandener DOM Elemente zu erweitern


## Neue Elemente registrieren

- Laut W3C Spezifikation muss ein Custom Element ein Bindestrich im Namen haben, z.B. `my-element` (http://w3c.github.io/webcomponents/spec/custom/#concepts)
- Ein neues Element wir mit der Funktion `var MyElement = document.registerElement('my-element');` registriert
- Als zweiter Parameter kann der `prototype` mit angegeben werden
```javascript
var MyElement = document.registerElement('my-element', {
  prototype: Object.create(HTMLElement.prototype)
});
```
- Dadurch steht es in der Registry des Browsers, welche dazu verwendet wird um die Definitionen der Elemente aufzulösen
- Nachdem das Element registriert wurde, kann es per JavaScript oder HTML Deklaration verwendet werden
[Developing Web Components, S.107-138]

JavaScript
```javascript
var myelement = document.createElement('my-element');
document.body.appendChild(myelement);
```

HTML
```html
<div class="wrapper">
  <my-element><my-element>
</div>
```


## Vorteile von Custom Elements

- Unangemeldete, unregistrierte Custom Tags wie z.B. `<myelement>` benutzen das Interface HTMLUknownElement
- Angemeldete, registrierte Custom Elements wie z.B. `<my-element>` benutzen das Interface HTMLElement
- Somit können für neue HTML Elemente eigene APIs erzeugt werden, indem eigene Eigenschaften und Methoden hinzugefügt werden
[Quelle: http://www.html5rocks.com/en/tutorials/webcomponents/customelements/]


### Nachteil

- Eventueller FOUC (Flash of unstyled content), da das Element schon im DOM steht, aber erst noch registriert werden muss
- Kann verhindert werden, in dem man den `:unresolved`-Selector benutzt und die Elemente ausblendet

  ```
  mein-tag:unresolved {
    display: none;
  }
  ```


## Vorhandene Elemente erweitern (Type extensions)

- Statt neue Elemente zu erzeugen, können vorhandene auch erweitert werden
- So können native HTML Elemente erweitert werden
- Um einen erweitertes `button` zu erzeugen muss also folgendes gemacht werden:

```javascript
var ButtonExtended = document.registerElement('button-extended', {
  prototype: Object.create(HTMLButtonElement.prototype),
  extends: 'button'
});
```

- Ein erweitertes Element kann nun wie folgt vie JavaScript oder HTML Deklaration verwendet werden:

JavaScript:
```javascript
var buttonExtended  = document.createElement('button', 'button-extended');

// Oder

var buttonExtended = new ButtonExtended();
```

HTML:
```html
  <div class="wrapper">
    <button is="button-extended"></button>
  </div>
```

[Quelle: http://webcomponents.org/articles/introduction-to-custom-elements/]


### Verwendung bei Github

- Die "Latest commit" Angaben eines Repositories auf Github sind ein erweitertes time-Element (Type Extension Custom Element mit time-Element)
- Statt des Commit-Datums und der Zeit, wird - wenn JavaScript aktiviert ist - die berechnete Zeit seit dem letzten Commit angezeigt

![Bild: Github Einsatz eines Custom Element](https://raw.githubusercontent.com/glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/2-Custom-elements_Github_time-element.jpg "Github Einsatz eines Custom Element. Quelle: https://github.com/polymer/polymer - Quelltext")

- Dabei dient das `time` Element als Basis
- Das `datetime` Attribut gibt die absolute Zeit des Commits an
- `is="time-ago"` ist die Erweiterung des `time` Elements
- Der Inhalt des `time` Elements zeigt die relative Zeit an
- Falls der Browser nun keine Custom Elements (mit Polyfill) unterstützt oder JavaScript deaktiviert ist, wird dennoch das "normale" `time` Element mit der absoluten Zeit angezeigt
[Quelle: http://webcomponents.org/articles/introduction-to-custom-elements/]

## Browserunterstützung

- Noch nicht standardtisiert, sind noch ein Working Draft (http://w3c.github.io/webcomponents/spec/custom/)
- Deshalb bisher auch nur in Chrome und Opera unterstützt

![Bild: Browserunterstützung von Custom Elements](https://raw.githubusercontent.com/glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/2-Custom-elements_browserunterstuetzung.jpg "Custom Elements Browserunterstzützung. Quelle: http://caniuse.com/#feat=custom-elements")


## Quellen
- http://w3c.github.io/webcomponents/spec/custom/
- O'Reilly Buch "Developing Web Components", S.107-138
- http://webcomponents.org/articles/introduction-to-custom-elements/
- http://www.html5rocks.com/en/tutorials/webcomponents/customelements/
- http://www.smashingmagazine.com/2014/03/introduction-to-custom-elements/
