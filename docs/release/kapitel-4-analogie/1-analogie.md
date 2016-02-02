# Analogie zu nativen Web Components

- TODO:
    + (siehe Abschnitt X)

In erster Linie vereinfacht Polymer das Erstellen und den Umgang mit Custom Elements, wobei versucht wird die von den Web Components Standards definierten Prämissen einzuhalten und zu erweitern. Ebenso wie bei bei dem nativen Erzeugen einer eigenen Komponente, werden bei Polymer für jede Komponente einzelne HTML-Dateien erstellt, welche die Elemente repräsentieren. Darin werden alle JavaScript-, CSS- und HTML-Strukturen gesammelt und gekapselt. Man distanziert sich somit von der Code-Trennung, stattdessen werden alle Element-spezifischen Inhalte in einer Datei gebündelt. Wie das funktioniert und wie die Technologien mit Polymer umgesetzt werden, wird in diesem Kapitel dargestellt. In Abschnitt 4.1 werden dabei die Custom Elements erläutert, in Abschnitt 4.2 der Shadow DOM zusammen mit den Templates und in Abschnitt 4.3 schließlich die HTML Imports.


## Custom Elements

Die Intention der Polymer Library ist das erstellen eigener Komponenten oder Elementen, den Custom Elements. Das Erstellen, Erweitern und Verwalten von Custom Elements kann mit den nativen Mitteln bei steigender Komplexität mitunter schwierig werden. Polymer stellt hierfür eine Reihe an hilfreicher Funktionen bereit, die das Arbeiten mit den Web Components Standards erleichtern und erweitern sollen [citeulike:13915080].


### Neues Element registrieren

Für das registrieren eines neuen Elements stellt Polymer die Funktion `Polymer(prototype);` bereit, darin werden die generellen Polymer Einstellungen in Form eines Prototyp-Objektes vorgenommen. Um ein Element zu definieren, muss der zu übergebende Prototyp die Eigenschaft `is: 'element-name'` haben, welche den HTML-Tag-Name des zu erstellenden Custom Elements angibt (in diesem Fall `element-name`). Der Name muss dabei als String übergeben werden und ebenso wie beim nativen Erzeugen eines Custom Elements, ein Bindestrich enthalten. Die Polymer Funktion registriert beim Aufruf automatisch das neue Element und gibt einen Konstruktor zurück, mit dem das Element instanziiert werden kann. Dies geschieht imperativ und deklarativ analog zu dem Erstellen und Anhängen der nativen Methode mit `var element = document.createElement('element-name');` bzw. mit dem zurückgegebenen Konstruktor oder im HTML-Markup mit dem erstellten HTML-Tag `<element-name></element-name>`. Soll statt dem standardmäßig erstellten Konstruktor ein Konstruktor erstellt werden, dem Argumente übergeben werden können, so muss in dem Prototyp die Methode `factoryImpl` mit den entsprechenden Argumenten definiert werden. Diese löst nach dem Ausführen einen `factoryImpl`-Callback (siehe Abschnitt X) aus. Die `factoryImpl`-Methode wird allerdings nur aufgerufen, wenn ein Element mit dem zurückgegebenen Konstruktor, nicht jedoch beim Verwenden der `document.createElement`-Methode oder durch HTML-Markup erzeugt wird.


### Elemente erweitern

Ebenso wie nativ erzeugt Custom Elements können auch mit Polymer erzeugte Elemente die nativen Elemente erweitern, was unter Polymer ein "type extension custom element" genannt wird. Jedoch kann ein Polymer Element nur native Elemente erweitern, andere Polymer Elemente hingegen noch nicht. Dies soll allerdings in einer zukünftigen Version möglich sein. Das Erweitern und Erzeugen eines "type extension custom element" funktioniert mit Polymer analog zu der nativen Methode. Hierzu muss im Prototyp die Eigenschaft `extends: 'HTMLElement'` gesetzt werden, wobei das `'HTMLElement'` ein natives HTML-Element wie z.B. `input` oder `button` sein muss. Zum Erzeugen des Elements kann nun wieder entweder die imperative Methode (siehe Abschnitt 4.1.1) oder die deklarative Methode analog dem nativen Erstellen mit `<HTMLElement is="my-HTMLElement">` mittels dem `is` Attribut, gewählt werden.


### Declared Properties - Eigenschaften und Methoden definieren

Custom Elements können auch mit Hilfe von Polymer um Eigenschaften und Methoden erweitert werden. Hierzu bietet Polymer das `properties`-Objekt an, mit welchem die Eigenschaften der Komponente im JSON Format definiert werden können. Im Gegensatz zu den nativen Methoden muss somit nicht jede Eigenschaft bzw. Property einzeln hinzugefügt werden. Die in diesem Objekt definierten Properties, können beim Verwenden der Komponente im HTML-Markup konfiguriert werden. Dadurch ist es möglich eine API für das Element zu erstellen, da die von Außen konfigurierbaren Attribute ein Interface der Komponente bilden. Eine Property kann dabei mit folgenden Parametern spezifiziert werden.

- `type`: Konstruktor-Typ der Property, er kann ein Boolean, Date, Number, String, Array oder Object sein.
- `value`: Standardwert der Property, der Wert muss boolean, number, string oder eine Funktion sein.
- `reflectToAttribute`: Boolean-Wert, gibt an ob die Property mit dem HTML-Attribut synchronisiert werden soll. Das bedeutet, dass falls die Property geändert wird, das zugehörige HTML Attribut des Elements geändert wird, was äquivalent zu `this.setAttribute(property, value);` ist. Der Name des HTML-Attributs muss dabei in dem Properties-Objekt kleingeschrieben werden. Enthält der Name zusätzlich Bindestriche, so muss die Property kleingeschrieben und die Bindestriche entfernt werden, wobei jedes Wort nach einem Bindestrich groß geschrieben werden muss.
- `readOnly`: Boolean-Wert, gibt an ob die Property nur gelesen oder auch geschrieben werden soll (siehe Abschnitt 5.1).
- `notify`: Boolean-Wert, die Property ist für Two-Way Data Binding verfügbar, falls true gesetzt ist. Zusätzlich wird ein `property-name-changed` Event ausgelöst, wenn sich die Property ändert.
- `computed`: Name der Funktion als String, welche den Wert der Property berechnen soll (siehe Abschnitt 4.1.4).
- `observer`: Name der Funktion als String, welche aufgerufen wird, wenn der Wert der Property geändert wird (siehe Abschnitt 4.1.5).

Die genannten Parameter sind alle optional anzugeben. Wird keine der Parameter definiert, so kann die Property direkt mit dem `type` definiert werden. Soll also beispielsweise eine Property `propertyName` als String und ohne Parameter angegeben werden, so würde dies mit `properties: { propertyName: String }` erreicht werden.


### Computed Properties

Polymer unterstützt des Weiteren zusammengesetzte, virtuelle Properties, welche aus anderen Properties berechnet werden. Um dies zu erreichen, muss die dafür verwendete Funktion im `properties`-Objekt mit entsprechenden Parametern angegeben werden. Soll beispielsweise die virtuelle Property `result` die Zusammensetzung der Properties a und b darstellen, so wird sie als `result: { type: String, computed: computeResult(a, b) }` im `properties` Objekt angegeben. Die entsprechende Funktion muss dann als `computeResult: function(a, b) { ... }` im Polymer-Prototyp definiert werden. Diese wird einmalig aufgerufen, wenn sich eine der Eigenschaften a oder b ändert und wenn keine von beiden undefiniert ist. Der von ihr zurückgegebene Wert wird anschließend in der Variable `result` gespeichert.


### Property Oberserver

Wird für eine Property der Parameter `observer` angegeben, so wird sie auf Änderungen überwacht. Die angegebene Funktion, welcher als optionale Argumente den neuen und den alten Wert übergeben werden, wird somit aufgerufen, falls der Wert der Property geändert wird. Allerdings kann in dem `properties`-Objekt jeweils nur eine Property von einem Observer überwacht werden. Sollen mehrere Properties von dem selben Observer überwacht werden, kann das `observers`-Array des Polymer-Prototyps verwendet werden. Soll  beispielsweise die Funktion `computeResult(a, b)` ausgeführt werden, sobald sich eine der Properties `a` oder `b` ändert, so kann diese Funktion in das Array übernommen werden. Jedoch wird die Funktion auch hier nur dann ausgeführt, wenn keiner der Werte undefiniert ist. Des Weiteren wird bei angegebenen Funktionen, im Gegensatz zu den in dem `properties`-Objekt angegebenen Observern, nur der neue Wert, statt der neue und der alte Wert übergeben. Mit dem `observers`-Array ist es auch möglich Sub-Properties oder Arrays zu überwachen.


### Das hostAttributes-Objekt

Zusätzlich zu den Declared Properties können auch HTML-Element-Attribute im Polymer Prototyp definiert werden. Hierzu bietet Polymer das `hostAttributes`-Objekt an. Die darin angegebenen Schlüssel-Wert-Paare werden beim initialen Erstellen des Elements auf dessen Attribute abgebildet. Das `hostAttributes`-Objekt kann dabei alle HTML-Attribute, bis auf das `class`-Attribut definieren, darunter fallen beispielsweise die Attribute `data-*`, `aria-*` oder `href`. Wird im `hostAttributes`-Objekt beispielsweise das Attrbiut `selected` mit `true` definiert, wird es bei einem `my-element` Element in Form von `<my-element selected>Item</my-element>` ausgegeben. Wichtig ist hier die Serialisierung der Schlüssel-Wert-Paare. Wird ein String, Dates oder Numbers als Wert übergeben, so werden diese als String serialisiert, werden jedoch Arrays oder Objekte übergeben, so werden diese mittels JSON.stringify serialisiert. Boolean-Werte werden bei `false` entfernt und bei `true` angezeigt. Um Daten in der anderen Richtung von einem HTML-Element an das `hostAttributes`-Objekt zu propagieren, muss auf eine alternative Syntax zugegriffen werden (siehe Abschnitt 5.1.3).


### Lifecycle-Callback-Funktionen

Die nativen Lifecycle-Callback-Funktionen (siehe Abschnitt 2.2.6) werden ebenso von Polymer unterstützt. Diese können in dem Prototyp als Attribut bei ihrem normalen Namen oder in verkürzter Form angegeben werden, so heißt die `createdCallback`-Methode `created`, die `attachedCallback`-Methode heißt `attached` etc.. Soll beispielsweise die `created`-Methode definiert werden, so kann diese mit `created: function { ... }` in dem Prototyp angegeben werden. Zusätzlich bietet Polymer einen `readyCallback`, welcher aufgerufen wird, nachdem Polymer das Element erstellt und den lokalen DOM initialisiert hat, also nachdem alle im lokalen DOM befindlichen Elemente konfiguriert wurden und jeweils ihre `ready`-Methode aufgerufen haben. Sie ist besonders hilfreich, wenn nach dem Laden der Komponente dessen DOM nachträglich manipuliert werden soll. Falls mit den Lifecycle-Callbacks gearbeitet wird, muss auf die richtige Anwendung der Reihenfolge geachtet werden. So werden die Callbacks eines Elements in der Reihenfolge `created`, `ready`, `factoryImpl` und `attached` ausgeführt.


## Shadow DOM und HTML Templates

Die bisher gezeigten Methoden ermöglichen das Erstellen einer Polymer Komponente die jedoch noch kein internes Markup beinhalten. Wie bei den nativen Technologien, können auch mit Polymer erzeugte Custom Elements um HTML-Markup, den lokalen DOM, erweitert werden [citeulike:13915080]. Hierzu dient das Polymer `<dom-module>`-Element, welches als ID den Wert der `is`-Property des Polymer-Prototyps haben muss. Der zu verwendende HTML-Markup muss dann in einem `<template>`-Tag dem `<dom-module>` hinzugefügt werden. Auf das Klonen des Inhalts des Templates mittels der `importNode`-Funktion (siehe Abschnitt 2.4.3) kann hierbei verzichtet werden, da Polymer diesen automatisch in den lokalen DOM des Elements klont. Soll also der lokale DOM des `<element-name>`-Tags deklariert werden, so wird dies wie folgt erreicht:

```html
<dom-module id="element-name">
  <template>Local DOM / Inner HTML markup</template>

  <script>
    Polymer({
      is: 'element-name'
    });
  </script>
</dom-module>
```

Der deklarative Teil des Elements, das `<dom-module>` und dessen Inhalte, sowie der Imperative Teil mit dem `Polymer({ ... })` Aufruf können entweder in der selben oder in getrennten HTML-Dateien stehen. Hierbei spielt es jedoch keine Rolle ob das `<script`-Tag innerhalb oder außerhalb des `<dom-module>`-Tags steht, solange das Template vor dem Polymer-Funktionsaufruf geparst wird.


### Shady DOM

Wie in Kapitel 2.3.9 gezeigt, wird der Shadow DOM nicht von allen Browsern unterstützt, ebenso ist der Polyfill für diesen, aufgrund dessen schlechter Performanz (siehe Kapitel 2.7.4), nur als aller letzte Instanz zu sehen. Aus diesen Gründen ist in Polymer der sogenannte "Shady DOM" implementiert [citeulike:13886251]. Dieser bietet einen Shadow DOM ähnlichen Scope für den DOM Tree, dabei rendert er den DOM als wenn kein Shadow DOM in dem Element vorhanden wäre. Dies bringt wiederum auch die dadurch entstehenden Nachteile mit sich, wie dass internes Markup nach Außen sichtbar ist oder keine Shadow Boundary verfügbar ist. Der Vorteil ist jedoch, dass der Shady DOM genug Methoden für seinen Scope bereitstellt um sich wie ein Shadow DOM verhalten zu können ohne die Performanz zu mindern. Hierzu ist es jedoch zwingend notwendig die eigens entwickelte Shady DOM API im Umgang mit dem DOM zu benutzen, was mit der `Polymer.dom(node)`-Funktion erreicht wird. Will man beispielsweise alle Kinder mit der `children`-Eigenschaft des Shadow Host Elements `<my-element>` selektieren, so erfolgt dies mit der Shady DOM API mittels `var children = Polymer.dom(my-element).children;` statt mit der normalen DOM API mittels `var children =  document.getElementsByTagName("my-element")[0].children;`. Diese gibt dann nur die von außen übergebenen (Light DOM) Elemente zurück, ohne die Elemente des internen Markups des Templates zu berücksichtigen. Die Shady DOM API bildet dabei alle Funktionen der nativen DOM API ab und ist performanter als der Shadow DOM Polyfill, da nicht dessen Verhalten, sondern nur ein eigener DOM Scope implementiert ist. Jedoch beschränkt sich Polymer nicht nur auf den eigenen Shady DOM, vielmehr ist er mit dem nativen Shadow DOM kompatibel, sodass die Shady DOM API auf den nativen Shadow DOM zugreifen kann, falls dieser von dem Browser unterstützt wird. Dadurch kann eine Applikation implementiert werden, die auf allen Plattformen mit einer verbesserten Performanz ausgeführt wird, wovon besonders die mobilen Plattformen profitieren. Standardmäßig benutzt Polymer jedoch immer die eigene Shady DOM API, wie das verhindert werden kann ist in Abschnitt 6.1.2 dargestellt.


### DOM Knoten automatisch finden

Um Das traversieren in dem lokalen DOM zu beschleunigen, bietet Polymer eine Hilfsfunktion für das automatisches Finden eines Elements oder auch "Automatic node finding" an. Hierzu wird intern ein Mapping zu den statisch erzeugten DOM-Elementen erzeugt in dem jedes Element des lokalen DOM-Templates, für welches eine ID definiert wurde, in dem `this.$`-Hash gespeichert wird. Hat nun also das Element `<div id="wrapper"></div>` in dem Template die ID `wrapper`, so kann es in Polymer mittels `this.$.wrapper` selektiert werden. Jedoch werden dem Hash nur die statisch erzeugten DOM-Knoten hinzugefügt, dynamisch mittels `dom-repeat` oder `dom-if` hinzugefügte Knoten allerdings nicht. Die dynamisch hinzugefügten Knoten können mit der `this.$$`-Funktion selektiert werden. So liefert die Funktion `this.$$(selector);` das erste Element mit der ID `selector` des Templates.


### Content Projection

Um nun Elemente des Light DOMs in den lokalen DOM der Komponente zu injizieren, bietet Polymer ebenso das von den nativen Methoden bekannte `<content>`-Element an, welches einen Insertion Point des Light DOM im lokalen DOM der Komponente darstellt. Wie auch bei den nativen Insertion Points, kann das `<content>`-Element auch nur selektierte Inhalte injizieren, in dem das `select`-Attribut mit einem entsprechenden Selektor gesetzt wird. Falls der Shadow DOM in Polymer verfügbar ist, so wird eine Zusammenstellung des Shadow DOM und dem Light DOM gerendert. Ist der Shadow DOM jedoch nicht verfügbar und der Shady DOM wird verwendet, so ist der zusammengesetzte DOM der tatsächliche DOM des Elements. Auch kann in Polymer mittels der `_observer`-Eigenschaft überwacht werden, ob Kind-Elemente der Komponente hinzugefügt oder von ihr entfernt werden. Dazu wird dieser die Funktion `observeNodes(callback)` zugewiesen, welche ausgeführt wird, wenn Elemente hinzugefügt oder entfernt werden. Der Parameter `callback` ist dabei eine anonyme Funktion, welche als Übergabewert das Objekt `info` hat, in welchem die hinzugefügten oder entfernten Knoten enthalten sind. Eine Implementierung der Überwachung des `contentNode`-Knotens auf Änderungen könnte dabei wie folgt aussehen:

```javascript
this._observer = Polymer.dom(this.$.contentNode).observeNodes(function(info) {
  this.processNewNodes(info.addedNodes);
  this.processRemovedNodes(info.removedNodes);
});
```


### CSS Styling

Die in Abschnitt 2.3.5 gezeigten Regeln für das Stylen des Shadow DOM sind auch unter Polymer und dessen Shady DOM gültig [citeulike:13915080]. Zusätzlich können Komponenten CSS Properties (also Variablen) nach Außen sichtbar machen, damit diese von außerhalb der Komponente gesetzt werden können um somit das CSS in einer gekapselten Komponente zu bestimmen. Hierbei können auch Standardangaben gemacht werden, die von der Komponente übernommen werden, wenn die Variable nicht definiert wird. Um eine Variable bereitzustellen muss diese der entsprechenden Eigenschaft mit der Syntax `var(--variable-name, default)` in den Style-Regeln der Komponente angegeben werden. Das folgende Beispiel zeigt den DOM eines `x-element`, welches die CSS-Variable `x-element-button-color` und dem zugewiesenen Standardwert `red` für einen Button in einem `<div>`-Tag mit der Klasse `x-element-container` bereitstellt.

x-element Komponente
```html
<dom-module id="x-element">
  <template>
    <style>
      .x-element-container > button {
        color: var(--x-element-button-color, red);
      }
    </style>
    <div class="x-element-container">
      <button>Click me</button>
    </div>
  </template>
</dom-module>
```

Die Applikation, welche die Komponente benutzt kann nun die Variable `--x-element-button-color` definieren, wie nachfolgend gezeigt wird.

```html
<style is="custom-style">
  x-element {
    --x-element-button-color: green;
  }
</style>
```

Das Attribut `is="custom-style"` des `<style>`-Tag dient dabei als Anweisung für den Polyfill, da CSS Properties noch nicht von allen Browsern unterstützt werden. Nun soll jedoch nicht für jedes CSS-Attribut eine Variable angelegt werden, da dies schnell unübersichtlich werden kann. Um mehrere CSS-Attribute einer Komponente ändern zu können, können sogenannte Mixins erstellt werden. Diese sind eine Sammlung an Styles, die auf eine Komponente angewendet werden können. Sie werden wie eine CSS-Variable definiert, mit dem Unterschied, dass der Wert ein Objekt ist welches ein oder mehrere Regeln definiert. Um ein Mixin nach Außen bereit zu stellen muss es in der Komponente in den CSS-Regeln mit `@apply(--mixin-name)` bereitgestellt werden. Es kann dann von der verwendenden Applikation verwendet werden. So kann das obige Beispiel um das `--x-element` Mixin erweitert werden:

```html
<dom-module id="x-element">
  <template>
    <style>
      .x-element-container > button {
        color: var(--x-element-button-color, red);
        @apply(--x-element);
      }
    </style> 
  </template>
</dom-module>
```

Wobei es wie folgt von der einsetzenden Applikation verwendet werden könnte.

```html
<style is="custom-style">
  x-element {
    --x-element-button-color: green;
    --x-element: {
        padding: 10px;
        margin: 10px;
    };
  }
</style>
```


## Gemeinsame Styles mehrerer Komponenten

Um nun Style-Regeln auf mehrere Komponenten anzuwenden, stellt Polymer die sogenannten "Style Modules" bereit. Diese ersetzen die ab Version 1.1 nicht mehr unterstützte Möglichkeit externe Stylesheets zu verwenden. Style Modules sind dabei nichts anderes als Komponenten, welche von allen Komponenten importiert werden können, die diese Styles anwenden sollen.


### Style Module anlegen

Um eine Komponente mit geteiltes Style-Regeln zu erstellen genügt es, dass diese die Style-Regeln in einem `<dom-module>`-Tag mit einer beliebigen ID definiert. Dies wird in dem folgenden Beispiel der Datei "shared-styles.html" gezeigt. Darin wird eine Style-Regeln definiert, die den Text aller Elemente mit der Klasse `wrapper` Rot anzeigen lässt.

```html
<dom-module id="shared-styles">
  <template>
    <style>
      .wrapper { color: red; }
    </style> 
  </template>
</dom-module>
```


### Style Module benutzen

Damit eine Komponente diese Styles nutzen kann, muss sie sie zunächst importieren und anschließend einen `<style>`-Tag definieren, welcher als `include`-Attribut den Namen der Komponente mit den geteilten Style-Regeln hat. Die Styles werden darin importiert und auf die gesamte Komponente angewendet. Somit wird der Text des `<div>`-Tags mit der Klasse `wrapper` rot dargestellt.

```html
<link rel="import" href="shared-styles.html">
<dom-module id="x-element">
  <template>
    <style include="shared-styles"></style>
    <div class="wrapper">Wrapper with red text</div>
  </template>
  <script>Polymer({is: 'x-element'});</script>
</dom-module>
```


## HTML Imports

Um mehrere Polymer Komponenten oder Komponenten innerhalb anderer Komponenten zu benutzen, verwendet Polymer HTML Imports. Diese funktionieren analog zu der Verwendung mit der nativen HTML Imports Technologie (siehe Abschnitt 2.5 - HTML Imports), wobei die selben Vor- und Nachteile auftreten. Polymer kümmert sich dabei lediglich automatisch im Hintergrund um die korrekte Einbindung der HTML-Dateien und dessen Bereitstellung im Dokument, falls ein `<link rel="import">` in einer Komponente enthalten ist. Das manuelle Einbinden mittels der speziellen JavaScript Methoden oder Eigenschaften, wie beispielsweise der `import`-Eigenschaft des importierten Elements, wird somit hinfällig.


### Dynamisches Nachladen von HTML

Falls HTML-Dateien dynamisch zur Laufzeit nachgeladen werden sollen, bietet Polymer zusätzlich eine Hilfsfunktion an, mit der HTML Imports nachträglich ausgeführt werden können [citeulike:13914840]. Die hierfür bereitgestellte Funktion `importHref(url, onload, onerror);` importiert beim Aufruf dynamisch die angegebene HTML-Datei in das Dokument. Sie erstellt dabei ein `<link rel="import">`-Element mit der angegeben URL und fügt es dem Dokument hinzu, sodass dieser ausgeführt werden kann. Wenn der Link geladen wurde, also der `onload`-Callback aufgerufen wird, ist die `import`-Eigenschaft des Links der Inhalt des zurückgegebenen, importierten HTML-Dokuments. Der Parameter `onerror` ist dabei eine optionale Callback-Funktion, die beim Auftreten eines Fehlers aufgerufen wird.



