# Anhang B - Polymer Web Komponente

## Polymer Seed-Element

```html
<!--
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
-->
<link rel="import" href="../polymer/polymer.html">

<!--
An element providing a solution to no problem in particular.

Example:

    <my-element></my-element>

@group Seed Elements
@element my-element
@demo demo/index.html
@hero hero.svg
-->
<dom-module id="my-element">

  <template>
    <style>
      :host {
        display: block;
        box-sizing: border-box;
      }
  
      .author img {
        display: block;
        float: left;
        margin-right: 5px;
        max-height: 100px;
        max-width: 100px;
      }
    </style>
    <h1>&lt;my-element&gt;</h1>
    <content></content>
    <p class="author">
      <img src="{{author.image}}">
      Cheers,<br/>
      <span class="name">{{author.name}}</span>
    </p>
  </template>

</dom-module>

<script>



</script>
```


## Implementierung der Polymer Komponente multi-navigation-app

**multi-navigation-app.html**
```html
<!--
@license
Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
-->

<link rel="import" href="../paper-tabs/paper-tabs.html">
<link rel="import" href="../paper-toolbar/paper-toolbar.html">
<link rel="import" href="../iron-pages/iron-pages.html">
<link rel="import" href="../paper-drawer-panel/paper-drawer-panel.html">
<link rel="import" href="../paper-button/paper-button.html">
<link rel="import" href="../paper-icon-button/paper-icon-button.html">
<link rel="import" href="../paper-card/paper-card.html">
<link rel="import" href="../iron-icons/iron-icons.html">

<dom-module id="multi-navigation-app">

  <template>
    <style>
      :host {
        display: block;
        box-sizing: border-box;
      }
      paper-tabs {
        color: #fff;
        height: 100%;
        margin: auto -16px;
      }
      #topnavi ::content paper-tab {
        min-width: 50px;
      }
      @media only all and (min-width: 600px) {
        #topnavi ::content paper-tab {
          min-width: 80px;
        }
      }
      #leftnavi ::content paper-button {
        margin: 0;
        width: 100%;
        text-align: left;
        color: #3f51b5;
        text-transform: none;
      }
      #leftnavi ::content paper-button.iron-selected {
        font-weight: bold;
      }
      iron-pages {
        position: relative;
      }
      #paperDrawerPanel [drawer]:not([style-scope]):not(.style-scope) {
        border-right: 1px solid #e0e0e0;
      }
      paper-drawer-panel {
        --paper-drawer-panel-main-container: {
          background-color: #f5f5f5;
        };
        --paper-drawer-panel-left-drawer-container: {
          border-right: 1px solid #e5e5e5;
        };
      }
      #contents ::content paper-card {
        margin: 0 10%;
        width: 80%;
      }
    </style>

    <paper-drawer-panel>
      <paper-header-panel drawer>
        <paper-toolbar></paper-toolbar>

        <!-- Left Navigation -->
        <iron-pages id="leftnavi">
          <content select="iron-selector"></content>
        </iron-pages>
      </paper-header-panel>

      <paper-header-panel main>
        <paper-toolbar>
          <paper-icon-button icon="menu" paper-drawer-toggle></paper-icon-button>

          <!-- Top Navigation -->
          <paper-tabs id="topnavi" selected="{{selectedTop}}">
            <content select="paper-tab"></content>
          </paper-tabs>
        </paper-toolbar>

        <!-- Main Content -->
        <iron-pages id="contents" selected="{{selectedContent}}">
          <content select=".main"></content>
        </iron-pages>
      </paper-header-panel>
    </paper-drawer-panel>

  </div>
  </template>

</dom-module>

<script>

  Polymer({

    is: 'multi-navigation-app',

    properties: {
      selectedTop: {
        type: Number,
        value: 0
      },
      selectedContent: {
        type: Number,
        value: 0
      }
    },

    // Element Behavior
    _countLinks: function() {
      var count = 0;
      this.$.leftnavi.getContentChildren().forEach(function (value, i) {
        var links = value.children;
        for (j = 0; j < links.length; j++) {
          count++;
          links[j].linkNum = (count - 1);
        }
      });
    },

    _getSelectedContent: function() {
      return this.$.leftnavi.getContentChildren()[this.$.topnavi.selected].selectedItem.linkNum;
    },

    _addSelectedHandler: function() {
      var topNaviItems = this.$.topnavi;
      var leftNaviItems = this.$.leftnavi;
      var contents = this.$.contents;
      var that = this;

      topNaviItems.addEventListener('iron-select', function() {
        // init first selected
        leftNaviItems.select(that.selectedTop);
        var leftSelected = leftNaviItems.getContentChildren()[that.selectedTop].selectedItem;
        if (typeof leftSelected == 'undefined') {
          leftNaviItems.getContentChildren()[that.selectedTop].select(0)
        }

        contents.select(that._getSelectedContent());
      });

      leftNaviItems.getContentChildren().forEach(function (value, i) {
        value.addEventListener('iron-select', function (e) {
          contents.select(that._getSelectedContent());
        });
      });
    },
  });

</script>
```

*Diese Komponente kann auch auf GitHub unter https://github.com/glur4k/multi-navigation-app und in dem customelements.io Elemente Katalog unter https://customelements.io/glur4k/multi-navigation-app/. Sie kann ebenfalls mit Bower `bower install multi-navigation-app` heruntergeladen werden.*
