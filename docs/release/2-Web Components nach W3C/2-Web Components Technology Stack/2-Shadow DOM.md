# Shadow DOM

- TODO:
  - Einführung
  - Content projecting mehr Inhalt
  - Beispiel

- Ausformulieren:
  - Complete


## Einführung

- Der Shadow DOM ist ein Sub-DOM unterhalb einem HTML Element, der es ermöglicht, HTML und CSS in sich zu kapseln und zu verstecken
- Wird Shadow DOM wird bereits in HTML5 standardmäßig eingesetzt, z.b. in dem `<video>` Tag. Beim Inspizieren wird deutlich, dass das `<video>` Tag einen Shadow DOM beinhaltet, welcher die Steuerelemente des Videos erzeugt
- Ebenso sind die verschiedenen `<input>` Elemente, wie z.B. das `<input type="password">` mit einem Shadow-DOM ausgestattet:
![Bild eines input type="password"](https://github.com/Glur4k/BATHWebComponents/blob/master/app/images/input_type_password.jpg)
- Bild von W3C mit dem Light DOM, Shadow DOM und der Boundary
- Shadow DOM liegt neben dem Light DOM


## Content projecting

### Insertion Points
- Nodes die aus dem Host ein den Shadow Tree projiziert werden heißen "distributed nodes"
- HTML Elemente, die via `<content>` und `<content select="element">` in den Light DOM "durchgereicht" werden, können somit auch von außen gestyled werden (zusätzlich auch via ::content - siehe "Styling mit CSS")

### Shadow Insertion Points
- Man kann mehrere Shadow Roots einem Shadow Host hinzufügen, allerdings wird nur der letzte (younger tree) gerendert (LIFO rendering)


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


## Beispiel eines Shadow DOMs mit Template und CSS Styles


## Browserunterstützung

- Noch nicht standardtisiert, sind noch ein Working Draft (http://www.w3.org/TR/shadow-dom/)
- Deshalb bisher auch nur in Chrome und Opera unterstützt

![Bild: Shadow DOM Browserunterstützung](2-Shadow-dom_browserunterstuetzung.jpg "<Beschreibung>. Quelle: http://caniuse.com/#search=shadow%20dom")

[Can I Use 2015]


## Quellen
- http://robdodson.me/shadow-dom-css-cheat-sheet/
- [Can I Use 2015] Can I Use, http://caniuse.com/#search=shadow%20dom
