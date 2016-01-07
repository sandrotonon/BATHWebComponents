
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
- readOnly nicht definiert oder mit false initialisiert


### Child to Host

- [[]]
- Von unten nach oben kann erreicht werden, wenn das readOnly Flag auf true gesetzt wird


## Two-Way Data Binding

- {{}} automatic binding
- funktioniert nur, wenn die property `notify: true` gesetzt hat -> {{}} macht es hauptsächlich übersichtlicher
- Daten fließen vom host-element zu dem Target und andersrum
- Wenn eine property geändert wird, feuert das Element einen changed-event. Ein anderes element das an die property gebunden ist hört auf das changed-event und ändert seinen wert
- z.b. `attribute={{foo}}`
- foo hat einen foo-changed eventListener und es gibt einen attribute-changed eventListener
- wenn sich der wert des attributes ändert wird das attribute-changed event gefeuert und die property foo wird geändert


## Binden von nativen Attributen

- Um Werte an Attribute statt an Properties zu binden muss die Attribut-Binding Syntax `=$` verwendet werden, da mit der normalen `=` Zuweisung der Wert an die entsprechende Property gebunden wird
- Beispiel: `<div class=$"myClass"></div>`
- resultiert in `<div>.setAttribute('class', myClass);`
- Sind immer One-Way - host-to-child
- Sollte verwendet werden, wenn `style`, `href`, `class`, `for` oder `data-*` Attribute gesetzt werden


## Binden von srtukturierten Daten?
## Binden von Arrays?


## Quellen

- https://www.chromium.org/developers/polymer-1-0#TOC-Achieving-data-binding-nirvana


# Behaviors

- Code den man in ein Element mixin kann
- polymer element hält array mit behaviors, mix in so viele behaviors wie wir brauchen
- gute kontroller darüber welcher code in das element fließt
- behaviors sind globale objekte
- sehen aus wie ein polymer element mit properties oder listener objects etc.
- Sind im Elemente Katalog in Iron-Elements und Neon-Elements enthalten um verhschiedene Funktionalitäten zu bieten


## Quellen

- https://www.youtube.com/watch?v=YrlmieL3Z0k&list=PLOU2XLYxmsII5c3Mgw6fNYCzaWrsM3sMN&index=2&feature=iv&src_vid=Lwvi1u4XXzc&annotation_id=annotation_1360810993
- https://www.polymer-project.org/1.0/docs/devguide/behaviors.html


## Syntax


## Event Listeners

