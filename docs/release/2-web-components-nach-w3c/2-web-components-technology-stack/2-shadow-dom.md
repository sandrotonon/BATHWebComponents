# Shadow DOM

Eine weitere Technologie der Web Components ist der so genannte Shadow DOM, welcher es ermöglicht, JavaScript, HTML und CSS in einem neuen Sub-DOM zu kapseln.


## Einleitung

Durch Kapselung ist es möglich, Details eines Objektes von anderen Teilen des Programms zu verstecken. Das Programm muss nur wissen, wie es auf die benötigten Funktionen zugreift, jedoch nicht, wie das Objekt die Funktionen intern umsetzt. Dieses Konzept ist in allen objektorientierten Programmiersprachen umgesetzt, jedoch nicht in der Webentwicklung. Beispielsweise kann das CSS oder JavaScript, das für ein Element geschrieben ist, auch das CSS oder JavaScript anderer Elemente beeinflussen, wenn es nicht konsequent geschrieben wurde. Je größer das Projekt wird, desto unübersichtlicher und komplexer wird es zu gewährleisten, dass CSS oder JavaScript sich nicht ungewollt auf andere Teile der Webseite auswirkt. Diesem Problem widmet sich der Shadow DOM, welcher ein Sub-DOM unterhalb eines Elementes darstellt und es ermöglicht, HTML und CSS in sich zu kapseln und zu verstecken. Der Shadow DOM wird bereits in HTML5 standardmäßig eingesetzt, wie beispielsweise in dem `<video>`-Tag. Beim Inspizieren des Elements mit Hilfe der Chrome Developer Tools oder den Firefox Entwicklungs-Werkzeugen, wird deutlich, dass das `<video>` Tag einen Shadow DOM beinhaltet, welcher die Steuerelemente des Videos erzeugt. Neben dem `<video>`-Tag sind auch die verschiedenen `<input>` Elemente, wie z.B. das `<input type="password">` mit einem Shadow-DOM ausgestattet [citeulike:13851424].

![Bild: input type='password' Element](images/2-shadow-dom-input-type-password.jpg "input type='password' Element. Quelle: Selbst erstellt")


## Shadow DOM nach W3C

![Bild: Shadow DOM und Shadow Boundary nach W3C](images/2-shadow-dom-shadow-boundary.png "Shadow DOM und Shadow Boundary nach W3C. Quelle: http://www.sitepoint.com/the-basics-of-the-shadow-dom/")

Wie auf Abbildung X zu sehen, liegt der Shadow DOM dabei parallel zu dem DOM Knoten des beinhaltenden Elementes. Ein Knoten im Document tree (links) wird als Shadow DOM beihaltendes Element (shadow host) markiert. Die gestrichelte Linie zeigt die Referenz zu der entsprechenden Shadow DOM Wurzel, dem "shadow root". Die Referenz geht dabei durch die sogenannte "Shadow Boundary", welche es ermöglicht, den Shadow DOM, und alles was dieser beinhaltet, zu kapseln [citeulike:13851350]. Die Kapselung des Shadow DOM mittels der Shadow Boundary verhindert, dass CSS oder JavaScript in den Shadow DOM das interne CSS oder JavaScript beeinflusst, und andersrum. Ein Element kann auch mehrere Shadow DOM Wurzeln referenzieren, allerdings wird nur die zuletzt hinzugefügte vom Browser gerendert, da dieser zum Rendern einen LIFO Stack benutzt. Dabei wird der zuletzt hinzugefügte Shadow Tree "youngest tree" genannt, der jeweils zuvor hinzugefügte Shadow Tree wird "older tree" genannt. Das dynamische hinzufügen von Shadow DOMs ermöglicht es, die Inhalte der Webseite dynamisch, nach dem rendern zu ändern.


## Content Projection

Neben dem vom Shadow DOM vorgegebenen HTML, können auch Inhalte aus dem Light DOM, den DOM des Dokumentes, in den Shadow DOM projiziert werden. Der Shadow DOM nimmt dabei die zu projizierenden Inhalte und projiziert sie an der vorgegebenen Stelle im Shadow DOM. Die Inhalte bleiben dabei an der ursprünglichen Stelle im DOM stehen und werden nicht verschoben, gelöscht oder geändert. Der Shadow DOM ermöglicht es somit eigenes, gekapseltes HTML, sowie dynamische Inhalte des Light DOM anzuzeigen. Diese Projektion der Inhalte aus dem Light DOM in den Shadow DOM erfolgt mittels sogenannten "Insertion Points". Diese sind vom Entwickler definierte Stellen oder Punkte im Shadow DOM, in welche der Inhalt projiziert wird. Es kann hierbei zwischen zwei Arten von Insertion Points unterschieden werden.


### Insertion Points

Um das zu präsentierende HTML und den Inhalt zu trennen, wird ein `<template>` Tag benutzt. Dieses beinhaltet das komplette Markup, das im Shadow DOM stehen und nicht nach außen sichtbar sein oder von CSS oder JavaScript von außen manipuliert werden soll. Um nun Inhalte aus dem Light DOM in den DOM des `<template>`-Tags zu projizieren, muss das `<template>`-Tag einen `<content>`-Tag beinhalten, in dem die Inhalte von außen dargestellt werden sollen. Mittels `createShadowRoot()` wird das ausgewählte Element zu einem ein Shadow Host, also dem Shadow DOM beinhaltendem Element gemacht. Der Inhalt des Templates wird geklont und dem Shadow Host angehängt. Der Shadow DOM projoziert nun alle Inhalte des Shadow Roots in den `<content>`-Tag [citeulike:13851404].

```html
<div id="shadow">Content</div>
<template id="myTemplate">
  <div class"hiddenWrapper">
    <content></content>
  </div>
</template>
```

```javascript
var shadow = document.querySelector('#shadow').createShadowRoot();
var template = document.querySelector('#myTemplate');
var clone = document.importNode(template.content, true);
shadow.appendChild(clone);
```

Im Light DOM gerendert wird dabei nur der Text "Content" des divs mit der id "shadow", der Wrapper um das `<content>` Tag wird nicht gerendert, da dieser im Shadow DOM steht. Somit wurde eine Trennung des präsentierenden HTML und dem Inhalt erreicht, die Präsentation erfolgt im Shadow DOM, der Inhalt steht im Light DOM. Werden nun mehrere HTML Elemente oder Knoten in den Shadow DOM projiziert, werden diese "Distributed Nodes" genannt. Diese Distributed Nodes sind nicht wirklich im Shadow DOM, sondern werden nur in diesem gerendert, das bedeutet, dass sie auch von außen gestylt werden können, mehr dazu im Abschnitt "Styling mit CSS". Des Weiteren können auch nur bestimmte Elemente in den Shadow DOM projiziert werden, ermöglicht wird dies mit dem Attribut `select="selector"` des `<content>` Tags. Dabei können sowohl Namen von Elementen, als auch CSS Selektoren verwendet werden [citeulike:13851402]. Der Inhalt des `<content>`-Tags können mit JavaScript nicht traversiert werden, beispielsweise gibt `console.log(shadow.querySelector('content'));` `null` aus. Allerdings ist es erlaubt die Distributed Nodes, mittels `.getDistributedNodes()` auszugeben. Dies lässt darauf schließen, dass der Shadow DOM nicht als Sicherheits-Feature angedacht ist, da die Inhalte nicht komplett isoliert sind.


### Shadow Insertion Points

Neben den Insertion Points für Inhalte, also dem `<content>` Insertion Point, gibt es auch Insertion Points für andere Shadow DOMs, die `<shadow>` Insertion Points, welche Shadow Insertion Points genannt werden. Shadow Insertion Points sind, ebenso wie Insertion Points, Platzhalter, doch statt einem Platzhalter für den Inhalt eines Hosts, sind sie Platzhalter für Shadow DOMs. Falls jedoch mehrere Shadow Insertion Points in einem Shadow DOM sind, wird nur der erste berücksichtigt, die restlichen werden ignoriert. Wenn nun mehrere Shadow DOMs projiziert werden sollen, muss im zuletzt hinzugefügten Shadow DOM (younger tree) ein `<shadow>` Tag stehen, dieser rendert den zuvor hinzugefügten Shadow DOM (older tree), somit wird eine Shadow DOM Schachtelung ermöglicht [citeulike:13851421].


## Styling mit CSS

Eines der Hauptfeatures des Shadow DOM ist die Shadow Boundary, welche Kapselung von Stylesheets standardmäßig mit sich bringt. Sie gewährleistet, dass Stylings des Light DOM nicht in den Shadow DOM rein kommen und anders rum. Dies gilt jedoch nur für die Präsentation des Inhalts, nicht für den Inhalt selbst, welcher über den ::slotted CSS-Pseudoselektor angesprochen werden kann. Nachfolgend wird auf die wichtigsten Selektoren für das Styling eingegangen.


### :host

Das Host-Element des Shadow DOM kann mittels dem Pseudoselektor *:host* angesprochen werden. Dabei kann dem Selektor optional auch ein Selektor mit übergeben werden wie beispielsweise mit :host(.myHostElement). Mit diesem Selektor ist es möglich nur Hosts anzusprechen, welche diese Klasse haben. Zu beachten ist, dass das Host Element von außen gestylt werden kann, also die Regeln des :host Selektors überschreiben kann. Des Weiteren funktioniert der :host Selektor nur im Kontext eines Shadow DOM, man kann ihn also nicht außerhalb benutzen. Besonders wichtig ist dieser Selektor, wenn auf die Aktivität der Benutzer reagiert werden muss. So kann innerhalb des Shadow DOMs angegeben werden, wie das Host Element beispielsweise beim Hovern mit der Maus auszusehen hat.

### :host-context()



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
      Der Entwickler kann nun von außen die Variablen instanziieren mit

      ```CSS
      #host {
        --button-theme-color: red;
        --button-theme-font:  Arial;
      }
      ```
  - Mit ::shadow und >>> können native Elemente, die einen Shadow DOM benutzen, gestyled werden, wie z.B. `<video>` oder `<input>` Elemente
  - Jedoch sprengt das das Prinzip der Kapselung, das man mit Web Components versucht zu gewinnen, jedoch sollten Web Entwickler natürlich dennoch die Möglichkeit haben, fremde Components zu stylen, wenn sie wissen was sie machen.
- Alles wird durch Polyfills abgedeckt

[citeulike:13851421], [citeulike:13851334]


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

![Bild: Shadow DOM Beispiel](images/2-shadow-dom-beispiel.jpg "Shadow DOM Beispiel. Quelle: Selbst erstellt")

- Hier sind einige Dinge anzumerken:
  + Es werde per select im `<content>` nur die divs aus dem Shadow Root mit der ID "hello" gerendert, der Paragrapg mit der ID "hidden wird nicht gerendert
  + Die CSS Regel `.content { background-color: khaki; }` des HTML Dokumentes greift nicht durch die Shadow Boundary
  + Die CSS Regel `.styled { color: green; }` greift, da der div mit der Klasse ".styled" in den Light DOM projiziert wird
  + Innerhalb des Templates können CSS Regeln für die beinhaltenden Elemente definiert werden


## Browserunterstützung

Der Shadow DOM ist noch nicht vom W3C standardisiert, sondern befindet sich noch im Status eines "Working Draft" [citeulike:13879687]. Er wird deshalb bisher nur von Google Chrome ab Version 43 und Opera ab Version 33 nativ unterstützt.

![Bild: Shadow DOM Browserunterstützung](images/2-shadow-dom-browserunterstuetzung.jpg "Shadow DOM Browserunterstützung. Quelle: http://caniuse.com/#search=shadow%20dom")

[Can I Use 2015]


## Quellen

- [citeulike:13851424] Jarrod Overson & Jason Strimpel, Developing Web Components, O'Reilly 2015, S.109-126
- [citeulike:13851334] Rob Dodson, Shadow DOM CSS Cheat Sheet, 2014, http://robdodson.me/shadow-dom-css-cheat-sheet/
- [citeulike:13851350] Colin Ihrig, The Basics of the Shadow DOM, 2012, http://www.sitepoint.com/the-basics-of-the-shadow-dom/
- [citeulike:13851404] Dominic Cooney, Shadow DOM 101, 2013, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/
- [citeulike:13851421] Eric Bidelman, Shadow DOM 201, 2014, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-201/
- [citeulike:13851402] Eric Bidelman, Shadow DOM 301, 2013, http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-301/
- [Can I Use 2015] Can I Use, http://caniuse.com/#search=shadow%20dom
- [citeulike:13879687] W3C Shadow DOM ,http://www.w3.org/TR/shadow-dom/
