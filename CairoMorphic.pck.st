'From Cuis 5.0 [latest update: #3944] on 31 October 2019 at 7:25:08 pm'!
'Description An implementation of MorphicCanvas using Cairo FFI.'!
!provides: 'CairoMorphic' 1 84!
!requires: 'Cairo' 1 7 nil!
SystemOrganization addCategory: #CairoMorphic!


!classDefinition: #CairoDisplayScreen category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
DisplayScreen subclass: #CairoDisplayScreen
	instanceVariableNames: 'canvas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CairoMorphic'!
!classDefinition: 'CairoDisplayScreen class' category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoDisplayScreen class
	instanceVariableNames: ''!

!classDefinition: #CairoMorph category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
RectangleLikeMorph subclass: #CairoMorph
	instanceVariableNames: 'rotation scale'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CairoMorphic'!
!classDefinition: 'CairoMorph class' category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoMorph class
	instanceVariableNames: ''!

!classDefinition: #CairoMorphExample category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoMorph subclass: #CairoMorphExample
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CairoMorphic'!
!classDefinition: 'CairoMorphExample class' category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoMorphExample class
	instanceVariableNames: ''!

!classDefinition: #CairoBorderedRectMorph category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
BorderedRectMorph subclass: #CairoBorderedRectMorph
	instanceVariableNames: 'rotation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CairoMorphic'!
!classDefinition: 'CairoBorderedRectMorph class' category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoBorderedRectMorph class
	instanceVariableNames: ''!

!classDefinition: #CairoCanvas category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
BitBltCanvas subclass: #CairoCanvas
	instanceVariableNames: 'surface cairo images'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CairoMorphic'!
!classDefinition: 'CairoCanvas class' category: #CairoMorphic stamp: 'MM 10/31/2019 19:25:08'!
CairoCanvas class
	instanceVariableNames: ''!


!CairoDisplayScreen commentStamp: '<historical>' prior: 0!
Display screen using Cairo FFI.

To install:

CairoDisplayScreen install.!

!CairoMorph commentStamp: '<historical>' prior: 0!
Morph that draws on a CairoCanvas.!

!CairoCanvas commentStamp: '<historical>' prior: 0!
A Canvas that renders with Cairo FFI.

Tests:

CairoCanvas displayWorld.
CairoCanvas displayWorldScaled: 0.8@0.8.
CairoCanvas displayWorldRotated: -10!

!CairoDisplayScreen methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 12:48:41'!
forceToScreen: aRectangle

	(BitBlt toForm: self)
		copy: aRectangle
		from: aRectangle origin in: canvas form.
		
	super forceToScreen: aRectangle.! !

!CairoDisplayScreen methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 18:48:31'!
getCanvas
	"Return a Canvas that can be used to draw onto the receiver"
	^ canvas! !

!CairoDisplayScreen methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 18:23:12'!
initialize
	super initialize.
	canvas _ CairoCanvas withExtent: DisplayScreen actualScreenSize! !

!CairoDisplayScreen class methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 18:45:07'!
install
	 | d |
	d _ CairoDisplayScreen new.
	d beDisplay.
	Smalltalk at: #Display put: d.
	DisplayScreen startUp.
	Display forceToScreen.! !

!CairoDisplayScreen class methodsFor: 'as yet unclassified' stamp: 'MM 10/13/2019 09:01:12'!
uninstall
	 | d |
	d _ DisplayScreen new.
	d beDisplay.
	Smalltalk at: #Display put: d.
	DisplayScreen startUp.
	Display forceToScreen.! !

!CairoMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 17:34:36'!
drawMorphOn: aCanvas
	! !

!CairoMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:13:52'!
drawOn: aCanvas

	|cairoCanvas|
	
	cairoCanvas _ CairoCanvas withExtent: self morphExtent.
	
	scale = 1 ifFalse: [
		cairoCanvas scale: scale@scale].
	
	self visible ifTrue: [self drawMorphOn: cairoCanvas].
		
	self submorphsDo: [:m |
		cairoCanvas fullDraw: m].
	
	aCanvas image: cairoCanvas form at: 0@0.
	
	cairoCanvas release.! !

!CairoMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 18:39:54'!
hasSubmorphs
	"We return false here so that we can handle submorphs drawing ourselves, instead of MorphicCanvas>>fullDraw:"
	^ false! !

!CairoMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 21:56:28'!
initialize
	super initialize.
	rotation _ 0.
	scale _ 1.! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 19:24:54'!
drawMorphOn: aCanvas
	aCanvas fillRectangle: self morphLocalBounds color: Color white.
	
	aCanvas cairo setLineWidth: 5;
				setSourceColor: Color blue;
				curveTo: 300@300 control1: 0@100  control2: 0@200;
				stroke. ! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:11:31'!
handlesMouseDown: anEvent
	^ true! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/18/2019 13:46:48'!
handlesMouseOver: anEvent
	^ true! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 21:52:41'!
handlesMouseScroll: anEvent
	^ true! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/13/2019 11:16:44'!
initialize
	super initialize.
	self addMorph: (CairoBorderedRectMorph new
							morphExtent: 50@50;
							morphPosition: 50@50;
							rotatedBy: -20;
							color: Color red;
							borderWidth: 5;
							borderColor: Color black;
							yourself).
							
	self addMorphBack: (CairoBorderedRectMorph new
							morphExtent: 100@100;
							morphPosition: 50@50;
							rotatedBy: 20;
							color: (Color green alpha: 0.5);
							borderWidth: 5;
							borderColor: Color black;
							yourself).
							
	self addMorph: PluggableButtonMorph example position: 200@100.
	self morphExtent: 500@500! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:12:05'!
mouseButton1Down: aMouseButtonEvent localPosition: localEventPosition
	self zoomIn! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:12:11'!
mouseButton2Down: aMouseButtonEvent localPosition: localEventPosition
	self zoomOut! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/18/2019 13:45:19'!
mouseEnter: anEvent
	self activeHand newKeyboardFocus: self.! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/18/2019 13:47:05'!
mouseScroll: aMouseEvent localPosition: localEventPosition
	aMouseEvent direction
		caseOf: {
			[ #up ] 		-> 		[  self zoomOut ].
			[ #down ] 	-> 		[ self zoomIn ].
			[ #left ] 	-> 		[  self zoomOut ].
			[ #right ] 	-> 		[  self zoomIn ] }! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 21:59:59'!
zoomIn
	scale _ scale + 0.1.
	self redrawNeeded! !

!CairoMorphExample methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:00:06'!
zoomOut
	scale _ scale - 0.1.
	self redrawNeeded! !

!CairoBorderedRectMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 19:13:40'!
clippedSubmorph
	^ false! !

!CairoBorderedRectMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 17:20:44'!
rotatedBy: angle
	rotation _ angle! !

!CairoBorderedRectMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 19:19:41'!
rotation
	^ rotation! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:02:28'!
fillColor: aFillColor do: aBlock
	"Prepare parameters for drawing stroke, fill, or both."

	cairo setSourceColor: aFillColor.
	^ aBlock value
	! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:01:57'!
multiCurveTo: coordinatesAreRelative toPoints: toPoints control1Points: control1Points control2Points: control2Points

	| c1 c2 to |
	coordinatesAreRelative
		ifFalse: [
			1 to: toPoints size do: [ :i |
				to _ toPoints at: i.
				c1 _ control1Points at: i.
				c2 _ control2Points at: i.
				cairo curveTo: to control1: c1 control2: c2 ]]
		ifTrue: [
			1 to: toPoints size do: [ :i |
				to _ toPoints at: i.
				c1 _ control1Points at: i.
				c2 _ control2Points at: i.
				cairo curveTo: to control1: c1 control2: c2 ]].
	cairo stroke! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:01:48'!
multiLineTo: coordinatesAreRelative points: toPoints

	| to |
	coordinatesAreRelative
		ifFalse: [
			1 to: toPoints size do: [ :i |
				to _ toPoints at: i.
				cairo lineTo: to ]]
		ifTrue: [
			1 to: toPoints size do: [ :i |
				to _ toPoints at: i.
				cairo lineTo: to ]].
	cairo stroke! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:02:46'!
multiMoveTo: coordinatesAreRelative points: points

	| isFirst |
	isFirst _ true.
	coordinatesAreRelative
		ifFalse: [
			points do: [ :p |
				isFirst
					ifTrue: [ cairo moveTo: p x @ (p y) ]
					ifFalse: [ cairo lineTo: p x @ (p y) ].
				isFirst _ false ]]
		ifTrue: [
			points do: [ :p |
				isFirst
					ifTrue: [ cairo moveTo: p x @ (p y) ]
					ifFalse: [ cairo lineTo: p x @ (p y) ].
				isFirst _ false ]].
	cairo stroke! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:01:39'!
polyLine: points

	| p  |
	p _ points first.
	cairo moveTo: p.
	2 to: points size do: [ :i |
		p _ points at: i.	
		cairo lineTo: p ].
	cairo stroke.! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/26/2019 11:00:47'!
strokeWidth: aNumber color: color fillColor: fillColor do: aBlock
	color ifNotNil: [cairo setSourceColor: color].
	fillColor ifNotNil: [cairo setSourceColor: fillColor].
	cairo setLineWidth: aNumber.
	^ aBlock value! !

!CairoCanvas methodsFor: 'api' stamp: 'MM 10/20/2019 10:34:57'!
withCairoDo: aBlock
	"Give direct access to cairo context"
	
	aBlock value: cairo! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 19:19:07'!
cairo
	^ cairo! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/26/2019 10:35:23'!
closePath
	cairo closePath! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/31/2019 13:18:21'!
createImageSurface: aForm
	|stride externalForm ptr surf |
	
	externalForm := ExternalForm extent: aForm extent depth: 32.
	ptr := ExternalAddress gcallocate: (aForm extent x * aForm extent y * 4).
	externalForm setManualSurfacePointer: ptr.
	
	(BitBlt toForm: externalForm)
		copy: aForm boundingBox
		from: 0@0 in: aForm. 
		
	stride _ Cairo formatStrideForWidth: Cairo CairoFormatARGB32 width: aForm extent x. 
	surf _ Cairo imageSurfaceCreateForData: ptr format: Cairo CairoFormatARGB32 width: aForm extent x height: aForm extent y stride: stride.
	
	"We need to keep the externalForm alive. Otherwise the surface gets invalid when the form memory is relased because of gc."
		
	^ CairoSurface new surface: surf; externalForm: externalForm; yourself! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:45:36'!
drawButtonIconFromCurrentMorph
	"We assume that we are drawing a PluggableButtonMorph,
	or some morph that conforms the required protocol.
	Answer true if we were able to draw it."

	currentMorph magnifiedIcon ifNotNil: [ :theIcon |
		self
			image: theIcon
			multipliedBy: currentMorph iconColor
			at: (currentMorph morphExtent - theIcon extent //2).
		^true ].
	^false! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/13/2019 11:07:17'!
drawString: aString at: aPoint font: fontOrNil color: aColor

	|font fw slant fsize str|
	
	font _ fontOrNil ifNil: [AbstractFont default].
	fw _ font isBold ifTrue: [Cairo CairoFontWeightBold]
			ifFalse: [Cairo CairoFontWeightNormal ].
	slant _ font isItalic ifTrue: [Cairo CairoFontSlantItalic ]
					ifFalse: [Cairo CairoFontSlantNormal ].
	fsize _ font lineSpacing - 2. "<-- I'm doing this arbitrarily :( "
	
	cairo setSourceColor: aColor.
	cairo selectFontFace: font name 
			slant: slant 
			weight: fw.
	cairo setFontSize: fsize; moveTo: aPoint x @ (aPoint y +  fsize).
	"Cairo printDebug: 'TEXT: ', aString."
	str _ aString reject: [:aCharacter | {Character newLineCharacter. Character tab} includes: aCharacter].
	cairo showText: str.
	^ nil! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 21:30:33'!
drawString: aString from: firstIndex to: lastIndex at: aPoint font: fontOrNil color: aColor

	^ self drawString: (aString copyFrom: firstIndex to: lastIndex) at: aPoint font: fontOrNil color: aColor! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 18:23:23'!
fillRectangle: aRectangle color: aColor
	cairo setSourceColor: aColor;
			rectangle: aRectangle;
			fill.
	! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 18:29:56'!
fillRectangle: aRectangle color: aColor borderWidth: borderWidth borderStyleSymbol: aSymbol baseColorForBorder: baseColorForBorder
	cairo setSourceColor: aColor;
		   rectangle: aRectangle;
		   fill.
		
	cairo setLineWidth: borderWidth;
		   setSourceColor: baseColorForBorder;
		   moveTo: aRectangle origin;
		   lineTo: aRectangle topRight;
		   lineTo: aRectangle bottomRight;
		   lineTo: aRectangle bottomLeft;
		   lineTo: aRectangle topLeft;
		   stroke! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 00:44:15'!
frameAndFillRectangle: r fillColor: fillColor borderWidth: borderWidth borderColor: borderColor
	self frameRectangle: r  borderWidth: borderWidth color: fillColor! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 11:09:27'!
frameRectangle: r borderWidth: borderWidth color: aColor
	cairo roundedRectangle: r radius: 5;
		   setLineWidth: borderWidth;
		   setSourceColor: aColor;
		   stroke.! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 11:11:42'!
frameRectangle: r color: aColor borderWidth: borderWidth borderStyleSymbol: aSymbol
	"
	Display getCanvas fillRectangle: (10@10 extent: 300@200) color: Color white. Display forceToScreen.
	Display getCanvas
		frameRectangle: (10@10 extent: 300@200)
		color: Color green
		borderWidth: 10
		borderStyleSymbol: #raised.
	Display forceToScreen.
	"

	| displayRectangle bw |
		bw _ (currentTransformation externalizeScalar: borderWidth) rounded.
	aSymbol == #raised ifTrue: [
		displayRectangle _ (currentTransformation externalizeRectangle: r) rounded.
		^ self
			frameRectangle: displayRectangle
			borderWidth: bw
			topLeftColor: aColor quiteWhiter
			bottomRightColor: aColor quiteBlacker ].

	aSymbol == #inset ifTrue: [
		displayRectangle _ (currentTransformation externalizeRectangle: r) rounded.
		^ self
			frameRectangle: displayRectangle
			borderWidth: bw
			topLeftColor: aColor quiteBlacker
			bottomRightColor: aColor quiteWhiter ].
	
	"Unrecognized border style. Draw some border..."
	self frameRectangle: r borderWidth: bw color: aColor! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 14:10:05'!
image: aForm at: aPoint

	|img|
	
	img _ images at: aForm ifAbsent: [|im|
		im _ self createImageSurface: aForm.
		images at: aForm put: im.
		im].
	

	cairo setSourceSurface: img surface at: aPoint.
	"cairo setOperator: 5."
	cairo paint! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:49:41'!
image: aForm multipliedBy: aColor at: aPoint
	self image: aForm at: aPoint! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 17:09:30'!
initializeWith: aForm origin: aPoint

	|stride |
	
	super initializeWith: aForm origin: aPoint.
	
	images _ WeakKeyDictionary new.
	
	stride _ Cairo formatStrideForWidth: Cairo CairoFormatARGB32 width: aForm extent x. 
	surface _ Cairo imageSurfaceCreateForData: aForm pointer getHandle format: Cairo CairoFormatARGB32 width: aForm extent x height: aForm extent y stride: stride.
	cairo _ CairoContext on: (Cairo create: surface).! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 14:33:57'!
into: aMorph
	super into: aMorph.
	
	cairo save; translate: aMorph morphPosition.

	aMorph rotation isZero ifFalse: [
		cairo translate: aMorph morphBounds center;
			   rotate: aMorph rotation degreesToRadians;
			   translate: 0 - aMorph morphBounds center].
	cairo rectangle: (0@0 extent: aMorph morphExtent) ; clip.
	! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 20:57:27'!
isCurrentMorphVisible

	^ currentMorph visible! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 21:04:33'!
line: fromPoint to: toPoint width: width color: aColor
	cairo setLineWidth: width;
		setSourceColor: aColor;
		moveTo: fromPoint;
		lineTo: toPoint;
		stroke.! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 12:48:52'!
outOfMorph
	super outOfMorph.
	
	cairo restore.
! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 13:58:26'!
release
	cairo destroy.
	Cairo surfaceDestroy: surface.
	images values do: [:img |
		img release]! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 18:47:40'!
rotate: angle
	cairo rotate: angle degreesToRadians ! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 19:09:55'!
rotatedBy: angle at: aPoint do: aBlock
	cairo save;
		   translate: aPoint;
		   rotate: angle degreesToRadians;
		   translate: 0 - aPoint.
	aBlock value.
	cairo restore.
		! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/22/2019 22:26:30'!
roundRect: aRectangle color: aColor radius: radius
	cairo setSourceColor: aColor;
		   roundedRectangle: aRectangle radius: radius ;
			fill.! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 22:13:11'!
scale: aPoint
	cairo scale: aPoint! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/31/2019 19:12:55'!
spline: fromPoint to: toPoint  control1: c1 control2: c2 width: width color: aColor
	cairo moveTo: fromPoint;
			setSourceColor: aColor;
			setLineWidth: width;
			curveTo: toPoint  control1: c1  control2: c2 ;
			stroke! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 18:47:23'!
translate: aPoint
	cairo translate: aPoint! !

!CairoCanvas methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 11:03:33'!
windowFrame: aRectangle color: aColor radius: r border: bw labelHeight: lh gradientTop: topFactor gradientBottom: bottomFactor insideColor: insideColor
	cairo setSourceColor: aColor;
		   roundedRectangle: aRectangle radius: 10;
		   fill! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 18:26:36'!
display: aMorph
	^ self withExtent: aMorph morphExtent display: aMorph! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 19:23:00'!
displayWorld
	Display restoreAfter: [CairoCanvas display: self runningWorld]! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 19:22:03'!
displayWorldRotated: angle
	Display restoreAfter: [ |canvas morph|
		morph _ self runningWorld.
		canvas _ CairoCanvas withExtent: morph morphExtent.
		canvas cairo rotate: angle degreesToRadians .
		canvas fullDraw: morph.
		canvas form displayAt: 0@0]! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/8/2019 19:20:27'!
displayWorldScaled: scale
	Display restoreAfter: [ |canvas morph|
		morph _ self runningWorld.
		canvas _ CairoCanvas withExtent: morph morphExtent.
		canvas cairo scale: scale.
		canvas fullDraw: morph.
		canvas form displayAt: 0@0]! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 18:12:51'!
withExtent: extent 

	^ self withExtent: extent depth: 32! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:35:07'!
withExtent: extent depth: depth

	|form ptr|

	form := ExternalForm extent: extent depth: depth.
	ptr := ExternalAddress gcallocate: (extent x * extent y * 4) asInteger.
	form setManualSurfacePointer: ptr.

	^ self onForm: form! !

!CairoCanvas class methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 21:01:04'!
withExtent: extent display: aMorph

	"For testing purposes"
	
	|canvas|
	
	[canvas _ self withExtent: extent.
	
	canvas fullDraw: aMorph.
	
	canvas form displayAt: 0@0]
	ensure: [canvas release]! !

!CodeProvider methodsFor: '*CairoMorphic' stamp: 'MM 10/12/2019 14:47:13'!
annotationSeparator
	"Answer the separator to be used between annotations"
    "cairo_show_text fails with the normal special character used here"

	^ '. '! !

!Morph methodsFor: '*CairoMorphic' stamp: 'MM 10/7/2019 21:45:46'!
displayInCairo
	CairoCanvas display: self! !

!Morph methodsFor: '*CairoMorphic' stamp: 'MM 10/9/2019 19:16:15'!
rotation
	^ 0! !
