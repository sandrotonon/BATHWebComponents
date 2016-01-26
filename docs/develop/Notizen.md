# Notizen


MARKDOWN UND LATEX WIEDER TRENNEN
MARKDOWN WIRD AB EINEM PUNKT NICHT MEHR VERWENDET
STATTDESSEN ALLES IN LATEX ÜBERTRAGEN



## CSS

Pseudoklassen:

:Pseudoklasse


Pseudoelement:

::Pseudoelement


## Erste Schritte

- webcomponents.js mit bower installieren (http://webcomponents.org/polyfills/)


## Production?
- JA: http://developer.telerik.com/featured/web-components-ready-production/
- NEIN: http://developer.telerik.com/featured/web-components-arent-ready-production-yet/


## Vorteile / Nachteile
+ Wartbar
+ Vorteile hier: https://medium.com/@kaelig/why-web-components-will-make-the-web-a-better-place-for-our-users-38dc3154fc1d#.vnd37gx9h
- Einige Nachteile hier: http://ianfeather.co.uk/practical-questions-around-web-components/


## Styling
- http://philipwalton.com/articles/extending-styles/
- https://www.polymer-project.org/1.0/docs/devguide/styling.html#style-modules
  |- Shared Styles (Polymer - Auch ohne Polymer umsetzbar?)


## Microsoft und WebComponents
- https://entwickler.de/online/web/web-components-microsoft-edge-167732.html




## https://blogs.windows.com/msedgedev/2015/07/14/bringing-componentization-to-the-web-an-overview-of-web-components/
Bringing Componentization to the Web: An Overview of Web Components (part 1):

The goal of web components is to reduce complexity by isolating a related group of HTML, CSS, and JavaScript to perform a common function within the context of a single page.


## Accessebility - https://css-tricks.com/modular-future-web-components/
Obviously when you're hiding markup in secret shadow DOM sandboxes the issue of accessibility becomes pretty important. Steve Faulkner took a look at accessibility in shadow DOM and seemed to be satisfied with what he found.

Results from initial testing indicate that inclusion of ARIA roles, states and properties in content wholly inside the Shadow DOM works fine. The accessibility information is exposed correctly via the accessibility API. Screen readers can access content in the Shadow DOM without issue.
The full post is available here.

Marcy Sutton* has also written a post exploring this topic in which she explains:

Web Components, including Shadow DOM, are accessible because assistive technologies encounter pages as rendered, meaning the entire document is read as “one happy tree”.
*Marcy also points out that the img-slider I built in this post is not accessible because our css label trick makes it inaccessible from the keyboard. Keep that in mind if you're looking to reuse it in a project.
