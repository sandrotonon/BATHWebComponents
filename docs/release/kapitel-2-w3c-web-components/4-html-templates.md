## HTML Templates

Bisher gibt es ohne eine Library oder Framework keine Möglichkeit, im Browser Templates zu rendern, um bestimmte Inhalte der Seite zur Laufzeit auszuwechseln. Die Technologie "HTML Templates" ist eine neue Technologie im Rahmen der Web Components und versucht eben dieses Problem mit einer nativen API zu lösen. 

Im Kontext der Entwicklung einer MVC-Applikation ist der Mechanismus der Darstellung der Präsentations-Schicht, also dem View, besonders wichtig. Bisher ist dies ohne weiteres problemlos serverseitig in PHP, Ruby oder ähnlichem möglich, da diese Sprachen für die Webentwicklung eine Syntax für die Einbettung dynamischer Inhalte in HTML bieten, die sogenannten Templates. Im Gegensatz zu den serverseitigen Technologien, existieren Client-seitige Lösungen bisher nur als Library oder Framework, wie beispielsweise Mustache.js oder Handlebars.js [citeulike:13853015]. Eine native Möglichkeit, Templates auf der Client-Seite zu benutzen, fehlt bisher hingegen. An diese Problematik setzen die HTML Templates an, durch welche diese Technik auch Einzug in den Browser erhält.

> Das HTML template-Element <template> dient dazu, Client-seitige Inhalte zu gruppieren, die nicht gerendert werden, wenn die Seite geladen wird, sondern anschließend zur Laufzeit mittels JavaScript gerendert werden können. Template kann als Inhaltsfragment aufgefasst werden, das für eine spätere Verwendung im Dokument gespeichert wird. [citeulike:13852997]


### Bisherige Umsetzung von Templates im Browser

Dennoch gibt es diverse Methoden, diese Technologie im Browser zu simulieren. Diese sind jedoch eher als Hacks zu betrachten, da ihre eingesetzten Mittel nicht für dieses Problem gedacht sind. Sie bringen also einige Nachteile mit sich. Einige dieser Methoden werden nachfolgend aufgezeigt [citeulike:13853018].


**Via verstecktem `<div>`-Element**

Das folgende Beispiel zeigt die Umsetzung eines Templates mit Hilfe eines `<div>`-Blocks, der via CSS versteckt wird.

```html
<div id="mydivtemplate" style="display: none;">
  <div>
    <img src="myimage.jpg">
  </div>
</div>
```

Der entscheidende Nachteil dieser Methode ist, dass alle Ressourcen, also alle verlinkten Dateien, beim Laden der Webseite auch heruntergeladen werden. Zwar werden sie nicht angezeigt, dennoch verursachen sie eine große Datenmenge, welche initial übertragen werden muss. Dies geschieht in diesem Fall selbst wenn die Ressourcen eventuell erst später oder gar nicht benötigt werden, was eine massive Einschränkung der verfügbaren Bandbreite und Browser-Performance mit sich bringen kann. Des Weiteren kann es sich als schwierig erweisen, ein solches Code-Fragment zu stylen oder gar Themes auf mehrere solcher Fragmente anzuwenden. Eine Webseite, die das Template verwendet, muss alle CSS-Regeln für das Template mit `#mydivtemplate` erstellen, welche sich unter Umständen auf andere Teile der Webseite auswirken können. Eine Kapselung wird hier somit nicht vorgesehen.


**Via `<script>`-Element:**

Eine weitere Möglichkeit ein Template umzusetzen besteht darin, den Inhalt eines Templates in ein `<script>`-Tag zu schreiben.

```html
<script type="text/template">
  <div>
    <img src="myimage.jpg">
  </div>
</script>
```

Wie bei dem Beispiel mit einem `<div>`-Element wird auch bei dieser Methode der Inhalt nicht gerendert, da ein `<script>`-Tag standardmäßig die CSS Eigenschaft `display: none` hat. In diesem Fall werden jedoch die benötigten Ressourcen nicht geladen, somit gibt es keine zusätzlichen Performance-Einbrüche. Es besteht dennoch ein Nachteil, auf den besonders geachtet werden muss: Der Inhalt des `<script>`-Tags muss via `innerHTML` in den DOM geklont werden, was eine mögliche XSS Sicherheitslücke darstellen kann.
Es muss also abgewägt werden, welche der Nachteile für den Entwickler am ehesten hinnehmbar sind und welche Methode verwendet werden soll.


### `<template>`-Tag

Den Problemen der oben genannten Methoden widmet sich der `<template>`-Tag, welcher eine native und sichere Methode für das Einbinden von dynamischen Inhalten etabliert. Das Template und die darin enthaltenen Inhalte werden beim Rendern des Webseite vollständig ignoriert, sie werden weder angezeigt, noch werden ihre benötigten Inhalte beim Laden der Webseite mitgeladen. Ebenso werden enthaltene JavaScripts nicht ausgeführt, auch kann JavaScript von außen nicht in das Template hinein traversieren. Im folgenden wird die grobe Struktur eines einfachen Templates, das mit Hilfe des `<template>`-Tags umgesetzt wird, dargestellt.

```html
<template id="mytemplate">
  <style>
    /* Styles */
  </style>
  <script>
    // JavaScript
  </script>
  <img src="bild.jpg"> <!-- Kann zur Laufzeit dynamisch gesetzt werden -->
  <p class="text">Hier steht ein Text.</p>
</template>
```


### Benutzung

Natürlich soll ein Template nicht nur im Quelltext stehen, damit es existiert, sondern es soll dynamisch zur Laufzeit geladen und gerendert werden. Dabei kann es an einer beliebigen Stelle im Quelltext stehen. Um es aus dem Quelltext in den DOM zu importieren und zu rendern, muss es zunächst via JavaScript selektiert werden, was mit der Funktion `var template = document.querySelector('#mytemplate');` möglich ist. Mit der Funktion `var templateClone = document.importNode(template.content, true);` wird eine Kopie als DOM-Knoten des Templates erstellt. Als erster Parameter wird dabei der Inhalt des Templates (`template.content`) und als zweiter Parameter ein Boolean für `deep`, welcher angibt ob auch Kinderknoten geklont werden sollen. Nun kann der Inhalt des Templates mittels `document.body.appendChild(templateClone);` an einer beliebigen Stelle des DOM eingefügt werden.


### Vorteile

Die Vorteile dieser nativen Implementierung für Templates sind vielfältig. So sind HTML Templates ein fertiges Gerüst an HTML, das nicht nachträglich mit JavaScript modifiziert werden muss, es kann aus dem Quelltext kopiert und beliebig oft und an beliebiger Stelle in den DOM der Webseite eingefügt werden. Erst beim einfügen in den DOM werden die Inhalte tatsächlich gerendert und Abhängigkeiten nachgeladen. Darunter fallen auch enthaltene Styles oder JavaScript-Codes, welche erst beim Einfügen angewendet und ausgeführt werden. So werden auch externe Stylesheets, JavaScript-Dateien oder Bilder und Videos erst dann geladen und abgespielt, wenn sie tatsächlich benötigt werden. Dadurch können auch beliebig viele `<template>`-Tags ohne signifikanten Performance-Einbruch im Quelltext stehen, da nur ihr Markup übertragen wird, es jedoch nicht vom Browser geparst werden muss. Des Weiteren sind Templates komplett vor dem DOM versteckt, will man beispielsweise mit JavaScript in das Template mittels `document.getElementById('#mytemplate .text')` hinein traversieren, so gibt die Funktion `null` zurück. Der abschließende und wohl auch größte Vorteil ist, dass mit JavaScript auf das Template zugegriffen werden und es an anderer Stelle dynamisch eingebunden werden kann.
Falls nun jedoch in einem Template mehrere weitere Templates geschachtelt sind, so muss jedes dieser Templates einzeln aus dem aktiven Template im DOM kopiert und wieder eingefügt werden um es zu aktivieren.


### Browserunterstützung

HTML Templates sind zum Stand dieser Arbeit als einzige Technologie des Web Components Technology Stacks vom W3C als Standard erklärt worden [citeulike:13853159]. Somit ist auch die Browserunterstützung in den aktuellen Browsern, bis auf den Internet Explorer, sehr gut. Sie sind des Weiteren die einzige Technologie der Web Components, die bisher von Microsofts Edge ab Version 13 unterstützt werden.

![Bild: Browserunterstützung des HTML Template Tags](images/4-html-templates-browserunterstuetzung.jpg "Template Tag Browserunterstzützung. Quelle: http://caniuse.com/#search=template")
