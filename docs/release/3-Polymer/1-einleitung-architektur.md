# Einleitung

    * Polymer Grundsätzliches (Architektur - Native, Polyfills, Polymer.js, Elemente Katalog)

## Polymer Methapher

HTML Standard-Tags sind Atome. Polymer / Web Components bauen Atome zusammen zu Molekülen, den Komponenten
Aus der Verdrahtung der kleinen Teile wird Engineering
Ermöglicht Libraries, Plattformen die wiederverwendbar sind


## Architektur

Siehe Bild mit Layers

- Setzt sich zusammen aus den Schichten `polymer-micro`, `polymer-mini` und `polymer`

Feature layering
EXPERIMENTAL: API MAY CHANGE.

Polymer is currently layered into 3 sets of features provided as 3 discrete HTML imports, such that an individual element developer can depend on a version of Polymer whose feature set matches their tastes/needs. For authors who opt out of the more opinionated local DOM or data-binding features, their element’s dependencies would not be payload- or runtime-burdened by these higher-level features, to the extent that a user didn’t depend on other elements using those features on that page. That said, all features are designed to have low runtime cost when unused by a given element.

Higher layers depend on lower layers, and elements requiring lower layers will actually be imbued with features of the highest-level version of Polymer used on the page (those elements would simply not use/take advantage of those features). This provides a good tradeoff between element authors being able to avoid direct dependencies on unused features when their element is used standalone, while also allowing end users to mix-and-match elements created with different layers on the same page.

polymer-micro.html: Polymer micro features (bare-minimum Custom Element sugaring)

polymer-mini.html: Polymer mini features (template stamped into “local DOM” and tree lifecycle)

polymer.html: Polymer standard features (all other features: declarative data binding and event handlers, property nofication, computed properties, and experimental features)

This layering is subject to change in the future and the number of layers may be reduced.

Polymer micro features
The Polymer micro layer provides bare-minimum Custom Element sugaring.

FEATURE USAGE
Custom element constructor  Polymer.Class({ … });
Custom element registration Polymer({ is: ‘…’, … }};
Custom constructor support  constructor: function() { … }
Basic lifecycle callbacks   created, attached, detached, attributeChanged
Native HTML element extension   extends: ‘…’
Declared properties properties: { … }
Attribute deserialization to property   properties: { <property>: <Type> }
Static attributes on host   hostAttributes: { <attribute>: <value> }
Behaviors   behaviors: [ … ]
Polymer mini features
The Polymer mini layer provides features related to local DOM: Template contents cloned into the custom element’s local DOM, DOM APIs and tree lifecycle.

FEATURE USAGE
Template stamping into local DOM    <dom-module><template>…</template></dom-module>
DOM distribution    <content>
DOM API Polymer.dom
Configuring default values  properties: <prop>: { value: <primitive>|<function> }
Bottom-up callback after configuration  ready: function() { … }

Polymer standard features
The Polymer standard layer adds declarative data binding, events, property notifications and utility methods.

FEATURE USAGE
Automatic node finding  this.$.<id>
Event listener setup    listeners: { ‘<node>.<event>’: ‘function’, … }
Annotated event listener setup  <element on-[event]=”function”>
Property change callbacks   properties: <prop>: { observer: ‘function’ }
Annotated property binding  <element prop=”{{property|path}}”>
Property change notification    properties: { <prop>: { notify: true } }
Binding to structured data  <element prop=”{{obj.sub.path}}”>
Path change notification    set(<path>, <value>)
Declarative attribute binding   <element attr$=”{{property|path}}”>
Reflecting properties to attributes properties: { <prop>: { reflectToAttribute: true } }
Computed properties computed: { <property>: ‘computeFn(dep1, dep2)’ }
Computed bindings   <span>{{computeFn(dep1, dep2)}}</span>
Read-only properties    properties: { <prop>: { readOnly: true } }
Utility functions   toggleClass, toggleAttribute, fire, async, …
Scoped styling  <style> in <dom-module>, Shadow-DOM styling rules (:host, …)
General polymer settings    <script> Polymer = { … }; </script>


### Elemente Katalog

- Iron Elements
- Paper Elements
- Google Web Components
- Gold Elements
- Neon Elements
- Platinum Elements
- Molecules


## Quellen

- https://component.kitchen/blog/posts/an-evaluation-of-polymer-micro-as-a-minimal-web-component-framework
- https://www.polymer-project.org/1.0/docs/devguide/experimental.html
