CustomElementProto.createdCallback = function() {
  if (this.hasAttribute('theme')) {
    var theme = this.getAttribute('theme');
    this.setTheme(theme);
  } else {
    this.setTheme(this.theme);
  }
};

CustomElementProto.attributeChangedCallback = function(attr, oldVal, newVal) {
  if (attr === 'theme') {
    this.setTheme(newVal);
  }
};
