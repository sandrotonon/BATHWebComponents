Polymer({
  is: 'my-element',
  listeners: {
    'down': 'startFunction',
    'up': 'endFunction'
  },
  startFunction: function() { ... },
  endFunction: function() { ... }
});
