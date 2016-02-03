# Zusätzliche Polymer Funktionalitäten

- TODO: Data-Binding: (Siehe Abschnitt 2.X - Property Oberserver)
- (siehe Abschnitt 3.2. Declared Properties)
- (siehe Kapitel 3.2. - hostAttributes)

Polymer bietet eine zusätzliche Applikations-Schicht mit einigen hilfreichen Funktionalitäten, die das Arbeiten mit den Komponenten vereinfachen. Die wichtigsten werden in diesem Kapitel dargestellt. Abschnitt 5.1 widmet sich dabei um das One-Way- und Two-Way-Data-Binding, Abschnitt 5.2 erläutert die Behaviors und in Abschnitt 5.3 erklärt abschließend die Events.


## One-Way- und Two-Way-Data-Binding

Für den Transport von Daten zwischen Komponenten sieht Polymer das One-Way- und Two-Way-Data-Binding vor. Die Daten können dabei zwischen einer Eigenschaft eines Custom Elements (Host-Element) und dessen lokalen DOM (Kind-Element) gebunden und somit zwischen Komponenten ausgetauscht werden. Hierfür sieht Polymer das Mediator-Pattern vor, welches besagt, dass Daten zwischen zwei nebenstehenden Komponenten ihre Daten über eine übergeordnete Komponente propagieren müssen. Dies erfolgt mittels einer hierfür vorgesehenen Syntax für Attribute eines Elements, wie zum Beispiel: `<my-element some-property={{value}}></my-element>`. Durch die doppelten Klammern kann die Eigenschaft `value` des Host Elements Daten in das Attribut `some-property` des Kind Elements weitergeben. Hierzu wird von Polymer für jede Eigenschaft eines Elements ein `propertyEffect` Objekt und ein entsprechender Setter angelegt. Wenn die Eigenschaft zur Laufzeit geändert wird, wird über das Array aus propertyEffects iteriert und bei entsprechender Eigenschaft mittels dem Setter der neue Wert gesetzt, falls dieser sich von dem alten Wert unterscheidet. Wird die Eigenschaft von einem Observer (Siehe Abschnitt 2.X - Property Oberserver) überwacht, so wird dieser im Setter aufgerufen, statt die Werte direkt zu ändern. Für das Binden stehen unterschiedlichen Annotationen zur Verfügung, welche nachfolgend erläutert werden [citeulike:13914892].


### One-Way-Data-Binding

Das One-Way-Data-Binding erlaubt Attributen nur das Lesen der entsprechenden Eigenschaft seiner Komponente, ein schreibender Zugriff wird jedoch untersagt. Meist wird es verwendet, um Texte basierend auf einer Eigenschaft anzuzeigen, der Text jedoch soll nicht verändert werden oder die Eigenschaft überschreiben. Erreicht wird das One-Way-Data-Binding mit der doppelten eckigen Klammer Syntax `[[]]`. Intern legt Polymer für die Eigenschaft keinen eventListener `attributeName-changed` für das Attribut `attributeName` an, somit wird die Eigenschaft, falls das Attribut geändert werden sollte, nicht upgedatet. Beim One-Way-Data-Binding kann dabei zwischen zwei Möglichkeiten unterschieden werden.

**Host to Child**

Das Transportieren der Daten erfolgt nur von Host-Element zum Kind-Element. Hierzu muss zusätzlich der `readOnly`-Parameter (siehe Abschnitt 3.2) nicht definiert oder mit `false` initialisiert werden.

**Child to Host**

Der Transport der Daten erfolgt nur von Kind-Element zu Host-Element. Hierzu müssen die `notify`- und `readOnly`-Parameter mit `true` initialisiert werden.


### Two-Way Data-Binding

* Mittels dem Two-Way Data-Binding, auch "automatic Binding" genannt, können Daten von Host- zu Kind-Element und umgekehrt geschrieben werden. Hierzu ist es zwingend notwendig, den `notify`-Parameter mit `true` zu initialisieren und zusätzlich die doppelte geschweifte Klammer Syntax `{{}}` zu verwenden. Sobald eine der beiden Eigenschaften, die des Kindes oder die des Hosts, geändert werden, wird von dem jeweiligen Element ein `propertyName-changed-event` abgefeuert. Wenn nun ein anderes Element an diese Eigenschaft gebunden ist, bekommt es das Event mit und ändert daraufhin den eigenen Wert. Hierdurch ist es möglich, eine API für eine Komponente bereit zu stellen, um Daten nach außen sichtbar zu machen. Somit können Daten zwischen zwei oder mehr Komponenten ausgetauscht werden.


### Binden von nativen Attributen

Um Werte an von HTML reservierte Attribute, also das `hostAttributes`-Objekt (siehe Anschnitt 3.2) statt an Eigenschaften der Komponente zu binden (was mit der normalen Attribut-Binding-Syntax `=` erreicht wird), muss die hierfür vorgesehene Syntax `=$` verwendet werden. So wird beispielsweise in dem Element `<div class=$"{{myClass}}"></div>` die Eigenschaft `myClass` tatsächlich dem Attribut `class` statt der Eigenschaft zugewiesen. Polymer wandelt hierbei bei Verwendung der `=$` Syntax die Zuweisung in die Anweisung `<div>.setAttribute('class', myClass);` um. Das Binden von nativen Attributen ist somit automatisch immer nur in eine Richtung von Host- zu Kind-Element. Im Allgemeinen sollte die Syntax immer dann verwendet werden, wenn die Attribute `style`, `href`, `class`, `for` oder auch `data-*` gesetzt werden sollen.


## Behaviors

Auch wenn in Polymer nur ein beschränktes Vererben mit Hilfe von Type Extensions möglich ist, gibt es dennoch die Möglichkeit Komponenten mit geteilten Code-Modulen zu erweitern [citeulike:13915080]. Diese Module werden innerhalb von Polymer Behaviors genannt. Behaviors erlauben es, einen Code in mehrere Komponenten einzubinden, um diese mit einem gewissen Verhalten oder mit zusätzlichen Funktionalitäten auszurüsten. Mit Hilfe der Behaviors haben Entwickler eine gute Kontrolle darüber, welche externen Codes in die eigene Komponente fließen. Sie können im Elemente-Katalog gefunden und eingesehen werden. Dort sind sie unter anderem in den Iron-Elementen mit Input-Validierungen oder in den Neon-Elementen mit Animationsverhalten auffindbar.


### Syntax

Behaviors sind globale Objekte und sollten in einem eigenem Namespace, wie z.B. mit `window.MyBehaviors = window.MyBehaviors || {};`, definiert werden, da die von Polymer intern benutzten Behaviors im Polymer-Objekt verankert sind. Dadurch können Kollisionen mit zukünftigen Behaviors von Polymer verhindert werden. 
Behaviors haben eine starke Ähnlichkeit zu normalen Polymer-Elementen, sie besitzen ebenso Properties, Listener-Objekte und so weiter. Ein simples Behavior könnte beispielsweise wie folgt definiert werden [citeulike:13915079].

```javascript
MyBehaviors.HelloBehavior = {
  properties: { ... },
  listeners: {
    mousedown: '_sayHello',
  },
  _sayHello: function() {
    alert('Hallo von der anderen Seite!');
  }
}
```

Dieses Behavior würde, falls es von einer Polymer Komponente benutzt würde, einen Alert auslösen, wenn die Komponente geklickt wird. Um das Behavior nun einer Komponente hinzuzufügen, muss es dem Behaviors-Array hinzugefügt werden `Polymer({ is: 'super-element', behaviors: [HelloBehavior] });`. In diesem Array können so viele Behaviors mit unterschiedlichen Verhaltensweisen hinzugefügt werden, wie benötigt werden.


### Behaviors erweitern

Wie auch Komponenten wiederum andere Komponenten erweitern können, können ebenso Behaviors erweitert werden. Somit können auch Behaviors untereinander geteilte Funktionalitäten einbinden. Um ein Behavior zu erweitern, müssen zunächst alle Behaviors importiert werden, welche das neue Behavior beinhalten soll. Anschließend wird das Verhalten des neuen Behaviors implementiert. Um das neue Behavior nun tatsächlich mit den anderen Behaviors zu erweitern, wird es als Array aus den importieren Behaviors und dem neu implementieren Behavior definiert, wie in dem folgenden Beispiel dargestellt.

```html
<link rel="import" href="oldbehavior.html">
<script>
  NewBehavior = { ... }
  NewBehavior = [ OldBehavior, NewBehavior ]
</script>
```


## Events

Mit Polymer erstellte Komponenten können mit Hilfe des `listeners` Objekts auf bestimmte Interaktionen mit der Komponente reagieren [citeulike:13915080]. Hierzu wird die entsprechende Aktion mit der auszuführenden callBack Funktion in dem Objekt angegeben. Wird nun innerhalb der Komponente das angegebene Event registriert, wird die angegebene Funktion ausgeführt. Zu diesen Events zählen beispielsweise die Gesture Events, wie sie in Abschnitt 3.4.2 beschrieben werden. Um nun verschiedene Aktionen mit unterschiedlichen Kind Elementen zu verknüpfen, können dem `listeners` Objekt auch Kind Elemente und dessen callBack Funktion mit der Syntax `nodeID.eventName: callBack()` hinzugefügt werden. Dadurch reagiert nur das angegebene Element auf das Event, statt der gesamten Komponente. So kann beim "Tap" auf ein Element mit der ID `nodeID` die Funktion (der Event Handler) `callBack()` aufgerufen werden.


### Deklarative Events

Alternativ zur imperativen Definition von Events mittels dem `listeners` Objekt, können diese auch deklarativ im Markup des Elements im lokalen DOM der Komponente angegeben werden. Will ein Element auf ein Event reagieren, so muss es dazu die `on-eventName` wie z.B. `<button on-tap="handleTap">Tap Button</button>` Annotation benutzen, wodurch bei Tap auf den Button die Funktion `handleTap` ausgeführt wird. Dies vermischt zwar innerhalb des Templates HTML und Javascript, jedoch muss mit dieser Methode dem Element keine ID zugewiesen werden, nur um dessen Event zu binden.


### Selbst definierte Events

Falls das gewünschte Event nicht existieren sollte, können von Host Elementen und dessen Kind Elementen auch selbst definierte Events ausgelöst werden. Hierfür muss von der Komponente die Hilfsfunktion `fire(eventName, data);` aufgerufen werden, welches wiederum von anderen Events ausgelöst werden kann. Im folgenden Beispiel wird das Auslösen eines selbst erstellten Events mit der deklarativen Methode verdeutlicht. Der Button in Zeile 3 ruft die Funktion `postClick` auf, wenn er geklickt wird. Diese wiederum feuert mittels der Hilfsfunktion `fire` das Event `my-event`. Nun kann aus dem umschließenden Dokument, der eigenen Komponente oder aus anderen Komponenten auf das Event gehört werden, in dem die Funktion `addEventListener` (Zeile 17) auf das Event abfeuernde Element gebunden wird.

```html
<dom-module id="my-element">
  <template>
    <button on-click="postClick">Ich bin ein Button</button>
  </template>

  <script>
    Polymer({
      is: 'my-element',
      postClick: function(e, detail) {
        this.fire('my-event', {data: 'fired'});
      }
    });
  </script>
</dom-module>

<script>
  document.querySelector('my-element').addEventListener('my-event', function (e) {
    alert(e.detail.data);
  })
</script>
```
