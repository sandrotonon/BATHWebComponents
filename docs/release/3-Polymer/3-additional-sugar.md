
    * Additional Sugar - Zusätzliche Polymer Schicht mit Data-binding, Behaviours etc.

# Einleitung

- Polymer bietet zusätzliche Application Schicht mit einigen hilfreichen Features


# One-Way und Two-Way Data Binding

- Daten können in dem lokalen DOM des Elements gebunden und damit zwischen Elementen ausgetauscht werden
- Mediator Pattern: Daten können nicht zwischen 2 Elementen direkt ausgetauscht werden, sondern Daten müssen über ein Eltern-Element propagiert werden
- entsprechende Annotation ist zu beachten
- Beispiel: `<my-element name="[[myName]]"></my-element>` bindet das name-Attribut von my-element an das myName-Attribut des host-Elements
- für jedes Element (z.b. div tag) wird ein "propertyEffect" Object und ein Setter angelegt
- Jedes Mal wenn die Eigenschaft geändert wird wird über das array mit propertyEffects iteriert und der neue wert gesetzt, wenn er anders ist als der alte
- wenn es ein Observer für die Eigenschaft gibt, wird einfach dieser in dem setter aufgerufen


## One-Way Data Binding

- [[]]
- eventListener für das Attribut `attribute-changed` wird nicht angelegt somit werden die Daten nicht geupdated

### Host to Child

- [[]]
- readOnly der Eigenschaft im Prototyp nicht definiert oder mit false initialisiert


### Child to Host

- [[]]
- Von unten nach oben wird erreicht, wenn readOnly und notify der Eigenschaft im Prototyp auf true gesetzt sind


## Two-Way Data Binding

- {{}} automatic binding
- funktioniert nur, wenn die property `notify: true` gesetzt hat -> {{}} macht es hauptsächlich übersichtlicher
- Daten fließen vom host-element zu dem Target und andersrum
- Wenn eine property geändert wird, feuert das Element einen changed-event. Ein anderes element das an die property gebunden ist hört auf das changed-event und ändert seinen wert
- z.b. `attribute={{foo}}`
- foo hat einen foo-changed eventListener und es gibt einen attribute-changed eventListener
- wenn sich der wert des Attributes ändert wird das attribute-changed event gefeuert und die property foo wird geändert


## Binden von nativen Attributen

- Um Werte an Attribute, also das `hostAttributes` Objekt (siehe Kapitel X), statt an Properties zu binden muss die Attribut-Binding Syntax `=$` verwendet werden, da mit der normalen `=` Zuweisung der Wert an die entsprechende Property gebunden wird
- Beispiel: `<div class=$"myClass"></div>`
- resultiert in `<div>.setAttribute('class', myClass);`
- Sind immer One-Way - host-to-child
- Sollte verwendet werden, wenn `style`, `href`, `class`, `for` oder `data-*` Attribute gesetzt werden


## Binden von srtukturierten Daten?
## Binden von Arrays?


## Quellen

- https://www.chromium.org/developers/polymer-1-0#TOC-Achieving-data-binding-nirvana


# Behaviors

- Codemodule den man in ein Element mixin kann
- gute Kontrolle darüber welcher Code in das Element fließt
- Sind im Elemente Katalog vorhanden um verschiedene Funktionalitäten zu bieten
- z.b. in Iron-Elements um Input Validierungen zu machen oder in Neon-Elements um Elemente zu animieren


## Syntax

- Behaviors sind globale Objekte und sollten in einem eigenem Namespace definiert werden, die von Polymer erstellten Behaviors sind im Polymer Objekt
```
window.MyBehaviors = window.MyBehaviors || {};
```
Hier: im window Namepace
- sehen aus wie ein polymer Element mit Properties oder listener objects etc.
- Beispiel
```
MyBehaviors.HelloBehavior = {
    properties: { ... },
    listeners: {
        mousedown: '_sayHello',
    },
    _sayHello: function() {
        alert('Hello!');
    }
}
```
- polymer Element hält Array mit Behaviors -> mixin so viele Behaviors wie wir brauchen
- Um es einem Polymer Element hinzuzufügen:
```
Polymer({
  is: 'super-element',
  behaviors: [SuperBehavior]
});
```


## Behaviors erweitern

- Statt neue Behaviors anzulegen, können existierende auch erweitert werden
- Um ein Behavior zu erweitern müssen zunächst alle Behaviors importiert werden, welche das neue Behavior haben soll
- Anschließend wird das Verhalten des neuen Behaviors implementiert
- Um es dann zu erweitern wird das neue Behavior als Array aus den importieren Behaviors und dem neuen definiert
```
<link rel="import" href="oldbehavior.html">
<script>
    NewBehavior = { ... }
    NewBehavior = [ OldBehavior, NewBehavior ]
</script>
```


## Quellen

- https://github.com/Polymer/polycasts/blob/master/ep21-behaviors/behaviors-demo/elements/pressed-behavior/pressed-behavior.html
- https://www.youtube.com/watch?v=YrlmieL3Z0k&list=PLOU2XLYxmsII5c3Mgw6fNYCzaWrsM3sMN&index=2&feature=iv&src_vid=Lwvi1u4XXzc&annotation_id=annotation_1360810993
- https://www.polymer-project.org/1.0/docs/devguide/behaviors.html


# Events

- Dem Host Element können Event Listeners hinzugefügt werden, die auf bestimmte Aktionen mit dem Element reagieren
- Es können auch Kind-Elementen in dem Host Element Event Listeners mit der Syntax `nodeID.eventName` hinzugefügt werden
- Dazu muss in der Definition des Polymer Objektes ein `listeners` Objekt erstellt werden, in welchem die Events auf die Event Handler gemappt werden
- So kann beim "Tap" (Näheres siehe "Kapitel Gestures") auf ein Element mit der ID `nodeID` eine Funktion - der Event Handler - aufgerufen werden


## Deklarative Events

- Alternativ zur imperativen Definition von Events können diese auch deklarativ im Markup des Elementes im Templates angegeben werden
- Ein DOM Element muss dazu die `on-eventName` Annotation benutzen
- z.b. `<button on-tap="handleTap">Tap Button</button>`
- Der Event Handler `handleTap` muss allerdings dennoch im Polymer Ojekt definiert werden
- Dadurch wird keine ID benötigt um deinen Event Listener zu binden
- allerdings wird dadurch HTML und JavaScript gemischt


## Selbst definierte Events

- Vom Host Element und dessen Kind Elemente können auch selbst definierte Events ausgelöst werden
- Hierfür muss die Hilfsfunktion `fire(eventName, data);` aufgerufen werden
- Auf das Event `eventName` kann dann im globalen Scope gehört werden
- Im Beispiel wird das auslösen eines eigenen Events mit der deklarativen Methode deutlich
```
<dom-module id="my-element">
    <template>
      <button on-click="postClick">Click Me</button>
    </template>

    <script>
        Polymer({
            is: 'my-element',
            postClick: function(e, detail) {
                this.fire('clicked', {data: 'clicked'});
            }
        });
    </script>
</dom-module>

<script>
    document.querySelector('my-element').addEventListener('click', function (e) {
        alert('Button Clicked!');
    })
</script>
```


## Quellen

- https://www.polymer-project.org/1.0/docs/devguide/events.html
