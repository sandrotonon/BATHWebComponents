# Polymer-Notizen

## Polymer's Kernfunktionen

- Declarative element registration: <polymer-element>
- Declarative inheritance: <polymer-element extends="...">
- Declarative two-way data-binding: <input id="input" value="{{foo}}">
- Declarative event handlers: <button on-click="{{handClick}}">
- Published properties: xFoo.bar = 5 <-> <x-foo bar="5">
- Property change watchers: barChanged: function() {...}
- Automatic node finding: this.$.input.value = 5

Quelle: https://html5-demos.appspot.com/static/polymer/index.html#30
