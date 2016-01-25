# CSS Styling und externe Stylesheets

## Einführung

- Komponenten können CSS Properties (also Variablen) nach außen sichtbar machen, damit diese von außerhalb der Komponente gesetzt werden können um somit das CSS in einer gekapselten Komponente bestimmen zu können
- Hierbei können auch Standardangaben gemacht werden, die von der Komponente übernommen werden, wenn die Variable nicht definiert wird
- Beispiel:

x-element Komponente
```html
<dom-module id="x-element">
  <template>
    <style>
      .x-element-container > button {
        color: var(--x-element-button-color, red);
      }
    </style> 
  </template>
</dom-module>
```

- Das HTML, das die Komponente benutzt kann nun die Variable `--x-element-button-color` instanziieren

```html
<style is="custom-style">
  x-element {
    --x-element-button-color: green;
  }
</style>
```

- Das `is="custom-style"` Attribut des `<style>` Tags ist für den Polyfill, da CSS Properties noch nicht in den Browsern implementiert sind
- Nun soll jedoch nicht für jedes CSS Attribut eine Variable angelegt werden
- Um mehrere CSS Attribute einer Komponente zu ändern können Mixins erstellt werden, welche eine Sammlung an Styles auf eine Komponente anwenden
- Wenn wird das x-element Beispiel erweitert:

```html
<style is="custom-style">
  x-element {
    --x-element-button-color: green;
    --x-element: {
        padding: 10px;
        margin: 10px;
    };
  }
</style>
```

- Um das Mixin auf das x-element anzuwenden, muss im `<style>` des x-element das Mixin via einem `@apply (<mixin-name>);` angegeben werden.
- Somit sieht das x-element Beispiel wie folgt aus:

```html
<dom-module id="x-element">
  <template>
    <style>
      .x-element-container > button {
        color: var(--x-element-button-color, red);

        @apply(--x-element);
      }
    </style> 
  </template>
</dom-module>
```

[Monica Dinculescu 2015]

## Gemeinsame Styles mehrerer Komponenten

- Styling für mehrere Komponenten erfolgt mit sog. `style-modules`
- Externe Stylesheets werden von Polymer ab Version 1.1 nicht mehr unterstützt

[Polymer Developer Guide - Styling local DOM 2015]


### Style Module anlegen

- Will man Styles für mehrere Komponenten erstellen, kann eine Komponente für diesen Zweck angelegt werden. Diese wird von all jenem Komponenten importiert, welche diese Styles benutzen sollen
- Ein Style Module kann dabei folgender Maßen aussehen:

shared-styles.html
```html
<dom-module id="shared-styles">
  <template>
    <style>
      .red { color: red; }
    </style> 
  </template>
</dom-module>
```


### Style Module benutzen

- Damit eine Komponente diese Styles nutzen kann, muss sie zwei Dinge erfüllen:
    + Es muss einen `<link>` Tag definieren, der das Style Module importiert
    + Es muss einen `<style>` Tag definieren, der die Styles an der richtigen Stelle inkludiert

```html
<!-- import the module  -->
<link rel="import" href="../shared-styles/shared-styles.html">
<dom-module id="x-element">
  <template>
    <!-- include the style module by name -->
    <style include="shared-styles"></style>
    <style>:host { display: block; }</style>
    Hi
  </template>
  <script>Polymer({is: 'x-element'});</script>
</dom-module>
```

[Polymer Developer Guide - Styling local DOM 2015]


## Quellen

- [Polymer Developer Guide - Styling local DOM 2015] Polymer, Styling local DOM, 2015, https://www.polymer-project.org/1.0/docs/devguide/styling.html#style-modules
- [Monica Dinculescu 2015] Monica Dinculescu, Polymer's Styling System, 2015, https://www.youtube.com/watch?v=IbOaJwqLgog
