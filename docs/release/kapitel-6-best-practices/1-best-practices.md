# Polymer Best Practices

- TODO:
  - Wie in Abschnitt 3.2.X - Shadow DOM gezeigt wird
  - (siehe Abschnitt 3.2.3 - Events)
  - (siehe Abschnitt 3.2.1 - Custom Elements - hostAttributes)

In den vorherigen Kapiteln wurde gezeigt was Polymer an Mehrwert für die Entwickler bringt und wie die Bibliothek eingesetzt wird. In diesem Kapitel werden UI Performance Patterns für eine möglichst performante Applikation und das Gesture System erläutert, sowie von Polymer bereitgestellte Mittel für eine möglichst barrierefreie Applikation gezeigt.


## UI Performance Patterns

Applikationen und Webseiten in dem modernen Web müssen möglichst schnell Laden, sowie ein flüssiges Arbeiten ermöglichen, damit sie von den Benutzern akzeptiert und genutzt werden. In Abbildung X wird deutlich, dass Applikationen mit einer Ladezeit von ca. 1000 Millisekunden oder mehr sich negativ auf die Zufriedenheit der Nutzer auswirken [citeulike:13262776].

![Bild: Verschiedene Wahrnehmung der Benutzer bei unterschiedlichen Ladezeiten](images/1-performance-user-perception-reaction-times.jpg "Verschiedene Wahrnehmung der Benutzer bei unterschiedlichen Ladezeiten")


### Ladezeiten und initiales Rendern optimieren

Ohne ein besonderes Augenmerk auf die Performanz zu werfen bleibt die Seite oder die Applikation beim initialen Laden sehr lange weiß und der Benutzer sitzt vor einem weißen Bildschirm. Wenn alle Ressourcen fertig geladen wurden, wird der Inhalt dann plötzlich und unerwartet eingeblendet. Das erste blockierende Element sind bereits die webcomponents.js Polyfills, da diese in einem `<script>` Tag stehen und somit sequenziell geladen werden müssen und die Ladezeit verlängern. Dies kann jedoch verhindert werden, indem dem Tag das `async` Attribut hinzugefügt wird `<script src="webcomponents.js" async></script>`, alle anderen Ressourcen können dann asynchron geladen werden und die Applikation muss nicht auf die Polyfills warten. Um die Ladezeit weiter zu verkürzen, kann mittels einer JavaScript Überprüfung ermittelt werden, ob die Polyfills optional geladen werden müssen (Lazy Load) wenn diese vom Browser nicht unterstützt werden.
```
var webComponentsSupported = ('registerElement' in document
     && 'import' in document.createElement('link')
     && 'content' in document.createElement('template'));
```

Neben den Polyfills blockieren importierte HTML Dateien, also andere Komponenten, zwar nicht das Laden der Applikation, jedoch dessen Rendern, da diese selbst wiederum sowohl `<script>` Tags als auch Stylesheets beinhalten. Diese blockieren ebenso das Rendern der Webseite, da der Browser die importieren CSS Dateien erst parsen muss. Hier kann ebenfalls das `async` Attribut gesetzt werden um dieses Problem zu lösen. Somit wird die Webseite sofort nach dem Laden aller Ressourcen gerendert, jedoch auch ohne Anwendung der Style-Regeln. Der hierdurch entstehende FOUC muss also manuell verhindert werden, indem grobe Container in einem `<style>` Tag für das ungefähre Aussehen der Applikation definiert werden. Dadurch werden die Komponenten nach und nach in die Container geladen, es wird somit sofort eine Vorschau der Applikation angezeigt und die Applikation schnell geladen [citeulike:13915203].


### Optimierungen für eine flüssige Applikation

Wie in Abschnitt 3.2.X - Shadow DOM gezeigt wird, implementiert Polymer eine eigene Version des Shadow DOMs, den Shady DOM, um eine möglichst breite Browserunterstützung zu gewährleisten. Im Gegensatz zum Shadow DOM, welcher im Kontext der Browser in der Programmiersprache C++ programmiert ist, ist der Shady DOM nur eine Nachbildung dessen und in JavaScript programmiert. Somit ist dieser schon auf Plattform-Ebene langsamer Zusätzlich ist das Scoping, sowie das Rendern im nativen Shadow DOM einiges schneller. Es wird also vor dem Einbinden von Polymer empfohlen, zu prüfen ob der Shadow DOM oder der Shady DOM verwendet werden soll, was mit der Anweisung `window.Polymer = window.Polymer || {dom: 'shadow'};` erreicht werden kann.
Um eine schnelle Reaktionszeit der App zu gewährleisten, sollten statt Click-Events immer die Touch-Events verwendet werden (siehe Abschnitt 3.4.2 - Gesture System), da Click-Events eine Zeitverzögerung von 300 Millisekunden haben, bevor diese tatsächlich abgefeuert werden. Dies wird von den Browserherstellern so implementiert, da die Browser bei Click-Events zu erst prüfen müssen ob das Event wirklich von einem Click ausgelöst wurde oder ob es von einem Touch ausgeführt wurde.
Des Weiteren sollten nicht benötigte Elemente nur dann tatsächlich gerendert werden, wenn diese auch wirklich im Viewport des Browsers zu sehen sind (Lazy Render). Wird dies nicht gemacht, werden alle Elemente beim initialen Laden der Seite gerendert, was die Applikation bei mehreren Tausend Elementen oder mehr sehr träge machen kann. So setzt beispielsweise die `<iron-list>` Komponente von Polymer diese Technik um, indem es nur die Elemente in den DOM lädt, welche aktuell sichtbar sein müssen. Ebenso wird der lokale DOM des `dom-if` Template `<template is='dom-if' if='{{open}}'>` nur dann generiert und gerendert, wenn das Element aktiv ist, also wenn `open` den Wert true annimmt. Dies kann unter Anderem bei Dropdown Elementen oder Akkordeon-Menüs umgesetzt werden. Um zu prüfen wie viele Polymer Komponenten aktuell auf der Seite im DOM stehen und Informationen über dessen Performanz zu erhalten stellt Polymer die "Polymer DevTools Extension" Erweiterung für den Chrome Browser zur Verfügung [citeulike:13915202].


## Gesture System

Wie bereits in dem vorangegangenen Abschnitt angeschnitten wird, sind flüssige Reaktionen auf Aktionen der Benutzer sehr wichtig für gute Applikationen. Um den Umgang mit Input auf verschiedenen Devices zu vereinfachen stellt Polymer das Gesture System bereit [citeulike:13915222]. Dieses vereinheitlicht die diversen Eingabemöglichkeiten von Desktops, Smartphones bzw. Tablets und Uhren, welche sich mit Maus und Touch unterschiedlich verhalten. Statt dass Entwickler beide Eingabearten gesondert implementieren müssen, kümmert sich das Polymer Gesture System automatisch darum indem es die Events von Maus und Touch in 4 einheitliche, für alle Plattformen gleiche, vereint. Diese sind das `down & up`, `tap` und das `track` Event, welche konsistent auf Touch und Klick Umgebungen ausgelöst werden und statt den spezifischen Klick und Touch Event Gegenstücken benutzt werden sollten. Um ein Element auf eines der Touch Events hören zu lassen, kann entweder die imperative oder die deklarative Methode zum Hinzufügen von Events gewählt werden (siehe Abschnitt 3.2.3 - Events). Die Events können dem Polymer Prototyp in dem `listeners` Objekt hinzugefügt werden, wie anhand des Beispiels im folgenden Abschnitt verdeutlicht wird.


**Down & up**

Die `down` und `up` Events werden ausgelöst, wenn der Finger oder die Maus auf das Element drückt oder es loslässt. Sie bilden einfachsten Gesten des Gesture Systems, sind aber bei den meisten Anforderungen ausreichend. Diese Events können beispielsweise dazu eingesetzt werden um zu visualisieren welches Element gerade berührt oder geklickt wird. Ohne die `down` und `up` Events müssten die vier nativen Events `touchstart`, `touchend`, `mousedown` und `mouseup` implementiert werden. Dabei hören die Touch Events nur auf das berührte Element, die Maus Events ändern ihr Ziel beim Bewegen des Mauszeigers, weshalb auf das gesamte Dokument gehört werden muss um auf das `mouseup` Event zu warten, was besonders beim Scrollen zu Komplikationen führen kann. Mit Polymer sind hierfür nur die beiden Events `down` und `up` notwendig, wie im folgenden Beispiel dargestellt.

```
Polymer({
    is: 'my-element',
    listeners: {
        'down': 'startFunction',
        'up': 'endFunction'
    },
    startFunction: function() { ... },
    endFunction: function() { ... }
});
```


**Tap**

Das `tap` Event verbindet die `down` und `up` Events und stellt ein Event für das Auswählen und Drücken eines Elements auf allen Devices dar. Es funktioniert dabei gleich für Maus und Touch, wobei sich das Gesture System intern um die Plattform Unterschiede kümmert. Das `tap` Event ist das am meisten benutzte Event, da die häufigsten Aktionen der Benutzer der `tap` bzw. der `click` sind.


**Track**

Das `track` Event ist eine Erweiterung des `tap` Events und wird ausgelöst, wenn der Finger oder die Maus beim Drücken eines Elements bewegt wird. Es kommt bei allen Aktionen zum Einsatz, bei denen D&D benötigt wird. D&D kann bei der Maus auf native Weise mit der HTML5 API realisiert werden, jedoch haben viele Plattformen wie Smartphones oder Uhren Touch Events, wofür die API nicht ausgelegt ist. Dadurch funktioniert es nicht immer mit dem gewünschten Verhalten und ist nur kompliziert manuell zu implementieren. Das `track` Event soll hier Abhilfe schaffen und das D&D einfacher relaisierbar machen, wobei auf einige Punkte geachtet werden muss. 
Werden Elemente mit dem `track` Event Listener ausgestattet, so verhindern diese standardmäßig das Scrollen, da bei Touch Geräten zwischen Scrollen und Draggen unterschieden werden muss. Beim Initialisieren des Elements muss anschließend die Scroll-Funktion wiederhergestellt mittels `this.setScrollDirection(direction, node);` werden. Wird für den Parameter `direction` der wert `'y'` angegeben, so kann über dem Element auf der vertikalen Achse gescrollt werden, wobei das Draggen des Elements in horizontaler Achse möglich ist. Für den `node` Parameter wird hier standardmäßig `this` übergeben, also das auf `track` zu überwachende Element. Wird das `track` Event registriert, so kann es auf drei verschiedene Status aufgeschlüsselt werden: `start` `track` und `end`. Für jeden der Status kann dann das entsprechend gewünschte Verhalten definiert werden.


## A11y - Barrierefreiheit in Polymer

>The Web is an increasingly important resource in many aspects of life: education, employment, government, commerce, health care, recreation, and more. It is essential that the Web be accessible in order to provide equal access and equal opportunity to people with disabilities. An accessible Web can also help people with disabilities more actively participate in society. [citeulike:13915280]

Barrierefreiheit ist besonders im öffentlichen Sektor sehr wichtig, weshalb sie auch bei Polymer eine große Rolle spielt, so werden die gesamten UI Elemente, die Paper Elemente, sukzessive barrierefrei neu implementiert. Auch bieten die Iron Elemente Behaviors für die Barrierefreiheit an (die Accessibility Behaviors), welche von Custom Elements importiert werden können und das Programmieren von barrierefreien Elementen vereinfachen. Wenn Barrierefreiheit komplett unabhängig von Behaviors erreicht werden soll, bietet sich das Polymer `hostAttributes` Objekt an (siehe Abschnitt 3.2.1 - Custom Elements - hostAttributes). Um die Applikation auf verschiedene Faktoren, welche nachfolgend erläutert werden [citeulike:13915273], bezüglich Barrierefreiheit zu überprüfen, bietet Polymer das "Accessibility Developer Tools" Plugin für den Chrome Browser an. Dieses weist auf verschiedene Probleme bezüglich der Barrierefreiheit einer Webseite hin, bietet einen erweiterten Inspector für Accessibility Eigenschaften von Elementen an und kann diverse Tests ausführen um die Applikation zu analysieren.


**Fokus / Tastatur**

Der erste Punkt, der eine barrierefreie Applikation auszeichnet ist die Bedienbarkeit dessen mit einer Tastatur. So müssen alle Elemente, die eine Interaktion erlauben, mit der Tastatur mittels der Tab- oder den Pfeil-Tasten erreichbar sein. Dies muss gewährleistet werden, wenn die Benutzer nicht in der Lage sind eine Maus zu benutzen, oder wenn sie nur eine Tastatur benutzen wollen. Um dies zu erreichen, kann das `tabindex` Attribut deklarativ für die Elemente definiert werden. Es kann dabei drei verschiedene Werte annehmen:

- -1, es kann fokussiert werden, aber nicht in einer speziellen Reihenfolge im Kontext der umliegenden Elemente
- 0, das Element kann in der normalen Reihenfolge des DOMs fokussiert werden
- > 0 das Element kann in einer selbst definierten Reihenfolge fokussiert werden

Der Wert `> 0` sollte allerdings in dem lokalen DOM einer Komponente vermieden werden, da nicht gesagt werden kann in welcher Reihenfolge das Element auf der einbindenden Webseite zum Einsatz kommt. Alternativ zu der deklarativen Definition des `tabindex` Attributs, kann es auch in dem Polymer `hostAttributes` Objekt definiert werden wie im Beispiel einer barrierefreien Komponente in Zeile 15 dargestellt. Nachdem gewährleistet wird, dass das Element mit der Tastatur erreichbar ist, muss dies visuell dargestellt werden. Hierfür kann in den Styles des Elements die Pseudoklasse `:focus` definiert werden, wie im Beispiel einer barrierefreien Komponente in Zeile 5, oder alternativ das Behavior `PaperInkyFocusBehavior` dem Element hinzugefügt werden. Muss das Element nun eine Interaktion mit einer bestimmten Taste bereitstellen, so bietet Polymer hierfür das Iron Element `iron-a11y-keys-behavior` an, welches ein Mix-in für Tastatur Interaktionen darstellt. Es abstrahiert mit einer einfachen Syntax die Unterschiede der Implementierungen von Tastatureingaben der verschiedenen Browser.


**Semantik**

Der zweite Punkt ist der korrekte Einsatz der HTML Elemente innerhalb der eigenen Komponenten. So bietet HTML über 100 Elemente an, mit denen der Inhalt semantisch strukturiert werden kann. Benutzer mit eingeschränktem Sehvermögen benutzen häufig unterstützende Technologien wie Screenreader, welche Benutzern den Inhalt der Webseite vorlesen. Wird die Webseite nun aus nur zwei unterschiedlichen HTML Tags aufgebaut, z.B. dem `div` oder `span` Tag, kann der Benutzer sich nicht in der Webseite orientieren. Die Screenreader oder andere AT legen hierbei für jedes Element einen Accessibility Node im Accessibility Tree an [citeulike:13915306]. Dieser Knoten kann die ARIA Attribute `role`, `value`, `state` und `properties` haben, welche von Custom Elements deklarativ definiert werden sollten. Die entsprechenden Werte werden für die nativen HTML Elemente vom W3C definiert. Ebenso wie der `tabindex` können die ARIA Attribute im `hostAttributes` Objekt definiert werden, wie im Beispiel einer barrierefreien Komponente in Zeile 16. Wenn der Screenreader ein ihm unbekanntes Element findet und diese Attribute nicht definiert sind, wird standardmäßig die Rolle `group` angenommen, beim Vorlesen des Elementes bekommt der User also nur `group` zu hören und weiß somit nicht was das Element semantisch darstellt. Falls das Custom Element keinen Text beinhalten, keine sichtbare Beschreibung haben oder nur als Interaktions-Mittel bezüglich eines anderen Inhaltes dienen sollte, wie z.b. eine Checkbox oder ein Input-Feld, ist es wichtig ein ARIA `label` oder `labelledby` zu definieren, welches jenen Inhalt definiert, wie Beispiel einer barrierefreien Komponente in Zeile 9 dargestellt.


**Flexibles UI**

Der letzte Punkt ist das erstellen einer UI, welche sich flexibel an die Bedürfnisse der Benutzer anpassen lässt, oder für Benutzer mit einer Farbschwäche angepasst ist. So sollten Farben nicht als einziges Medium zum Übertragen von Informationen dienen, stattdessen sollte eine weitere Farben-unabhängige Darstellung gewählt werden, wie beispielsweise ein Hinweistext bei einem falsch ausgefüllten Input-Feld. Abgesehen von Farbtönen können User auch Probleme mit der Farbintensität haben, verschiedene Grautöne könnten somit nicht mehr wahrgenommen werden können. Deshalb sollte immer ein ausreichend großer Kontrast zwischen der Darstellung der Information und dem Hintergrund gewählt werden.

>Contrast (Minimum): The visual presentation of text and images of text has a contrast ratio of at least 4.5:1` [citeulike:13915310]

Darüber hinaus müssen Benutzer mit einer schwachen Sehstärke die Webseite unter Umständen vergrößern können um sie lesen zu können. Es sollte deshalb immer gewährleistet werden, dass die Seite auch bei einem Zoom-Faktor größer 100 korrekt dargestellt wird.


**Beispiel einer barrierefreien Komponente**

Das folgende Beispiel stellt die in diesem Abschnitt erklären Methoden zum Erstellen einer barrierefreien Komponenten dar.

```
<link rel="import" href="../iron-a11y-keys-behavior.html">
<dom-module id="my-element">
    <template>
        <style>
            :host:focus #element {
                boder: 1px solid red;
            }
        </style>
        <div id="element" aria-label="Impoartant article">Some important text</div>
    </template>
    <script>
        Polymer({
            is: 'my-element',
            hostAttributes: {
                tabindex: '0',
                role: 'article',
            },
            keyBindings: {
                'space enter': '_action'
            },
            _action: function(event) { ... }
        });
    </script>
</dom-module>
```

