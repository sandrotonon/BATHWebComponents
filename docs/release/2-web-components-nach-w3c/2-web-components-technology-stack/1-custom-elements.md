# Custom Elements

Der erste Begriff unter dem Dachbegriff Web Components ist Custom Elements, auf dessen API wird im Folgenden eingegangen.

## Einleitung

Webseiten werden mit sogenannten Elementen, oder auch Tags, aufgebaut. Das Set an verfügbaren Elementen wird vom W3C definiert und standardisiert. Somit ist die Auswahl an den verfügbaren Elementen stark begrenzt und nicht von Entwicklern erweiterbar, sodass diese ihre eigenen, von ihrer Applikation benötigten Elemente, definieren können. Betrachtet man den Quelltext einer Webseite im Internet, wird schnell deutlich, worin das Problem liegt.

  ![Bild: Webseite mit semantisch nicht aussagekräftigem Markup](images/1-custom-elements-div-suppe.jpg "Webseite mit semantisch nicht aussagekräftigem Markup. Quelle: https://mail.google.com/")

Die Webseite der Google Mail Applikation ist stark geschachtelt in `<div>`-Elemente. Diese sind notwendig um der Webseite die gewünschte Funktionalität und Aussehen zu verleihen. Die Probleme dieser Struktur bzw. des DOM sind deutlich: Es ist sehr schwer zu erkennen, welches Element nun was darstellt und welche Funktion hat. Abgesehen von der fehlenden, schnell ersichtlichen Semantik, also der Zuordnung der Bedeutung zu einem Element, ist der gesamte DOM nur schwer wartbar.
Dieser Problematik widmen sich die Custom Elements. Sie bieten eine neue API, welche es ermöglicht eigene, semantisch aussagekräftige, HTML-Elemente sowie deren Eigenschaften und Funktionen zu definieren. Würde das obige Beispiel nun also mit Hilfe von Custom Elements umgesetzt werden, so könnte der zugehörige DOM folgender Maßen aussehen [citeulike:13844982].

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

Die Spezifikation des W3C ermöglicht nicht nur das Erstellen eigener Elemente, sondern auch das Erstellen von eigenen Elementen, die native Elemente erweitern. Somit können die APIs von nativen HTML Elementen um eigene Eigenschaften und Funktionen erweitert werden. Dies ermöglicht es, eigene gewünschte Funktionalitäten in eigens erstellten HTML Elementen zu bündeln.


## Neue Elemente registrieren

Um nun ein eigenes Custom Element zu definieren, muss der Name des Custom Elements, laut der W3C Spezifikation, zwingend einen Bindestrich enthalten, beispielsweise `my-element`. Somit ist gewährleistet, dass der Parser des Browsers die Custom Elements von den nativen Elementen unterscheiden kann [citeulike:13845061].

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

[citeulike:13844979]


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

[citeulike:13752379]


### Verwendung bei Github

- Die "Latest commit" Angaben eines Repositories auf Github sind ein erweitertes time-Element (Type Extension Custom Element mit time-Element)
- Statt des Commit-Datums und der Zeit, wird - wenn JavaScript aktiviert ist - die berechnete Zeit seit dem letzten Commit angezeigt

![Bild: Github Einsatz eines Custom Element](images/1-custom-elements-github-time-element.jpg "Github Einsatz eines Custom Element. Quelle: https://github.com/polymer/polymer - Quelltext")

- Dabei dient das `time` Element als Basis
- Das `datetime` Attribut gibt die absolute Zeit des Commits an
- `is="time-ago"` ist die Erweiterung des `time` Elements
- Der Inhalt des `time` Elements zeigt die relative Zeit an
- Falls der Browser nun keine Custom Elements (mit Polyfill) unterstützt oder JavaScript deaktiviert ist, wird dennoch das "normale" `time` Element mit der absoluten Zeit angezeigt


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

[citeulike:13844979]


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

[citeulike:13844988]

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

[citeulike:13844979]


## Browserunterstützung

- Noch nicht standardtisiert, sind noch ein Working Draft (http://w3c.github.io/webcomponents/spec/custom/)
- Deshalb bisher auch nur in Chrome und Opera unterstützt

![Bild: Browserunterstützung von Custom Elements](images/1-custom-elements-browserunterstuetzung.jpg "Custom Elements Browserunterstzützung. Quelle: http://caniuse.com/#feat=custom-elements")

[citeulike:13844983]


## Quellen

- [citeulike:13844979] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.127-138
- [citeulike:13845061] W3C Custom Elements, http://w3c.github.io/webcomponents/spec/custom/#concepts
- [citeulike:13752379] Eiji Kitamura, Introduction to Custom Elements, http://webcomponents.org/articles/introduction-to-custom-elements/
- http://w3c.github.io/webcomponents/spec/custom/
- [citeulike:13844982] Eric Bidelman, Custom Elements, http://www.html5rocks.com/en/tutorials/webcomponents/customelements/
- [citeulike:13844983] Can I Use, http://caniuse.com/#feat=custom-elements
- [citeulike:13844984] Peter Gasstton, A Detailed Introduction To Custom Elements, http://www.smashingmagazine.com/2014/03/introduction-to-custom-elements/
- [citeulike:13844988] Raoul Schaffranek, Web Components – eine Einführung, https://blog.selfhtml.org/2014/12/09/web-components-eine-einfuehrung/
