## Custom Elements

Webseiten werden mit sogenannten Elementen, oder auch Tags, aufgebaut. Das Set an verfügbaren Elementen wird vom W3C definiert und standardisiert. Somit ist die Auswahl an den verfügbaren Elementen stark begrenzt und nicht von Entwicklern erweiterbar, sodass diese ihre eigenen, von ihrer Applikation benötigten Elemente, definieren können. Betrachtet man den Quelltext einer Webseite im Internet, wird schnell deutlich, worin das Problem liegt.

![Bild: Webseite mit semantisch nicht aussagekräftigem Markup](images/2-custom-elements-div-suppe.jpg "Webseite mit semantisch nicht aussagekräftigem Markup. Quelle: https://mail.google.com/")

Die Webseite der Google Mail Applikation ist stark geschachtelt in `<div>`-Elemente. Diese sind notwendig, um der Webseite die gewünschte Funktionalität und Aussehen zu verleihen. Die Probleme dieser Struktur bzw. des DOMs sind deutlich: Es ist sehr schwer zu erkennen, welches Element nun was darstellt und welche Funktion hat. Abgesehen von der fehlenden schnell ersichtlichen Semantik - also der Zuordnung der Bedeutung zu einem Element - ist das gesamte DOM nur schwer wartbar.
Dieser Problematik widmen sich die Custom Elements. Sie bieten eine neue API, welche es ermöglicht, eigene, semantisch aussagekräftige HTML-Elemente sowie deren Eigenschaften und Funktionen zu definieren. Würde das obige Beispiel nun also mit Hilfe von Custom Elements umgesetzt werden, so könnte der zugehörige DOM folgendermaßen aussehen [citeulike:13844982].

```html
<hangout-module>
  <hangout-chat from="Paul, Addy">
    <hangout-discussion>
      <hangout-message from="Paul" profile="profile.png"
          profile="118075919496626375791" datetime="2013-07-17T12:02">
        <p>Hier werden Web Components eingesetzt.</p>
      </hangout-message>
    </hangout-discussion>
  </hangout-chat>
  <hangout-chat>...</hangout-chat>
</hangout-module>
```

Die Spezifikation des W3C ermöglicht nicht nur das Erstellen eigenständiger Elemente, sondern auch das Erstellen von Elementen, welche native Elemente erweitern. Somit können die APIs von nativen HTML-Elementen um eigene Eigenschaften und Funktionen erweitert werden. Dies ermöglicht es, gewünschte Funktionalitäten in selbsterstellten HTML-Elementen zu bündeln.


### Neue Elemente registrieren

Um nun ein eigenes Custom Element zu definieren, muss der Name des Custom Elements laut der W3C Spezifikation zwingend einen Bindestrich enthalten, beispielsweise `my-element`. Somit ist gewährleistet, dass der Parser des Browsers die Custom Elements von den nativen Elementen unterscheiden kann [citeulike:13845061]. Ein neues Element wird mittels JavaScript mit der Funktion `var MyElement = document.registerElement('my-element');` registriert. Zusätzlich zum Namen des Elements kann optional der Prototyp des Elements angegeben werden. Dieser ist jedoch standardmäßig ein `HTMLElement`, somit also erst wichtig, wenn es darum geht, vorhandene Elemente zu erweitern, auf dieses Thema wird jedoch in Abschnitt 2.2.4 gesondert eingegangen. Durch das Registrieren des Elements wird es in die Registry des Browsers geschrieben, welche dazu verwendet wird, die Definitionen der HTML-Elemente aufzulösen. Nachdem das Element registriert wurde, muss es zunächst mittels `document.createElement(tagName)` erzeugt werden, der `tagName` ist hierbei der Name des zuvor registrierten Elements. Danach kann es per JavaScript oder HTML-Deklaration im Dokument verwendet werden [citeulike:13844979].

Einbinden mit JavaScript:
```javascript
  document.body.appendChild(myelement);
```

Einbinden mit HTML:
```html
<div class="some-html">
  <my-element><my-element>
</div>
```


### Vorteile von Custom Elements

Ist ein Element noch nicht definiert und nicht beim Browser registriert, steht aber im Markup der Webseite, beispielsweise `<myelement>`, wird dies kein Fehler verursachen, da dieses Element das Interface von `HTMLUnkownElement` benutzen muss [citeulike:13851253]. Ist es jedoch definiert oder beim Browser registriert worden, beispielsweise mit `<my-element>`, so benutzt es das Interface eines `HTMLElement`. Dies bedeutet, dass für dieses Element eigene APIs erzeugt werden können, indem eigene Eigenschaften und Methoden hinzugefügt werden [citeulike:13844982]. Eigene Elemente mit einem spezifischen Eigenverhalten und Aussehen, wie beispielsweise ein neuer Video-Player, sind dadurch mit einem Tag statt mit einem Gerüst aus `<div>`-Tags oder Ähnlichem umsetzbar.


### Nachteil

Ein Custom Element, welches zwar standardkonform deklariert oder erstellt, aber noch nicht beim Browser registriert wurde, ist ein "Unresolved Element". Steht dieses Element am Anfang des DOM, wird jedoch erst später registriert, kann es nicht von CSS angesprochen werden. Dadurch kann ein FOUC entstehen, was bedeutet, dass das Element beim Laden der Seite nicht gestylt dargestellt wird, sondern das definierte Aussehen erst übernimmt, nachdem es registriert wurde. Um dies zu verhindern, sieht die HTML-Spezifikation eine neue CSS-Pseudoklasse `:unresolved` vor, welche deklarierte, aber nicht registrierte Elemente anspricht. Somit können diese Elemente initial beim Laden der Seite ausgeblendet und nach dem Registrieren wieder eingeblendet werden. Dadurch wird ein ungewolltes Anzeigen von ungestylten Inhalten verhindert [citeulike:13844984].

```html
my-element:unresolved {
  display: none;
}
```


### Vorhandene Elemente erweitern (Type Extension)

Statt neue Elemente zu erzeugen können sowohl native HTML-Elemente als auch bereits erstellte Custom Elements durch prototypische Vererbung um Funktionen und Eigenschaften erweitert werden, was auch als "Type Extension" bezeichnet wird. Zusätzlich zum Namen des erweiterten Elements wird nun der Prototyp sowie der Name des zu erweiternden Elements der `registerElement`-Funktion als Parameter übergeben. Soll also ein erweitertes `button`-Element erzeugt werden, muss Folgendes gemacht werden:

```javascript
var ButtonExtendedProto = document.registerElement('button-extended', {
  prototype: Object.create(HTMLButtonElement.prototype),
  extends: 'button'
});
```

Das registrierte, erweiterte Element kann nun mit dem Namen des zu erweiternden Elements als erstem Parameter und dem Namen des erweiterten Elements als zweitem Parameter erzeugt werden. Alternativ kann es auch mit Hilfe des Konstruktors erzeugt werden [citeulike:13752379].

JavaScript:
```javascript
var buttonExtended  = document.createElement('button', 'button-extended');

// Alternativ
var buttonExtended = new ButtonExtendedProto();
```

Um es nun im DOM zu benutzen, muss der Name des erweiterten Elements via dem Attribut `is="elementName"` des erweiternden Elements angegeben werden.

HTML:
```html
<div class="wrapper">
  <button is="button-extended"></button>
</div>
```


**Verwendung bei Github**

Eine Umsetzung der Type extensions ist auf der Webseite von GitHub zu finden. Dort werden die "Latest commit" Angaben eines Repositories als ein erweitertes time-Element dargestellt. Statt des Commit-Datums und der Zeit, wird die berechnete Zeit seit dem letzten Commit angezeigt.

![Bild: Github Einsatz eines Custom Element](images/2-custom-elements-github-time-element.jpg "Github Einsatz eines Custom Element. Quelle: https://github.com/polymer/polymer - Quelltext")

GitHub verwendet hierzu ein selbst erzeugtes `time-ago`-Element, welches eine Type extension auf Basis des `time`-Elements umsetzt. Mittels dem `datetime`-Attribut wird die absolute Zeit des Commits an das interne JavaScript weitergegeben. Als Inhalt des `time`-Elements wird dann die mit JavaScript berechnete relative Zeit ausgegeben. Falls der Browser nun keine Custom Elements unterstützt oder JavaScript deaktiviert ist, wird dennoch das nicht erweiterte, native HTML `time` Element mit der absoluten Zeit angezeigt.


### Eigenschaften und Methoden definieren

Anhand des Beispiels auf GitHub wird deutlich, wie ein Custom Element eingesetzt werden kann, jedoch sind die internen JavaScript Mechanismen nicht ersichtlich. Custom Elements entfalten ihr vollständiges Potential jedoch erst, wenn man für diese auch eigene Eigenschaften und Methoden definiert. Wie bei nativen HTML-Elementen ist das auch bei Custom Elements auf analoge Weise möglich [citeulike:13844979]. So kann einem Element eine Funktion zugewiesen werden, in dem diese dessen Prototyp mittels einem nicht reservierten Namen angegeben wird. Selbiges gilt für eine neue Eigenschaft. Die Eigenschaften können, nachdem sie im Prototyp definiert wurden, im HTML-Markup deklarativ konfiguriert werden.

```html
<script>
// Methode definieren
ButtonExtendedProto.alert = function () {
  alert('foo');
};

// Eigenschaft definieren
ButtonExtendedProto.answer = 42;
</script>

<!-- Beispiel einer deklarativen Konfiguration -->
<button-extended answer="41">Ich bin ein Button</button-extended>
```


### Custom Element Lifecycle-Callbacks

Custom Elements bieten eine standardisierte API an speziellen Methoden, den "Custom Element Lifecycle-Callbacks", welche es ermöglichen Funktionen zu unterschiedlichen Zeitpunkten - vom Registrieren bis zum Löschen eines Custom Elements - auszuführen. Diese ermöglichen es, zu bestimmen, wann und wie ein bestimmter Code des Custom Elements ausgeführt werden soll.

**createdCallback**

Die `createdCallback`-Funktion Wird ausgeführt, wenn eine Instanz des Custom Elements mittels `var mybutton = document.createElement('custom-element')` erzeugt wurde.

**attachedCallback**

Die `attachedCallback`-Funktion wird ausgeführt, wenn ein Custom Element dem DOM mittels `document.body.appendChild(mybutton)` angehängt wurde.

**detachedCallback**

Die `detachedCallback`-Funktion wird ausgeführt, wenn ein Custom Element aus dem DOM mittels `document.body.removeChild(mybutton)` entfernt wurde.

**attributeChangedCallback**

Die `attributeChangedCallback`-Funktion wird ausgeführt, wenn ein Attribut eines Custom Elements mittels `MyElement.setAttribute()` geändert wurde.

So können die Lifecycle-Callbacks für ein neues erweitertes Button-Element  wie folgt definiert werden [citeulike:13844988].

```javascript
var ButtonExtendedProto = Object.create(HTMLElement.prototype);

ButtonExtendedProto.createdCallback = function() {...};
ButtonExtendedProto.attachedCallback = function() {...};

var ButtonExtended = document.registerElement('button-extended', {prototype: ButtonExtendedProto});
```


### Styling von Custom Elements

Das Styling von eigenen Custom Elements funktioniert analog dem Styling von nativen HTML-Elementen indem der Name des Elements als CSS Selektor angegeben wird. Erweiterte Elemente können mittels dem Attribut-Selektor in CSS angesprochen werden [citeulike:13844979].

```css
/* Eigenes Custom Element */
my-element {
  color: black;
}

/* Erweitertes natives HTML-Element*/
[is="button-extended"] {
  color: black;
}
```


### Browserunterstützung

Custom Elements sind noch nicht vom W3C standardisiert, sondern befinden sich noch im Status eines "Working Draft" [citeulike:13845061]. Sie werden deshalb bisher nur von Google Chrome ab Version 43 und Opera ab Version 33 nativ unterstützt.

![Bild: Browserunterstützung von Custom Elements](images/2-custom-elements-browserunterstuetzung.jpg "Custom Elements Browserunterstützung [citeulike:13844983]")
