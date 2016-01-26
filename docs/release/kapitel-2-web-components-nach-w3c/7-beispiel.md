## Beispielimplementierung einer Komponente mit den nativen Web Component APIs

- TODO: Anhand des Beispiels X

Anhand des Beispiels X sollen die in den vorherigen Abschnitten vorgestellten Technologien zum Implementieren einer Web Komponente verdeutlicht werden.


### Custom Element erstellen

### Template erstellen

### Shadow Dom einbauen

### Element Importieren und verwenden

index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Demo of a Custom Element</title>
  <link rel="import" href="elements/custom-element.html">
</head>
<body>

  <custom-element theme="style1">Reader</custom-element>

</body>
</html>
```


### Code

custom-element.html
```html
<template id="myElementTemplate">
  <style>
    .outer { ... }
    .style1 { color: green; }
    .style2 { color: blue; }
    .name { font-size: 35pt; padding-top: 0.5em; }
  </style>

  <div class="outer">
    Welcome in the Web Component
    <div class="name">
      <content></content>
    </div>
  </div>
</template>

<script>
  // Refers to the "importee", which is index.html
  var importDoc = document.currentScript.ownerDocument;

  // Creates an object based in the HTML Element prototype
  var CustomElementProto = Object.create(HTMLElement.prototype);

  // Creates the "theme" attribute and sets a default value
  CustomElementProto.theme = 'style1';

  // Fires when an instance of the element is created
  CustomElementProto.createdCallback = function() {

    // Creates the shadow root
    var shadow = this.createShadowRoot();

    // Gets content from <template>
    var content = importDoc.querySelector('#myElementTemplate').content;

    // Adds a template clone into shadow root
    shadow.appendChild(content.cloneNode(true));

    // Caches .outer DOM query
    this.outer = shadow.querySelector('.outer');

    // Checks if the "theme" attribute has been overwritten
    if (this.hasAttribute('theme')) {
      var theme = this.getAttribute('theme');
      this.setTheme(theme);
    }
    else {
      this.setTheme(this.theme);
    }
  };

  // Fires when an attribute was added, removed, or updated
  CustomElementProto.attributeChangedCallback = function(attr, oldVal, newVal) {
    if (attr === 'theme') {
      this.setTheme(newVal);
    }
  };

  // Sets new value to "theme" attribute
  CustomElementProto.setTheme = function(val) {
    this.theme = val;
    this.outer.className = this.outer.className + " " + this.theme;
  };

  // Registers <custom-element> in the main document
  document.registerElement("custom-element", {
    prototype: CustomElementProto
  });
</script>
```


### Quellen

- https://github.com/webcomponents/hello-world-element/blob/master/hello-world.html
- https://teamgaslight.com/blog/roll-your-own-html5-web-components-with-vanilla-js
