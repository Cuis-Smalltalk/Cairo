# Cairo

Cairo graphics for Cuis Smalltalk

## Install:

```smalltalk
Feature require: 'CairoMorphic'.
```

Close all your browser windows and the Transcript and try:

```smalltalk
CairoCanvas displayWorld.
CairoCanvas displayWorldRotated: 10.
CairoCanvas displayWorldScaled: 1.2@1.2.
```

There's an example of a Cairo morph embedded in normal BitBlt World:

```smalltalk
CairoMorphExample new openInWorld.
```

To install/uninstall the Cairo canvas:

```smalltalk
CairoDisplayScreen install.
CairoDisplayScreen uninstall.
```
