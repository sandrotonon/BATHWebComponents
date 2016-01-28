# Analogie zu nativen Web Components

- Polymer vereinfacht das Erstellen und den Umgang mit Custom Elements
- Dabei werden die von den Web Components Standards definierten Prämissen versucht einzuhalten und zu erweitern
- Ebenso wie bei bei dem nativen Erzeugen einer eigenen Komponente, werden bei Polymer für jede Komponente HTML einzelne HTML Dateien erstellt, welche die Elemente repräsentieren
- Darin werden alle JavaScript, CSS und HTML Strukturen gesammelt und gekapselt
- Man distanziert sich somit von der Code-Trennung, stattdessen werden alle Element-spezifischen Inhalte in einer Datei gebündelt
- Wie funktioniert das und wie werden die Technologien mit Polymer umgesetzt wird in diesem Kapitel dargestellt


## Custom Elements

- Die Intention der Polymer Library ist das erstellen eigener Komponenten oder Elementen, den Custom Elements
- Das Erstellen, Erweitern und Verwalten von Custom Elements kann mit den nativen Mitteln bei steigender Komplexität mitunter schwierig werden
- Polymer stellt hierfür eine Reihe an hilfreicher Funktionen bereit, die das Arbeiten mit den Web Components Standards erleichtern und erweitern sollen [citeulike:13915080]


### Neues Element registrieren

- Für das registrieren eines neuen Elements stellt Polymer die Funktion `Polymer(prototype);` bereit, darin werden die generellen Polymer Einstellungen vorgenommen
- Um ein Element zu definieren, muss der zu übergebende Prototyp die Eigenschaft `is: 'element-name'` haben, welche den HTML Tag Namen des zu erstellenden Custom Elements angibt
- Der Name muss dabei als String übergeben werden und ebenso, wie beim nativen erstellen eines Custom Elements, ein Bindestrich im Namen haben
- Die Polymer Funktion registriert beim Aufruf automatisch das neue Element und gibt einen Konstruktor zurück, mit dem das Element instanziiert werden kann
- Anschließend muss das Element erstellt und dem DOM hinzugefügt werden
- Dies geschieht imperativ und deklarativ analog zu dem Erstellen und Anhängen der nativen Methode mit `var element = document.createElement('element-name');` bzw. mit dem zurückgegebenen Konstruktor oder im HTML Markup mit dem erstellen HTML Tag `<element-name></element-name>`
- Will man statt dem standardmäßig erstellen Konstruktor einen Konstruktor erstellen, dem man Argumente übergeben kann, so muss in dem Prototyp die Methode `factoryImpl` mit den entsprechenden Argumenten definiert werden
- diese feuert nach dem Ausführen einen `factoryImpl` Callback (siehe Lifecycle Callbacks)
- `factoryImpl` wird allerdings nur aufgerufen, wenn ein Element mit dem Konstruktor, nicht jedoch beim Verwenden der `document.createElement` Methode oder im HTML Markup erzeugt wird


### Elemente erweitern

- Ebenso wie bei dem nativen Erweitern von Elementen können auch mit Polymer erzeugte Elemente native Elemente Elemente erweitern, wird `type extension custom elements` genannt
- Jedoch kann ein Polymer Element momentan nur native Elemente erweitern, andere Polymer Elemente hingegen jedoch nicht, was aber in einer zukünftigen Version möglich sein soll
- Das Erweitern und Erzeugen eines `type extension custom elements` funktioniert mit Polymer analog zu der nativen Methode
- Im Prototyp muss die `extends: 'HTMLElement'` Eigenschaft gesetzt werden, wobei das `'HTMLElement'` ein natives HTML Element wie z.B. `'input'` oder `'button'` sein muss
- Zum erzeugen kann wieder die imperative Methode (siehe ### Neues Element registrieren) oder die deklarative Methode analog dem nativen Erstellen mit `<HTMLElement is="my-HTMLElement">` via dem `is` Attribut, gewählt werden


### Declared Properties - Eigenschaften und Methoden definieren

- Custom Elements können auch mit Hilfe von Polymer um Eigenschaften und Methoden erweitert werden
- Hierzu bietet Polymer das `properties` Objekt an, mit welchem die Eigenschaften der Komponente im JSON Format definiert werden können
- Die Eigenschaften müssen nicht alle einzeln hinzugefügt werden wie bei vanillaJS
- Die Eigenschaften, die diesem Objekt hinzugefügt wurden, können im HTML Markup konfiguriert werden
- Dadurch ist es möglich eine API für das Element zu erstellen (Attribute des Elements sind von außen konfigurierbar - bilden also ein Interface)
- Eine Eigenschaft bzw. Property kann dabei mit folgenden Parametern spezifiziert werden
    + type: Konstruktor-Typ der Eigenschaft, er kann ein Boolean, Date, Number, String, Array oder Object sein
    + value: Standardwert der Eigenschaft, der Wert muss boolean, number, string oder eine Funktion sein
    + reflectToAttribute: Boolean-Wert, gibt an ob die Eigenschaft mit dem HTML Attribut synchronisiert werden soll. Das bedeutet, dass falls Eigenschaft geändert wird, das zugehörige HTML Attribut des Elements geändert wird, was äquivalent zu `this.setAttribute(property, value);` ist. Der Name des HTML Attributs muss dabei in dem Properties-Objekt kleingeschrieben werden. Enthält der Name zusätzlich Bindestriche, so muss die Eigenschaft kleingeschrieben und die Bindestriche entfernt werden, wobei jedes Wort nach einem Bindestrich groß geschrieben werden muss.
    + readOnly: Boolean-Wert, gibt an ob die Eigenschaft nur gelesen oder auch geschrieben werden soll (siehe Kapitel Two-Way data binding)
    + notify: Boolean-Wert, die Eigenschaft ist für Two-Way Data Binding verfügbar, falls true. Zusätzlich wird ein `property-name-changed` Event ausgelöst, wenn sich die Eigenschaft ändert (siehe Kapitel ## One-Way Data Binding ### Host to Child)
    + computed: Name der Funktion als String, welche den Wert der Eigenschaft berechnen soll (Siehe Kapitel Berechnete Eigenschaften)
    + observer: Name der Funktion als String, welche aufgerufen wird, wenn der Wert der Eigenschaft geändert wird (siehe Kapitel Property Oberserver)
- Die oben genannten Parameter sind alle optional anzugeben. Wird keine der Parameter definiert, so kann die Eigenschaft direkt mit dem type definiert werden
- Soll also eine Eigenschaft `propertyName` als String und ohne Parameter angegeben werden, so würde das wie folgt erreicht werden: `properties: { propertyName: String,}`


### Computed Properties

- Polymer unterstützt zusammengesetzte, virtuelle Eigenschaften, welche aus anderen Eigenschaften berechnet werden
- Um eine Eigenschaft zu berechnen, muss die dafür verwendete Funktion im `properties` Objekt mit entsprechenden Parametern angegeben werden
- Soll eine Eigenschaft die Zusammensetzung der Eigenschafen a und b darstellen, so könnte sie als `result: { type: String, computed: computeResult(a, b) }` im `properties` Objekt angegeben werden
- Die entsprechende Funktion muss dann als `computeResult: function(a, b) { ... }` im Polymer Prototyp definiert werden
- Die Funktion wird einmalig aufgerufen, wenn sich eine der Eigenschaften a oder b ändert und wenn keine von beiden undefiniert ist
- Der von ihr zurückgegebene Wert wird anschließend in der Variablen `result` gespeichert


### Property Oberserver

- Wird für eine Eigenschaft der `observer` Parameter angegeben, wird die Eigenschaft auf Änderungen überwacht
- Wird die Eigenschaft verändert, so wird die im `observer` Parameter angegebene Funktion mit dem neuen und dem alten Wert als optionale Argumente aufgerufen
- Ein Observer einer Eigenschaft wird wie folgt definiert `propertyName: { observer: '_propertyNameChanged' }`
- Jedoch kann auf diese Weise jeweils nur eine Eigenschaft von einem Observer überwacht werden, nicht jedoch mehrere Eigenschafen von einem Observer
- Hierfür bietet Polymer ein gesondertes `observers` Array in dem Prototypen an
- Darin können mehrere Observer unterschiedliche Kombinationen von Eigenschaften überwachen
- Soll die Funktion `computeResult(a, b)` ausgeführt werden, sobald sich eine der Eigenschaften a und b ändert, so kann diese Funktion in das Array übernommen werden
- Jedoch wird die Funktion auch bei den Observern nur dann ausgeführt, wenn keiner der Werte undefiniert ist
- Des Weiteren wird bei den in dem `observers` Array angegebenen Funktionen, im Gegensatz zu den in dem `properties` Objekt angegebenen Observern, nur der neue Wert, statt der neue und der alte Wert übergeben
- Mit dem `observers` Array ist es auch möglich Sub-Properties zu überwachen, falls also ein Objekt eine Unter-Eigenschaft hat und diese geändert wird, soll eine Funktion aufgerufen werden
- Selbiges gilt für Arrays, wird in einem Array ein Wert geändert, hinzugefügt, entfernt oder verschoben, kann eine entsprechende Funktion aufgerufen werden


### Das hostAttributes-Objekt

- Zusätzlich zu den Declared Properties können auch HTML Element Attribute im Polymer Prototyp definiert werden
- Polymer bietet dafür das `hostAttributes` Objekt an
- Die darin angegebenen Schlüssel - Wert Paare werden beim initialen Erstellen des Elements auf dessen Attribute abgebildet
- das `hostAttributes` kann dabei alle HTML Attribute, bis auf das `class` Attribut definieren, darunter fallen beispielsweise die `data-*`, `aria-*` oder `href` Attribute
- Sieht es beispielsweise so aus `hostAttributes: { 'selected': true }` wird es wie folgt bei einem `option` Element ausgegeben `<option selected>Item</option>`
- wichtig hierbei ist die Serialisierung der Schlüssel - Werte
- String Schlüssel werden nicht serialisiert
- Dates oder Numbers werden zu einem String serialisiert
- Boolean Schlüssel werden bei false entfernt, bei true angezeigt
- Arrays oder Objekte werden mittels JSON.stringify serialisiert
- Um Daten von einem HTML Element an das hostAttributes Objekt zu propagieren muss auf eine alternative Syntax zugegriffen werden (siehe Kapitel ## Binden von nativen Attributen)


### Lifecycle Callbacks

- Lifecycle Callbacks (Siehe Kapitel 2.2) werden ebenso von Polymer unterstützt
- diese können in dem Prototyp als Attribut bei ihrem normalen Namen oder in verkürzter Form angegeben werden, so heißt beispielsweise die `createdCallback` Methode `created`, die `attachedCallback` heißt `attached` etc.
- Beispiel: `created: function { ... }`
- Zusätzlich bietet Polymer einen `readyCallback`, welcher aufgerufen wird, nachdem Polymer das Element erstellt und den lokalen DOM initialisiert hat (Zusammenfassung von createdCallback und Element ist registriert), also nachdem alle im lokalen DOM befindlichen Elemente konfiguriert wurden und jeweils ihre `ready` Methode aufgerufen haben
- Sie ist besonders hilfreich, wenn nach dem Laden der Komponente dessen DOM nachträglich manipuliert werden soll
- Falls mit den Lifecycle Callbacks gearbeitet wird, muss auf die richtige Anwendung der Reihenfolge geachtet werden
- So werden die Callbacks eines Elementes in der Reihenfolge `created`, `ready`, `factoryImpl` und `attached`


## Shadow DOM und HTML Templates

- Die erzeugten Custom Elements existieren bisher nur ohne eigenes Markup
- Wie bei den nativen Technologien, können auch mit Polymer erzeugte Custom Elements um HTML-Markup, den lokalen DOM, erweitert werden [citeulike:13915080]
- Hierzu muss das Polymer `<dom-module>`-Element benutzt werden
- Diesem muss der Wert `is`-Eigenschaft des Polymer-Prototyps als ID zugewiesen werden
- Der definierte HTML Markup muss dann in einem `<template>`-Tag dem `<dom-module>` hinzugefügt werden
- Auf das Klonen des Inhalts des Templates mittels der `importNode`-Funktion (siehe Kapitel 2.4.3) kann hierbei verzichtet werden, da Polymer diesen automatisch in den lokalen DOM des Elements klont
- Soll also der lokale DOM des `<element-name>`-Tags deklariert werden, so wird dies solchermaßen erreicht:

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

- Der deklarative Teil des Elements, das `<dom-module>` und dessen Inhalte, sowie der Imperative Teil mit dem `Polymer({ ... })` Aufruf können entweder in der selben oder in getrennten HTML-Dateien stehen
- Hierbei spielt es jedoch keine Rolle ob das `<script`-Tag innerhalb oder außerhalb des `<dom-module>`-Tags steht, solange das Template vor dem Polymer-Funktionsaufruf geparst wird


### Shady DOM

- Wie in Kapitel 2.3.9 gezeigt, wird der Shadow DOM nicht von allen Browsern unterstützt, ebenso ist der Polyfill aufgrund dessen schlechter Performanz (siehe Kapitel 2.7.4) für diesen nur als aller letzte Instanz zu sehen
- Aus diesen Gründen ist in Polymer der sogenannte "Shady DOM" implementiert [citeulike:13886251]
- Dieser bietet einen Shadow DOM ähnlichen Scope für den DOM Tree, dabei rendert er den DOM als wenn kein Shadow DOM in dem Element vorhanden wäre
- Dies bringt wiederum auch die dadurch Nachteile mit sich, dass internes Markup nach Außen sichtbar ist, keine Shadow Boundary verfügbar ist usw.
- Der Vorteil ist jedoch, dass der Shady DOM genug Methoden für einen Scope bereitstellt um sich wie ein Shadow DOM verhalten zu können
- Hierzu ist es jedoch zwingend notwendig die eigens entwickelte Shady DOM API im Umgang mit dem DOM Tree zu benutzen
- Erreicht wird das mit der `Polymer.dom(node)` Funktion
- Will man beispielsweise alle Kinder mit der `children`-Eigenschaft des Shadow Host Elements `<my-element>` selektieren, so erfolgt dies mit der Shady DOM API mittels `var children = Polymer.dom(my-element).children;` statt mit der normalen DOM API mittels `var children =  document.getElementsByTagName("my-element")[0].children;`
- Die Shady DOM API bildet dabei alle Funktionen der nativen DOM API ab und ist performanter als der Shadow DOM Polyfill, da nicht dessen Verhalten, sondern nur ein eigener DOM Scope implementiert ist
- Jedoch beschränkt sich Polymer nicht nur auf den Shady DOM, vielmehr ist er mit dem nativen Shadow DOM kompatibel, sodass die Shady DOM API auf den nativen Shadow DOM zugreifen kann, falls dieser von dem Browser unterstützt wird
- Es kann also eine Applikation implementiert werden, die auf allen Plattformen mit einer verbesserten Performanz funktioniert
- Besonders die mobilen Browser profitieren hiervon
- Standardmäßig benutzt Polymer jedoch immer die eigene Shady DOM API, wie das verhindert werden kann wird in Kapitel 6.1.2 dargestellt


### Content Projection

- Ebenso wie mit den nativen Technologien, können auch in Polymer in Custom Elements geschachtelte Kind Elemente (Light DOM) in den Shady DOM hineinprojiziert werden
- Hierzu dient das schon bekannte `<content>`-Element, welches einen Insertion Point im lokalen DOM der Komponente für den Light DOM darstellt
- Wie auch bei den nativen Insertion Points, kann das `<content>`-Element auch nur selektierte Inhalte annehmen, in dem das `select`-Attribut mit einem entsprechenden Selektor gesetzt wird
- Falls der Shadow DOM in Polymer verfügbar ist, so wird (wie nativ auch), eine Zusammenstellung des Shadow DOM Tress und dem Light DOM gerendert
- Ist der Shadow DOM jedoch nicht verfügbar und der Shady DOM wird verwendet, so ist der zusammengesetzte DOM der tatsächliche DOM des Elements
- Auch kann in Polymer mittels der `_observer`-Eigenschaft überwacht werden, ob Kind-Elemente der Komponente hinzugefügt oder von ihr entfernt werden
- Dazu wird dieser die Funktion `observeNodes(callback)` übergeben, welche ausgeführt wird, wenn Elemente hinzugefügt oder entfernt werden
- Der Parameter `callback` ist dabei eine anonyme Funktion, welche als Übergabewert das Objekt `info` hat, in welchem die hinzugefügten oder entfernten Knoten enthalten sind
- Eine Implementierung der Überwachung des `contentNode`-Knotens auf Änderungen könnte dabei wie folgt aussehen:

```javascript
this._observer = Polymer.dom(this.$.contentNode).observeNodes(function(info) {
  this.processNewNodes(info.addedNodes);
  this.processRemovedNodes(info.removedNodes);
});
```


### Styling

siehe styling.md

- https://www.polymer-project.org/1.0/docs/devguide/styling.html


### DOM Knoten automatisch finden

- Um das traversieren in dem lokalen DOM zu beschleunigen, bietet Polymer eine Hilfsfunktion für das sogenannte automatische Knoten-Finden oder auch "Automatic node finding"
- Hierzu wird intern ein Mapping zu den statisch erzeugten DOM Elementen erzeugt in dem jedes Element des lokalen DOM-Templates, für welches eine ID definiert wurde, in dem `this.$` Hash gespeichert wird
- Hat nun also das Element `<div id="wrapper"></div>` in dem Template die ID `wrapper`, so kann es in Polymer mittels `this.$.wrapper` selektiert werden
- Jedoch werden nur die statisch erzeugten DOM Knoten hinzugefügt, dynamisch mittels `dom-repeat` oder `dom-if` hinzugefügte Knoten allerdings nicht
- Dynamisch hinzugefügte Knoten können mit der `$$`-Funktion selektiert werden
- So liefert die Funktion `this.$$(selector);` das erste Element mit der ID `selector` des Templates


## HTML Imports

Um mehrere Polymer Komponenten oder Komponenten innerhalb anderer Komponenten zu benutzen, verwendet Polymer HTML Imports. Diese funktionieren analog zu der Verwendung mit der nativen HTML Imports Technologie (siehe Abschnitt 2.5 - HTML Imports), wobei die selben Vor- und Nachteile auftreten. Polymer kümmert sich dabei lediglich automatisch im Hintergrund um die korrekte Einbindung der HTML-Dateien und dessen Bereitstellung im Dokument, falls ein `<link rel="import">` in einer Komponente enthalten ist. Das manuelle Einbinden mittels der speziellen JavaScript Methoden oder Eigenschaften, wie beispielsweise der `import`-Eigenschaft des importierten Elementes, wird somit hinfällig.


### Dynamisches Nachladen von HTML

Falls HTML-Dateien dynamisch zur Laufzeit nachgeladen werden sollen, bietet Polymer zusätzlich eine Hilfsfunktion an, mit der HTML Imports nachträglich ausgeführt werden können [citeulike:13914840]. Die hierfür bereitgestellte Funktion `importHref(url, onload, onerror);` importiert beim Aufruf dynamisch die angegebene HTML-Datei in das Dokument. Sie erstellt dabei ein `<link rel="import">`-Element mit der angegeben URL und fügt es dem Dokument hinzu, sodass dieser ausgeführt werden kann. Wenn der Link geladen wurde, also der `onload`-Callback aufgerufen wird, ist die `import`-Eigenschaft des Links der Inhalt des zurückgegebenen, importierten HTML-Dokumentes. Der Parameter `onerror` ist dabei eine optionale Callback-Funktion, die beim Auftreten eines Fehlers aufgerufen wird.



