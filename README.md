# JLMaterialLayer
Build your own NSVisualEffectView

### What?
JLMaterialLayer is a reimplementation of the CALayer used by NSVisualEffectView to create behind-window blurring (amongst other effects). 

### Pros
- You can set up your view any way you want!

### Cons
- You have to set up your view exactly as you want

### How to
With all these options, configuration can become overwhelming and time consuming.  To make it easier I have included a "demo project" which allows you to tinker with all the available options in JLMaterialLayer in real time. Then once you have a view you like, set the property values in your JLMaterialLayer to the values shown in the demo window and you're good to go.

### Demo
<img src="https://i.imgur.com/o1CAS7u.png" height="400" />

### Bonus Points
- Add a CAGradientLayer as a mask over JLMaterialLayer to fade into and out of the effect
- Add filters to JLMaterialLayers `fillLayer` 
- Apply compositing filters to JLMaterialLayer
