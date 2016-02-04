MyBehaviors.HelloBehavior = {
  properties: { ... },
  listeners: {
    mousedown: '_sayHello',
  },
  _sayHello: function() {
    alert('Hallo von der anderen Seite!');
  }
}
