# Shadow DOM

- TODO:

- Ausformulieren:
  - Complete


## Einführung

- Der Shadow DOM ist ein Sub-DOM unterhalb einem HTML Element, der es ermöglicht, HTML und CSS in sich zu kapseln und zu verstecken
- Wird Shadow DOM wird bereits in HTML5 standardmäßig eingesetzt, z.b. in dem `<video>` Tag. Beim Inspizieren wird deutlich, dass das `<video>` Tag einen Shadow DOM beinhaltet, welcher die Steuerelemente des Videos erzeugt
- Ebenso sind die verschiedenen `<input>` Elemente, wie z.B. das `<input type="password">` mit einem Shadow-DOM ausgestattet:

![Bild eines input type="password"](https://github.com/Glur4k/BATHWebComponents/blob/master/app/images/input_type_password.jpg)

- Der Shadow DOM liegt dabei parallel zu dem DOM Knoten des beinhaltenden Elementes (Siehe Bild). Ein Knoten im Document tree (links) wird als Shadow DOM beihaltendes Element (shadow host) markiert. Die gestrichelte Linie zeigt die Referenz zu der entsprechenden Shadow DOM Wurzel, dem "shadow root". Die Referenz geht dabei durch die sogenannte "Shadow Boundary", welche es ermöglicht, den Shadow DOM, und alles was dieser beinhaltet, zu kapseln
- Die Kapselung des Shadow DOM mittels der Shadow Boundary verhindert, dass CSS oder JavaScript in den Shadow DOM hinein oder hinaus kommen

![Bild: Shadow DOM und Shadow Boundary nach W3C](https://raw.githubusercontent.com/glur4k/BATHWebComponents/master/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/2-Shadow-dom_shadow_boundary.png "Shadow DOM und Shadow Boundary nach W3C. Quelle: http://www.sitepoint.com/the-basics-of-the-shadow-dom/")

- Ein Element kann auch mehrere Shadow DOM Wurzeln referenzieren, allerdings wird nur die zuletzt hinzugefügte gerendert, der Browser benutzt beim Rendern einen LIFO Stack
- Der zuletzt hinzugefügte Shadow Tree wird "youngest tree" genannt, der jeweils zuvor hinzugefügte Shadow Tree wird "older tree" genannt

[Colin Ihrig 2012], [Peter Kröner 2014]


## Content projecting

- Neben dem vom Shadow DOM vorgegebenen HTML Markup, können auch Inhalte aus dem Shadow DOM in den Light DOM, den DOM des Dokumentes, projiziert werden.
- Der Shadow DOM ermöglicht somit die Möglichkeit gekapseltes HTML im Shadow DOM, sowie dynamische Inhalte im Light DOM anzuzeigen
- Diese Projektion der Inhalte in den Light DOM erfolgt mittels "Insertion Points", wobei zwischen zwei Arten von "Insertion Points" unterschieden wird:


### Insertion Points

- Um das zu präsentierende HTML von dem notwendigen zu trennen, wird ein `<template>` Tag benutzt. Dieses beinhaltet alles Markup, das im Shadow DOM stehen und nicht nach außen sichtbar oder manipuliert werden soll
- Das `<template>` Tag kann nun ein `<content>` Tag beinhalten, welches die Inhalte von außen in den Light DOM hineinprojiziert. Der Light DOM ist der DOM des HTML Dokumentes

```html
<div id="shadow">Content</div>
<template id="myTemplate">
  <div class"hiddenWrapper">
    <content></content>
  </div>
</template>
```

```javascript
<script>
var shadow = document.querySelector('#shadow').createShadowRoot();
var template = document.querySelector('#myTemplate');
var clone = document.importNode(template.content, true);
shadow.appendChild(clone);
</script>
```

- Gerendert wird dabei nur "Content" des divs mit der id "shadow", der Wrapper um das `<content>` Tag wird nicht gerendert, da dieser im Shadow DOM steht
- Somit wurde eine Trennung des Inhalts und der Darstellung erreicht, der Inhalt steht im Dokument, die Darstellung erfolgt im Shadow DOM
- Nodes die aus dem Host ein den Shadow Tree projiziert werden heißen "distributed nodes"
- Es können auch nur bestimmte Elemente in den Light DOM projiziert werden, ermöglicht wird dies mit dem Attribut `select` des `content` Tags. Dabei können Elemente, sowie CSS Selektoren verwendet werden
- HTML Elemente, die via `<content>` und `<content select="element">` in den Light DOM projiziert werden, können somit auch von außen gestyled werden (zusätzlich auch via ::content - siehe "Styling mit CSS")
 
[Eric Bidelman 2013]

### Shadow Insertion Points

- `<shadow>` Insertion Points sind, ebenso wie `<content>` Insertion Points, Platzhalter, doch statt einem Platzhalter für den Inhalt eines Hosts, sind sie Platzhalter für Shadow Trees
- Wenn nun mehrere Shadow Trees gerendert werden sollen, muss im zuletzt hinzugefügten Shadow Tree (younger tree) ein `<shadow>` Tag stehen, dieser rendert den zuvor hinzugefügten Shadow Tree (older tree), somit wird eine Shadow DOM Schachtelung ermöglicht

[Eric Bidelman 2014]


## Styling mit CSS

- Shadow Boundary: Styles gehen nicht aus Shadow Dom raus, und keine rein.
  -> Style Kapselung "out of the box"!
- Styling des host-Elements mit :host *selector*
  -> Allerdings überschreiben die inneren Styles nicht die Äußeren!
  (Siehe snippets/shadow-dom/#styling)
  -> Wichtig bei "Reacting to user states"
- Styling des Hosts in Abhängigkeit des Kontextes mit :host-context
  (https://drafts.csswg.org/css-scoping/#selectordef-host-context)
  z.B. :host-context(.wrapper)
- Styling des Shadow DOM von außerhalb
  - ::shadow
    - z.b.: my-element::shadow .content {} spricht .content elemente IN einem Shadow DOM an
    - Styled alle elemente in DIESEM Shadow DOM
  - >>> (ehem. /deep/)
    (https://drafts.csswg.org/css-scoping-1/#deep-combinator)
    - z.b.: my-element >>> .different spricht ALLE .different Elemente in my-element an, egal wieviele Shadow DOMS noch darunter geschachtelt sind
    - So können z.B. "Style-hooks" erzeugt werden, die es Entwicklern ermöglicht eigene Styles auf ein Component zu binden
      some-element >>> .custom-theme { ... }
  - ::slotted (ehem. ::content)
    (http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-201/#toc-distributed)
    - Elemente, die in ein `<content>` projiziert werden, können auch von innen gestyled werden, z.B. (in einer Komponente):

      ```CSS
      ::slotted p {
        color: red;
      }
      ```
      - Spricht alle `<p>` in einem `<content>` Tag an, die in dem Light DOM projiziert werden.
  - CCS Variablen
    (http://dev.w3.org/csswg/css-variables/)
    - Eine Komponente hält im Inneren Variablen für das Aussehen, somit wir das Styling nach außen gegeben
      z.B.:

      ```CSS
      my-button {
        color: var(--button-theme-color, red);  #(red wäre default)
        font-family: var(--button-theme-font);
      }
      ```
      Der Entwickler kann nun von außen die Variablen instanzieren mit

      ```CSS
      #host {
        --button-theme-color: red;
        --button-theme-font:  Arial;
      }
      ```
  - Mit ::shadow und >>> können native Elemente, die einen Shadow DOM benutzen, gestyled werden, wie z.B. `<video>` oder `<input>` Elemente
  - Jedoch sprengt das das Prinzip der Kapselung, das man mit Web Components versucht zu gewinnen, jedoch sollten Web Entwickler natürlich dennoch die Möglichkeit haben, fremde Components zu stylen, wenn sie wissen was sie machen.
- Alles wird durch Polyfills abgedeckt

[Eric Bidelman 2014], [Rob Dodson 2014]


## Beispiel eines Shadow DOMs mit Template und CSS Styles

- Soll nun ein einfacher Shadow DOM mit gekapseltem CSS und JavaScript erzeugt werden, könnte dies folgendermaßen erfolgen:

```html
<style>
  .styled {
    color: green;
  }
  .content {
    background-color: khaki;
  }
</style>

<div id="hello">
  <div>Hello</div>
  <div class="styled">Styled</div>
  <p class="hidden">Hidden Content</p>
</div>
<template id="myTemplate">
  <style>
    .wrapper {
      border: 2px solid black;
      width: 120px;
    }
    .content {
      color: red;
    }
  </style>

  <div class="wrapper">
    Shadow DOM
    <div class="content">
      <content select="div"></content>
    </div>
  </div>
</template>

<script>
  var root = document.querySelector('#hello').createShadowRoot();
  var template = document.querySelector('#myTemplate');
  var clone = document.importNode(template.content, true);
  root.appendChild(clone);
</script>
```

- Das Beispiel oben wird vom Browser wie folgt gerendert:

![Bild: Shadow DOM Beispiel](https://raw.githubusercontent.com/glur4k/BATHWebComponents/9bdb31225fb3e0ad9adfe7ab4530e69f90afbb35/docs/release/2-Web%20Components%20nach%20W3C/2-Web%20Components%20Technology%20Stack/images/2-Shadow-dom_beispiel.jpg "Shadow DOM Beispiel. Quelle: Selbst erstellt")

- Hier sind einige Dinge anzumerken:
  + Es werde per select im `<content>` nur die divs aus dem Shadow Root mit der ID "hello" gerendert, der Paragrapg mit der ID "hidden wird nicht gerendert
  + Die CSS Regel `.content { background-color: khaki; }` des HTML Dokumentes greift nicht durch die Shadow Boundary
  + Die CSS Regel `.styled { color: green; }` greift, da der div mit der Klasse ".styled" in den Light DOM projiziert wird
  + Innerhalb des Templates können CSS Regeln für die beinhaltenden Elemente definiert werden

## Browserunterstützung

- Noch nicht standardtisiert, sind noch ein Working Draft (http://www.w3.org/TR/shadow-dom/)
- Deshalb bisher auch nur in Chrome und Opera unterstützt

![Bild: Shadow DOM Browserunterstützung](2-Shadow-dom_browserunterstuetzung.jpg "Shadow DOM Browserunterstützung. Quelle: http://caniuse.com/#search=shadow%20dom")

[Can I Use 2015]


## Quellen

- [Developing Web Components 2015] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.109-126
- [Rob Dodson 2014] Rob Dodson, Shadow DOM CSS Cheat Sheet, 2014, http://robdodson.me/shadow-dom-css-cheat-sheet/
- [Can I Use 2015] Can I Use, http://caniuse.com/#search=shadow%20dom
- [Peter Kröner 2014] Peter Kröner, Das Web der Zukunft, 2014, http://webkrauts.de/artikel/2014/das-web-der-zukunft
- [Colin Ihrig 2012] Colin Ihrig, The Basics of the Shadow DOM, 2012, http://www.sitepoint.com/the-basics-of-the-shadow-dom/
- [Dominic Cooney 2013] Dominic Cooney, Shadow DOM 101, 2013, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/
- [Eric Bidelman 2014] Eric Bidelman, Shadow DOM 201, 2014, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-201//
- [Eric Bidelman 2013] Eric Bidelman, Shadow DOM 301, 2013, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-301/
