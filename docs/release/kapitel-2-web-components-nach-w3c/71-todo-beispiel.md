```html
<script>
  // Refers to the "importee", which is index.html
  var importDoc = document.currentScript.ownerDocument;

  // Fires when an instance of the element is created
  CustomElementProto.createdCallback = function() {

    // Creates the shadow root
    var shadow = this.createShadowRoot();

    // Gets content from <template>
    var template = importDoc.querySelector('#myElementTemplate').content;

    // Adds a template clone into shadow root
    shadow.appendChild(template.cloneNode(true));
  };

  // Registers <custom-element> in the main document
  document.registerElement("custom-element", {
    prototype: CustomElementProto
  });
</script>
```html
