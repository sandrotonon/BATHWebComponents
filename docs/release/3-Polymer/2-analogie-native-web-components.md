
    * Wie werden die einzelnen Technologien mit Polymer umgesetzt (Siehe Struktur Kapitel 2)

# Analogie mit nativen Web Components

- Polymer vereinfacht das Erstellen und den Umgang mit Custom Elements
- Wie funktioniert das und wie werden die Technologien mit Polymer umgesetzt wird jetzt gezeigt


## Custom Elements


### Neues Element registrieren

- Für das registrieren eines neuen Elements stellt Polymer die eigene Funktion `Polymer(prototype);` bereit
- Der zu übergebende Prototyp muss die Eigenschaft `is: 'element-name'` haben, welche den HTML Tag Namen des zu erstellenden Custom Elements angibt
- Der Name muss dabei als String übergeben werden und ebenso, wie beim nativen erstellen eines Custom Elements, ein Bindestrich im Namen haben
- Die Polymer Funktion registriert beim Aufruf automatisch das neue Element und gibt einen Konstruktor zurück, mit dem das Element instanziiert werden kann
- Anschließend muss das Element erstellt und dem DOM hinzugefügt werden
- Dies geschieht imperativ und deklaratov analog zu dem Erstellen und Anhängen der nativen Methode mit `var element = document.createElement('element-name');` bzw. mit dem zurückgegebenen Konstruktor oder im HTML Markup mit dem erstellen HTML Tag `<element-name></element-name>`
- Will man statt dem standardmäßig erstellen Konstruktor einen Konstruktor erstellen, dem man Argumente übergeben kann, so muss in dem Prototyp die Methode `factoryImpl` mit den entsprechenden Argumenten definiert werden
- `factoryImpl` wird allerdings nur aufgerufen, wenn ein Element mit dem Konstruktor, nicht jedoch beim Verwenden der `document.createElement` Methode oder im HTML Markup erzeugt wird


### Elemente erweitern

- Ebenso wie bei dem nativen Erweitern von Elementen können auch mit Polymer erzeugte Elemente native Elemente Elemente erweitern, wird `type extension custom elements` genannt
- Jedoch kann ein Polymer Element momentan nur native Elemente erweitern, andere Polymer Elemente hingegen jedoch nicht, was aber in einer zukünftigen Version möglich sein soll
- Das Erweitern und Erzeugen eines `type extension custom elements` funktioniert mit Polymer analog zu der nativen Methode
- Im Prototyp muss die `extends: 'HTMLElement'` Eigenschaft gesetzt werden, wobei das `'HTMLElement'` ein natives HTML Element wie z.B. `'input'` oder `'button'` sein muss
- Zum erzeugen kann wieder die imperative Methode (siehe ### Neues Element registrieren) oder die deklarative Methode analog dem nativen Erstellen mit `<HTMLElement is="my-HTMLElement">` via dem `is` Attribut, gewählt werden


### Lifecycle callbacks

- Lifecycle callbacks (Siehe Kapitel 2 - 2) werden ebenso von Polymer unterstützt
- diese können in dem Prototyp als Attribut bei ihrem normalen Namen oder in verkürzter Form angegeben werden, so heißt beispielsweise die `createdCallback` Methode `created`, die `attachedCallback` heißt `attached` etc.
- Beispiel: `created: function { ... }`
- Zusätzlich bietet Polymer einen `readyCallback`, welcher aufgerufen wird, nachdem Polymer das Element erstellt und den lokalen DOM initialisiert hat


### TODO - https://www.polymer-project.org/1.0/docs/devguide/registering-elements.html#ready-method


## Shadow DOM

## HTML Templates

## HTML Imports
