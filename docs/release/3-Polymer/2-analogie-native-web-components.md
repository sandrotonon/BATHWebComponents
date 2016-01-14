
    * Wie werden die einzelnen Technologien mit Polymer umgesetzt (Siehe Struktur Kapitel 2)

# Analogie mit nativen Web Components

- Polymer vereinfacht das Erstellen und den Umgang mit Custom Elements
- Wie funktioniert das und wie werden die Technologien mit Polymer umgesetzt wird jetzt gezeigt


## Custom Elements

- TODO


### Neues Element registrieren

- Für das registrieren eines neuen Elements stellt Polymer die eigene Funktion `Polymer(prototype);` bereit
- Der zu übergebende Prototyp muss die Eigenschaft `is: 'element-name'` haben, welche den HTML Tag Namen des zu erstellenden Custom Elements angibt
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


### Eigenschaften und Methoden definieren: Declared Properties


## TODO

- Custom Elements können auch mit Hilfe von Polymer um Eigenschaften und Methoden erweitert werden
- Hierzu bietet Polymer das `properties` Objekt an, mit welchem die Eigenschaften der Komponente im JSON Format definiert werden können
- Die Eigenschaften müssen nicht alle einzeln hinzugefügt werden wie bei vanillaJS


### hostAttributes

- Zusätzlich zu den Declared Properties auch HTML Element Attribute im Polymer Prototyp definiert werden
- Polymer bietet dafür das `hostAttributes` Objekt an
- Die darin angegebenen Schlüssel - Wert Paare werden beim initialen Erstellen des Elements auf dessen Attribute abgebildet
- das `hostAttributes` kann dabei alle HTML Attribute, bis auf das `class` Attribut definieren, darunter fallen beispielsweise `data-*`, `aria-*` oder das `href` Attribut
- Sieht es beispielsweise so aus `hostAttributes: { 'selected': true }` wird es wie folgt bei einem `option` Element ausgegeben `<option selected>Item</option>`
- wichtig hierbei ist die Serialisierung der Schlüssel Werte
- String Schlüssel werden nicht serialisiert
- Dates oder Numbers werden zu einem String serialisiert
- Boolean Schlüssel werden bei false entfernt, bei true angezeigt
- Arrays oder Objekte werden mittels JSON.stringify serialisiert
- Um Daten von einem HTML Element an das hostAttributes Objekt zu propagieren muss auf eine alternative Syntax zugegriffen werden (siehe Kapitel ## Binden von nativen Attributen)


### Lifecycle Callbacks

- Lifecycle Callbacks (Siehe Kapitel 2 - 2) werden ebenso von Polymer unterstützt
- diese können in dem Prototyp als Attribut bei ihrem normalen Namen oder in verkürzter Form angegeben werden, so heißt beispielsweise die `createdCallback` Methode `created`, die `attachedCallback` heißt `attached` etc.
- Beispiel: `created: function { ... }`
- Zusätzlich bietet Polymer einen `readyCallback`, welcher aufgerufen wird, nachdem Polymer das Element erstellt und den lokalen DOM initialisiert hat (Zusammenfassung von createdCallback und Element ist registriert), also nachdem alle im lokalen DOM befindlichen Elemente konfiguriert wurden und jeweils ihre `ready` Methode aufgerufen haben
- Sie ist besonders hilfreich, wenn nach dem Laden der Komponente dessen DOM nachträglich manipuliert werden soll
- Falls mit den Lifecycle Callbacks gearbeitet wird, muss auf die richtige Anwendung der Reihenfolge geachtet werden
- So werden die Callbacks eines Elementes in der Reihenfolge `created`, `ready`, `factoryImpl` und `attached`


### Quellen

- https://www.polymer-project.org/1.0/docs/devguide/registering-elements.html



## Shadow DOM



## HTML Templates



## HTML Imports

- Um mehrere Polymer Komponenten oder Komponenten innerhalb Komponenten zu benutzen, verwendet Polymer HTML Imports
- Diese funktionieren analog zu der Verwendung mit der nativen HTML Import Technologie (siehe Kapitel 2 # HTML Imports)
- Dabei kommen die gleichen Vor- und Nachteile auf
- Ist ein `<linkg rel="import">` in einer Komponente enthalten, so kümmert sich Polymer automatisch im Hintergrund um die korrekte Einbindung der HTML Dateien und macht sie im Dokument verfügbar
- Dadurch muss auf keine spezielle JavaScript Methoden oder Eigenschaften wie die `import` Eigenschaft des importierten Elementes zugegriffen werden


### Dynamisches Nachladen von HTML

- Polymer bietet zusätzlich eine Hilfsfunktion an, mit der HTML Imports nachträglich geladen werden können
- Die `importHref(href, onload, onerror);` importiert beim Aufruf dynamisch ein HTML Dokument
- Sie erstellt dabei ein `<link rel="import">` Element mit der angegeben URL und fügt es dem Dokument hinzu, sodass dieser geladen werden kann
- Wenn der Link fertig geladen ist, also der `onload` Callback aufgerufen wird, ist die `import` Eigenschaft des Links der Inhalt des importierten HTML Dokumentes

### Quellen

- http://polymer.github.io/polymer/


