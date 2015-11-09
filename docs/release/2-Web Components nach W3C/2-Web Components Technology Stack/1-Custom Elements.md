# Custom Elements

- TODO:

- Ausformulieren:
  - Complete

## Einführung

- Momentan: Suppe von Divs, die nicht aussagekräftig sind, siehe folgender Ausschnitt der Inbox der Google-Mail Webseite
  ![Bild: Webseite mit semantisch nicht aussagekräftigem Markup](https://raw.githubusercontent.com/glur4k/BATHWebComponents/deba05dcaa2d0c1879f4cd65138e80dda8e76006/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/1-Custom-elements_div_suppe.jpg "Webseite mit semantisch nicht aussagekräftigem Markup. Quelle: https://mail.google.com/")
- Besser: Elemente, die semantisch aussagekräftig sind. So könnte die Google-Mail Webseite folgender Maßen aussehen

```html
<hangout-module>
  <hangout-chat from="Paul, Addy">
    <hangout-discussion>
      <hangout-message from="Paul" profile="profile.png"
          profile="118075919496626375791" datetime="2013-07-17T12:02">
        <p>Feelin' this Web Components thing.</p>
        <p>Heard of it?</p>
      </hangout-message>
    </hangout-discussion>
  </hangout-chat>
  <hangout-chat>...</hangout-chat>
</hangout-module>
```

- Custom Elements ermöglichen es
  - neue DOM Elemente zu definieren
  - Elemente zu definieren, die vorhandene Elemente erweitern
  - eigene Funktionalitäten in einem Element zu bündeln
  - die APIs vorhandener DOM Elemente zu erweitern

[Eric Bidelman 2013]


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

[Developing Web Components 2015]


## Vorteile von Custom Elements

- Unangemeldete, unregistrierte Custom Tags wie z.B. `<myelement>` benutzen das Interface HTMLUknownElement
- Angemeldete, registrierte Custom Elements wie z.B. `<my-element>` benutzen das Interface HTMLElement
- Somit können für neue HTML Elemente eigene APIs erzeugt werden, indem eigene Eigenschaften und Methoden hinzugefügt werden

[Eric Bidelman 2015]


### Nachteil

- Eventueller FOUC (Flash of unstyled content), da das Element schon im DOM steht, aber erst noch registriert werden muss
- Kann verhindert werden, in dem man den `:unresolved`-Selector benutzt und die Elemente ausblendet

  ```
  my-element:unresolved {
    display: none;
  }
  ```

[Peter Gasston 2014]

## Vorhandene Elemente erweitern (Type extensions)

- Statt neue Elemente zu erzeugen, können vorhandene auch erweitert werden
- So können native HTML Elemente erweitert werden
- Um einen erweitertes `button` zu erzeugen muss also folgendes gemacht werden:

```javascript
var ButtonExtendedProto = document.registerElement('button-extended', {
  prototype: Object.create(HTMLButtonElement.prototype),
  extends: 'button'
});
```

- Ein erweitertes Element kann nun wie folgt vie JavaScript oder HTML Deklaration verwendet werden:

JavaScript:
```javascript
var buttonExtended  = document.createElement('button', 'button-extended');

// Oder

var buttonExtended = new ButtonExtendedProto();
```

HTML:
```html
  <div class="wrapper">
    <button is="button-extended"></button>
  </div>
```

[Eiji Kitamura 2014]


### Verwendung bei Github

- Die "Latest commit" Angaben eines Repositories auf Github sind ein erweitertes time-Element (Type Extension Custom Element mit time-Element)
- Statt des Commit-Datums und der Zeit, wird - wenn JavaScript aktiviert ist - die berechnete Zeit seit dem letzten Commit angezeigt

![Bild: Github Einsatz eines Custom Element](https://raw.githubusercontent.com/glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/1-Custom-elements_Github_time-element.jpg "Github Einsatz eines Custom Element. Quelle: https://github.com/polymer/polymer - Quelltext")

- Dabei dient das `time` Element als Basis
- Das `datetime` Attribut gibt die absolute Zeit des Commits an
- `is="time-ago"` ist die Erweiterung des `time` Elements
- Der Inhalt des `time` Elements zeigt die relative Zeit an
- Falls der Browser nun keine Custom Elements (mit Polyfill) unterstützt oder JavaScript deaktiviert ist, wird dennoch das "normale" `time` Element mit der absoluten Zeit angezeigt

[Eiji Kitamura 2014]


## Eigenschaften und Methoden definieren

- Custom Elements machen erst so richtig Sinn, wenn man für diese auch eigene Eigenschaften und Methoden definieren kann
- Wie bei nativen HTML Elementen ist dies bei Custom Elements möglich, dies geschieht auf die gleiche Weise

```javascript
// Methode definieren
ButtonExtendedProto.prototype.alert = function () {
  alert('foo');
};

// Eigenschaft definieren
ButtonExtendedProto.prototype.answer = 42;
```

[Developing Web Components 2015]


## Custom Element Life Cycle Callbacks - TODO?

- Custom Elements bieten eine standardisierte API um verschiedene Methoden zu unterschiedlichen Zeitpunkten im "Leben" eines Custom Elements auszuführen. Diese ermöglicht es zu bestimmen, wie und wann ein bestimmter Code des Custom Elements ausgeführt wird.

#### createdCallback

- Wird ausgeführt, wenn eine Instanz des Custom Elements erzeugt wird. Beispiel: `document.createElement('custom-element');`

#### attachedCallback

- Wird ausgeführt, wenn ein Custom Element dem DOM angehängt wird. Beispiel: ` document.body.appendChild();`

#### detachedCallback

- Wird ausgeführt, wenn ein Custom Element aus dem DOM entfernt wird. Beispiel: ` document.body.removeChild();`

#### attributeChangedCallback

- Wird ausgeführt, wenn ein Attribut eines Custom ELements geändert wird. Beispiel: `MyElement.setAttribute();`


### Beispiel mit `button-extended`

Anhand des `button-extended` Beispiels würde dies folgender Maßen funktionieren:
```javascript
var ButtonExtendedProto = Object.create(HTMLElement.prototype);

ButtonExtendedProto.createdCallback = function() {...};
ButtonExtendedProto.attachedCallback = function() {...};

var ButtonExtended = document.registerElement('button-extended', {prototype: ButtonExtendedProto});
```

[Raoul Schaffranek 2014]

## Styling von Custom Elements

- Custom Elements können wie native HTML Elemente gestyled werden

```css
my-element {
  foo: bar;
}
```

- Element-Erweiterungen können per Attribut-Selektor angesprochen werden

```css
[is="button-extended"] {
  foo: bar;
}
```

[Developing Web Components 2015]


## Browserunterstützung

- Noch nicht standardtisiert, sind noch ein Working Draft (http://w3c.github.io/webcomponents/spec/custom/)
- Deshalb bisher auch nur in Chrome und Opera unterstützt

![Bild: Browserunterstützung von Custom Elements](https://raw.githubusercontent.com/glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/1-Custom-elements_browserunterstuetzung.jpg "Custom Elements Browserunterstzützung. Quelle: http://caniuse.com/#feat=custom-elements")

[Can I Use 2015]


## Quellen
- [Developing Web Components 2015] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.127-138
- [Eiji Kitamura 2014] Eiji Kitamura, Introduction to Custom Elements, http://webcomponents.org/articles/introduction-to-custom-elements/
- http://w3c.github.io/webcomponents/spec/custom/
- [Eric Bidelman 2013] Eric Bidelman, Custom Elements, http://www.html5rocks.com/en/tutorials/webcomponents/customelements/
- [Can I Use 2015] Can I Use, http://caniuse.com/#feat=custom-elements
- [Peter Gasstton 2015] Peter Gasstton, A Detailed Introduction To Custom Elements, http://www.smashingmagazine.com/2014/03/introduction-to-custom-elements/
- [Raoul Schaffranek 2014] Raoul Schaffranek, Web Components – eine Einführung, https://blog.selfhtml.org/2014/12/09/web-components-eine-einfuehrung/