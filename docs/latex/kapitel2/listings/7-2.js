CustomElementProto.setTheme = function(val) {
  this.theme = val;
  this.outer.className = "outer " + this.theme;
};
