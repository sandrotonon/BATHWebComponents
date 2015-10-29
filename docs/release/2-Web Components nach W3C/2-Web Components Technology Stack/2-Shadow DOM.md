# Shadow DOM

-- TODO: complete

Wichtig: http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/

## Einführung
- Shadow DOM Beispiel mit einem &lt;input type="password"&gt; bei dem man im Shadow DOM den plaintext sieht

## Insertion Points
- HTML Elemente, die via &lt;content&gt; und &lt;content select="element"&gt; in den Light DOM "durchgereicht" werden, können somit auch von außen gestyled werden (zusätzlich auch via ::content - siehe "Styling mit CSS")

## Styling mit CSS
- Shadow Boundary: Styles gehen nicht aus Shadow Dom raus, und keine rein.
  -> Style Kapselung out of the Box!
- Styling des host-elements mit :host selector
  -> Allerdings überschreiben die inneren Styles nicht die Inneren!
  (Siehe snippets/shadow-dom/#styling)
  -> Wichtig bei "Reacting to user states"
- Styling des Hosts in abhängigkeit des Kontextes mit :host-context
  (https://drafts.csswg.org/css-scoping/#selectordef-host-context)
  z.b. :host-context(.wrapper)
- Styling des Shadow DOM von außerhalb
  - ::shadow
    - z.b.: my-element::shadow .content {} spricht .content elemente IN einem Shadow DOM an
    - Styles alle elemente in DIESEM Shadow DOM
  - >>> (ehem. /deep/)
    (https://drafts.csswg.org/css-scoping-1/#deep-combinator)
    - z.b.: my-element >>> .different spricht ALLE .different Elemente in my-element an, egal wieviele Shadow DOMS noch darunter geschachtelt sind
    - So können z.b. "Style-hooks" erzeugt werden, die es Entwicklern ermöglicht eigene Styles auf ein Component zu binden
      some-element >>> .custom-theme { ... }
  - ::slotted (ehem. ::content)
    (http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom-201/#toc-distributed)
    - Elemente, die in ein &lt;content> projiziert werden, können auch von innen gestyled werden
      z.b. (in einer Komponente):
          ::content p {
            color: red;
          }
      spricht alle &lt;p>s in einem &lt;content>-Tag an, die in dem Light DOM projiziert werden.
  - CCS Variablen
    (http://dev.w3.org/csswg/css-variables/)
    - Eine Komponente hält im Inneren Variablen für das Aussehen, somit wir das Styling nach außen gegeben
      z.b.:
          my-button {
            color: var(--button-theme-color, red); (pink wäre default)
            font-family: var(--button-theme-font);
          }
      Der Entwickler kann nun von außen die Variablen instanzieren mit
          #host {
            --button-theme-color: red;
            --button-theme-font:  Arial;
          }
  - Mit ::shadow und >>> können native Elemente, die einen Shadow DOM benutzen, gestyled werden, z.b &lt;video&gt; oder &lt;input&gt; Elemente
  - Jedoch sprengt das das Prinzip der Kapselung, das man mit Web Components versucht zu gewinnen, jedoch sollten Web Entwickler natürlich dennoch die Möglichkeit haben, fremde Components zu stylen, wenn sie wissen was sie machen.
- Alles wird durch Polyfills abgedeckt


## Quellen
- http://robdodson.me/shadow-dom-css-cheat-sheet/