# Textschnipsel


## Shadow Boundary

Any HTML and CSS inside of the shadow root is protected from the parent document by an invisible barrier called the Shadow Boundary. The shadow boundary prevents CSS in the parent document from bleeding into the shadow DOM, and it also prevents external JavaScript from traversing into the shadow root.

Translation: Let's say you have a style tag in the shadow DOM that specifies all h3's should have a color of red. Meanwhile, in the parent document, you have a style that specifies h3's should have a color of blue. In this instance, h3's appearing within the shadow DOM will be red, and h3's outside of the shadow DOM will be blue. The two styles will happily ignore each other thanks to our friend, the shadow boundary.

And if, at some point, the parent document goes looking for h3's with $('h3'), the shadow boundary will prevent any exploration into the shadow root and the selection will only return h3's that are external to the shadow DOM.

**This level of privacy is something that we've dreamed about and worked around for years. To say that it will change the way we build web applications is a total understatement.**

Source: https://css-tricks.com/modular-future-web-components/