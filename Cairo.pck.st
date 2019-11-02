'From Cuis 5.0 [latest update: #3944] on 2 November 2019 at 1:43:07 pm'!
'Description FFI for Cairo Vector Graphics library and CairoCanvas.'!
!provides: 'Cairo' 1 47!
!requires: 'FFI' 1 33 nil!
SystemOrganization addCategory: #Cairo!


!classDefinition: #Cairo category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
Object subclass: #Cairo
	instanceVariableNames: ''
	classVariableNames: 'Enums'
	poolDictionaries: ''
	category: 'Cairo'!
!classDefinition: 'Cairo class' category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
Cairo class
	instanceVariableNames: ''!

!classDefinition: #CairoContext category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
Object subclass: #CairoContext
	instanceVariableNames: 'ctx'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cairo'!
!classDefinition: 'CairoContext class' category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
CairoContext class
	instanceVariableNames: ''!

!classDefinition: #CairoSurface category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
Object subclass: #CairoSurface
	instanceVariableNames: 'externalForm surface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cairo'!
!classDefinition: 'CairoSurface class' category: #Cairo stamp: 'MM 11/2/2019 13:43:08'!
CairoSurface class
	instanceVariableNames: ''!


!Cairo class methodsFor: 'api' stamp: 'MM 10/7/2019 15:17:40'!
withContext: surface do: aBlock
	|context|
	
	[context _ CairoContext on: (Cairo create: surface).
	aBlock value: context]
		ensure: [context destroy]! !

!Cairo class methodsFor: 'api' stamp: 'MM 10/7/2019 14:37:48'!
withSurface: surface do: aBlock
	[aBlock value: surface] ensure: [Cairo surfaceDestroy: surface]! !

!Cairo class methodsFor: 'constants' stamp: 'MM 10/7/2019 13:45:41'!
CairoFormatARGB32
	^ 1! !

!Cairo class methodsFor: 'constants' stamp: 'MM 10/7/2019 13:46:04'!
CairoFormatRGB24
	^ 2! !

!Cairo class methodsFor: 'enumerations' stamp: 'MM 10/7/2019 13:42:14'!
defineEnum: aSymbol values: consts
	Enums at: aSymbol put: consts! !

!Cairo class methodsFor: 'enumerations' stamp: 'MM 10/7/2019 13:43:56'!
getEnumValue: aSymbol name: otherSymbol
	^ (Enums at: aSymbol) position: otherSymbol ! !

!Cairo class methodsFor: 'examples' stamp: 'MM 10/6/2019 01:47'!
example1

	"self example1"
	
|surf status ctx |

surf _ Cairo imageSurfaceCreate:0 width:100 height: 100.

status _ Cairo surfaceStatus: surf.

Cairo statusToString: status.

ctx _ Cairo create: surf.

Cairo setSourceRGB: ctx r: 1 g: 0 b: 0.
Cairo moveTo: ctx x: 0 y: 0.
Cairo lineTo: ctx x: 50 y: 50.
Cairo setLineWidth: ctx width: 3.
Cairo stroke: ctx.

Cairo destroy: ctx.

Cairo surfaceWriteToPNG: surf filename: 'cairo_test1.png'.! !

!Cairo class methodsFor: 'examples' stamp: 'MM 10/7/2019 16:08:59'!
example2

	"self example2"

	Cairo at: 0@0 extent: 100@100 display: [:ctx |

Cairo setSourceRGBA: ctx context r: 1  g: 1  b: 1 a: 1. 
ctx "setSourceColor: Color black;"
	rectangleFrom: 0@0 extent: 100@100;
	fill.

ctx setSourceColor: Color yellow;
	moveTo: 0@0;
	lineTo: 50@50;
	setLineWidth: 3;
	stroke.
	
ctx setSourceColor: Color white;
	moveTo: 50@0;
	lineTo: 0@50;
	setLineWidth: 5;
	stroke]! !

!Cairo class methodsFor: 'ffi' stamp: 'MM 10/9/2019 12:57:36'!
setOperator: ctx operator: op

<cdecl: void 'cairo_set_operator' (void* ushort) module: 'libcairo'>

^ self externalCallFailed! !

!Cairo class methodsFor: 'ffi-drawing' stamp: 'MM 10/7/2019 16:08:03'!
setSourceRGB: ctx r: r g: g b: b
	
	<cdecl: void 'cairo_set_source_rgb' (void* double double double) module: 'libcairo'>

	^ self externalCallFailed! !

!Cairo class methodsFor: 'ffi-drawing' stamp: 'MM 10/7/2019 16:08:06'!
setSourceRGBA: ctx r: r g: g b: b a: a
	
	<cdecl: void 'cairo_set_source_rgba' (void* double double double double) module: 'libcairo'>

	^ self externalCallFailed! !

!Cairo class methodsFor: 'ffi-surfaces' stamp: 'MM 10/7/2019 16:06:20'!
surfaceWriteToPNG: surface filename: filename

"cairo_surface_write_to_png ()

cairo_status_t
cairo_surface_write_to_png (cairo_surface_t *surface,
                            const char *filename);

Writes the contents of surface to a new file filename as a PNG image.
Parameters

surface
	

a cairo_surface_t with pixel contents
	 

filename
	

the name of a file to write to; on Windows this filename is encoded in UTF-8.
	 
Returns

CAIRO_STATUS_SUCCESS if the PNG file was written successfully. Otherwise, CAIRO_STATUS_NO_MEMORY if memory could not be allocated for the operation or CAIRO_STATUS_SURFACE_TYPE_MISMATCH if the surface does not have pixel contents, or CAIRO_STATUS_WRITE_ERROR if an I/O error occurs while attempting to write the file, or CAIRO_STATUS_PNG_ERROR if libpng returned an error."

<cdecl: ushort 'cairo_surface_write_to_png' (void* char*) module: 'libcairo'>

^ self externalCallFailed! !

!Cairo class methodsFor: 'ffi-text' stamp: 'MM 10/7/2019 19:06:16'!
selectFontSize: ctx size: size

	<cdecl: void 'cairo_set_font_size' (void* double) module: 'libcairo'>

	^ self externalCallFailed

	! !

!Cairo class methodsFor: 'ffi-text' stamp: 'MM 10/7/2019 19:07:35'!
showText: ctx text: text

	<cdecl: void 'cairo_show_text' (void* char*) module: 'libcairo'>

	^ self externalCallFailed

	! !

!Cairo class methodsFor: 'ffi-transformations' stamp: 'MM 10/7/2019 16:12:45'!
scale: ctx x: x y: y

	<cdecl: char* 'cairo_scale' (void* double double) module: 'libcairo'>

	^ self externalCallFailed
	
	! !

!Cairo class methodsFor: 'ffi-transformations' stamp: 'MM 10/7/2019 16:08:26'!
translate: ctx x: x y: y

	<cdecl: char* 'cairo_translate' (void* double double) module: 'libcairo'>

	^ self externalCallFailed
	
	! !

!Cairo class methodsFor: 'testing' stamp: 'MM 10/7/2019 15:28:07'!
at: aPoint extent: extent display: aBlock

	|ptr form stride|

	[form := ExternalForm extent: extent depth: 32.
	ptr := ExternalAddress gcallocate: (extent x * extent y * 4).
	form setManualSurfacePointer: ptr.

	stride _ Cairo formatStrideForWidth: Cairo CairoFormatARGB32 width: extent x. 

	Cairo withSurface: (Cairo imageSurfaceCreateForData: ptr format: Cairo CairoFormatARGB32 width:extent x height: extent y stride: stride) do: [:surf | Cairo withContext: surf do: aBlock].

	form displayOn: Display at: aPoint rule: Form over]
	ensure: [form destroySurface]! !

!Cairo class methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 13:26:21'!
printDebug: aString
	<cdecl: char* 'ffiPrintString' (char *) module:'SqueakFFIPrims'>
	^self externalCallFailed! !

!Cairo class methodsFor: 'ffi-functions'!
appendPath: cr path: path
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_append_path' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
arc: cr xc: xc yc: yc radius: radius angle1: angle1 angle2: angle2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_arc' (void* double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
arcNegative: cr xc: xc yc: yc radius: radius angle1: angle1 angle2: angle2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_arc_negative' (void* double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
clip: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_clip' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
clipExtents: cr x1: x1 y1: y1 x2: x2 y2: y2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_clip_extents' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
clipPreserve: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_clip_preserve' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
closePath: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_close_path' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
copyClipRectangleList: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_copy_clip_rectangle_list' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
copyPage: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_copy_page' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
copyPath: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_copy_path' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
copyPathFlat: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_copy_path_flat' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
create: target
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_create' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
curveTo: cr x1: x1 y1: y1 x2: x2 y2: y2 x3: x3 y3: y3
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_curve_to' (void* double double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
debugResetStaticData
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_debug_reset_static_data' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
destroy: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceAcquire: device
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_acquire' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceDestroy: device
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceFinish: device
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_finish' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceFlush: device
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_flush' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceGetReferenceCount: device
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceGetType: device
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_get_type' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceGetUserData: device key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_device_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverFillElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_fill_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverGlyphsElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_glyphs_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverMaskElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_mask_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverPaintElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_paint_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverPrint: device writeFunc: writeFunc closure: closure
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_observer_print' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceObserverStrokeElapsed: device
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_device_observer_stroke_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceReference: device
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_device_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceRelease: device
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_release' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceSetUserData: device key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceStatus: device
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_device_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceToUser: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_to_user' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
deviceToUserDistance: cr dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_device_to_user_distance' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fill: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_fill' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fillExtents: cr x1: x1 y1: y1 x2: x2 y2: y2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_fill_extents' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fillPreserve: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_fill_preserve' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontExtents: cr extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_extents' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceDestroy: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_face_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceGetReferenceCount: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_face_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceGetType: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_face_get_type' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceGetUserData: fontFace key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_font_face_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceReference: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_font_face_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceSetUserData: fontFace key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_face_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontFaceStatus: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_face_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsCopy: original
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_font_options_copy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsCreate
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_font_options_create' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsDestroy: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsEqual: options other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_font_options_equal' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsGetAntialias: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_options_get_antialias' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsGetHintMetrics: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_options_get_hint_metrics' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsGetHintStyle: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_options_get_hint_style' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsGetSubpixelOrder: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_options_get_subpixel_order' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsHash: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ulong 'cairo_font_options_hash' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsMerge: options other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_merge' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsSetAntialias: options antialias: antialias
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_set_antialias' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsSetHintMetrics: options hintMetrics: hintMetrics
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_set_hint_metrics' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsSetHintStyle: options hintStyle: hintStyle
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_set_hint_style' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsSetSubpixelOrder: options subpixelOrder: subpixelOrder
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_font_options_set_subpixel_order' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
fontOptionsStatus: options
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_font_options_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
formatStrideForWidth: format width: width
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_format_stride_for_width' (ushort long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getAntialias: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_antialias' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getCurrentPoint: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_get_current_point' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getDash: cr dashes: dashes offset: offset
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_get_dash' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getDashCount: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_get_dash_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getFillRule: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_fill_rule' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getFontFace: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_font_face' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getFontMatrix: cr matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_get_font_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getFontOptions: cr options: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_get_font_options' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getGroupTarget: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_group_target' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getLineCap: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_line_cap' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getLineJoin: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_line_join' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getLineWidth: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_get_line_width' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getMatrix: cr matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_get_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getMiterLimit: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_get_miter_limit' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getOperator: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_operator' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getReferenceCount: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getScaledFont: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_scaled_font' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getSource: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_source' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getTarget: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_target' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getTolerance: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_get_tolerance' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
getUserData: cr key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
glyphAllocate: numGlyphs
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_glyph_allocate' (long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
glyphExtents: cr glyphs: glyphs numGlyphs: numGlyphs extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_glyph_extents' (void* void* long void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
glyphFree: glyphs
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_glyph_free' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
glyphPath: cr glyphs: glyphs numGlyphs: numGlyphs
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_glyph_path' (void* void* long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
hasCurrentPoint: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_has_current_point' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
identityMatrix: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_identity_matrix' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceCreate: format width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_image_surface_create' (ushort long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceCreateForData: data format: format width: width height: height stride: stride
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_image_surface_create_for_data' (char* ushort long long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceCreateFromPng: filename
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_image_surface_create_from_png' (schar* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceCreateFromPngStream: readFunc closure: closure
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_image_surface_create_from_png_stream' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceGetData: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: char* 'cairo_image_surface_get_data' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceGetFormat: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_image_surface_get_format' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceGetHeight: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_image_surface_get_height' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceGetStride: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_image_surface_get_stride' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
imageSurfaceGetWidth: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_image_surface_get_width' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
inClip: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_in_clip' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
inFill: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_in_fill' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
inStroke: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_in_stroke' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
lineTo: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_line_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
mask: cr pattern: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mask' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
maskSurface: cr surface: surface surfaceX: surfaceX surfaceY: surfaceY
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mask_surface' (void* void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInit: matrix xx: xx yx: yx xy: xy yy: yy x0: x0 y0: y0
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_init' (void* double double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInitIdentity: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_init_identity' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInitRotate: matrix radians: radians
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_init_rotate' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInitScale: matrix sx: sx sy: sy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_init_scale' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInitTranslate: matrix tx: tx ty: ty
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_init_translate' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixInvert: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_matrix_invert' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixMultiply: result a: a b: b
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_multiply' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixRotate: matrix radians: radians
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_rotate' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixScale: matrix sx: sx sy: sy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_scale' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixTransformDistance: matrix dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_transform_distance' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixTransformPoint: matrix x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_transform_point' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
matrixTranslate: matrix tx: tx ty: ty
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_matrix_translate' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternBeginPatch: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_begin_patch' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternCurveTo: pattern x1: x1 y1: y1 x2: x2 y2: y2 x3: x3 y3: y3
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_curve_to' (void* double double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternEndPatch: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_end_patch' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternGetControlPoint: pattern patchNum: patchNum pointNum: pointNum x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_mesh_pattern_get_control_point' (void* ushort ushort double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternGetCornerColorRgba: pattern patchNum: patchNum cornerNum: cornerNum red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_mesh_pattern_get_corner_color_rgba' (void* ushort ushort double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternGetPatchCount: pattern count: count
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_mesh_pattern_get_patch_count' (void* ushort* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternGetPath: pattern patchNum: patchNum
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_mesh_pattern_get_path' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternLineTo: pattern x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_line_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternMoveTo: pattern x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_move_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternSetControlPoint: pattern pointNum: pointNum x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_set_control_point' (void* ushort double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternSetCornerColorRgb: pattern cornerNum: cornerNum red: red green: green blue: blue
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_set_corner_color_rgb' (void* ushort double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
meshPatternSetCornerColorRgba: pattern cornerNum: cornerNum red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_mesh_pattern_set_corner_color_rgba' (void* ushort double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
moveTo: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_move_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
newPath: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_new_path' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
newSubPath: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_new_sub_path' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
paint: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_paint' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
paintWithAlpha: cr alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_paint_with_alpha' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
pathDestroy: path
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_path_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
pathExtents: cr x1: x1 y1: y1 x2: x2 y2: y2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_path_extents' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternAddColorStopRgb: pattern offset: offset red: red green: green blue: blue
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_add_color_stop_rgb' (void* double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternAddColorStopRgba: pattern offset: offset red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_add_color_stop_rgba' (void* double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateForSurface: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_for_surface' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateLinear: x0 y0: y0 x1: x1 y1: y1
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_linear' (double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateMesh
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_mesh' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateRadial: cx0 cy0: cy0 radius0: radius0 cx1: cx1 cy1: cy1 radius1: radius1
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_radial' (double double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateRasterSource: userData content: content width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_raster_source' (void* ushort long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateRgb: red green: green blue: blue
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_rgb' (double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternCreateRgba: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_create_rgba' (double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternDestroy: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetColorStopCount: pattern count: count
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_color_stop_count' (void* long* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetColorStopRgba: pattern index: index offset: offset red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_color_stop_rgba' (void* long double* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetExtend: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_extend' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetFilter: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_filter' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetLinearPoints: pattern x0: x0 y0: y0 x1: x1 y1: y1
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_linear_points' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetMatrix: pattern matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_get_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetRadialCircles: pattern x0: x0 y0: y0 r0: r0 x1: x1 y1: y1 r1: r1
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_radial_circles' (void* double* double* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetReferenceCount: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetRgba: pattern red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_rgba' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetSurface: pattern surface: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_surface' (void* void** ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetType: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_get_type' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternGetUserData: pattern key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternReference: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pattern_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternSetExtend: pattern extend: extend
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_set_extend' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternSetFilter: pattern filter: filter
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_set_filter' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternSetMatrix: pattern matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pattern_set_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternSetUserData: pattern key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
patternStatus: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_pattern_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
popGroup: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_pop_group' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
popGroupToSource: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_pop_group_to_source' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
pushGroup: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_push_group' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
pushGroupWithContent: cr content: content
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_push_group_with_content' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternGetAcquire: pattern acquire: acquire release: release
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_get_acquire' (void* void** void** ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternGetCallbackData: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_raster_source_pattern_get_callback_data' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternGetCopy: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_raster_source_pattern_get_copy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternGetFinish: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_raster_source_pattern_get_finish' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternGetSnapshot: pattern
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_raster_source_pattern_get_snapshot' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternSetAcquire: pattern acquire: acquire release: release
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_set_acquire' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternSetCallbackData: pattern data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_set_callback_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternSetCopy: pattern copy: copy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_set_copy' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternSetFinish: pattern finish: finish
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_set_finish' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rasterSourcePatternSetSnapshot: pattern snapshot: snapshot
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_raster_source_pattern_set_snapshot' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
recordingSurfaceCreate: content extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_recording_surface_create' (ushort void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
recordingSurfaceGetExtents: surface extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_recording_surface_get_extents' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
recordingSurfaceInkExtents: surface x0: x0 y0: y0 width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_recording_surface_ink_extents' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rectangle: cr x: x y: y width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rectangle' (void* double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rectangleListDestroy: rectangleList
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rectangle_list_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
reference: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionContainsPoint: region x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_region_contains_point' (void* long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionContainsRectangle: region rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_contains_rectangle' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionCopy: original
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_region_copy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionCreate
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_region_create' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionCreateRectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_region_create_rectangle' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionCreateRectangles: rects count: count
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_region_create_rectangles' (void* long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionDestroy: region
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_region_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionEqual: a b: b
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_region_equal' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionGetExtents: region extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_region_get_extents' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionGetRectangle: region nth: nth rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_region_get_rectangle' (void* long void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionIntersect: dst other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_intersect' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionIntersectRectangle: dst rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_intersect_rectangle' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionIsEmpty: region
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_region_is_empty' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionNumRectangles: region
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_region_num_rectangles' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionReference: region
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_region_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionStatus: region
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionSubtract: dst other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_subtract' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionSubtractRectangle: dst rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_subtract_rectangle' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionTranslate: region dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_region_translate' (void* long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionUnion: dst other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_union' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionUnionRectangle: dst rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_union_rectangle' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionXor: dst other: other
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_xor' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
regionXorRectangle: dst rectangle: rectangle
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_region_xor_rectangle' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
relCurveTo: cr dx1: dx1 dy1: dy1 dx2: dx2 dy2: dy2 dx3: dx3 dy3: dy3
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rel_curve_to' (void* double double double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
relLineTo: cr dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rel_line_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
relMoveTo: cr dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rel_move_to' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
resetClip: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_reset_clip' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
restore: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_restore' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
rotate: cr angle: angle
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_rotate' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
save: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_save' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scale: cr sx: sx sy: sy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scale' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontCreate: fontFace fontMatrix: fontMatrix ctm: ctm options: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_scaled_font_create' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontDestroy: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontExtents: scaledFont extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_extents' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetCtm: scaledFont ctm: ctm
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_get_ctm' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetFontFace: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_scaled_font_get_font_face' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetFontMatrix: scaledFont fontMatrix: fontMatrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_get_font_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetFontOptions: scaledFont options: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_get_font_options' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetReferenceCount: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_scaled_font_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetScaleMatrix: scaledFont scaleMatrix: scaleMatrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_get_scale_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetType: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_scaled_font_get_type' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGetUserData: scaledFont key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_scaled_font_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontGlyphExtents: scaledFont glyphs: glyphs numGlyphs: numGlyphs extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_glyph_extents' (void* void* long void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontReference: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_scaled_font_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontSetUserData: scaledFont key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_scaled_font_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontStatus: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_scaled_font_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontTextExtents: scaledFont utf8: utf8 extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_scaled_font_text_extents' (void* schar* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
scaledFontTextToGlyphs: scaledFont x: x y: y utf8: utf8 utf8Len: utf8Len glyphs: glyphs numGlyphs: numGlyphs clusters: clusters numClusters: numClusters clusterFlags: clusterFlags
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_scaled_font_text_to_glyphs' (void* double double schar* long void** long* void** long* ushort* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
selectFontFace: cr family: family slant: slant weight: weight
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_select_font_face' (void* schar* ushort ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setAntialias: cr antialias: antialias
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_antialias' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setDash: cr dashes: dashes numDashes: numDashes offset: offset
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_dash' (void* double* long double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setFillRule: cr fillRule: fillRule
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_fill_rule' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setFontFace: cr fontFace: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_font_face' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setFontMatrix: cr matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_font_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setFontOptions: cr options: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_font_options' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setFontSize: cr size: size
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_font_size' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setLineCap: cr lineCap: lineCap
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_line_cap' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setLineJoin: cr lineJoin: lineJoin
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_line_join' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setLineWidth: cr width: width
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_line_width' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setMatrix: cr matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_matrix' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setMiterLimit: cr limit: limit
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_miter_limit' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setOperator: cr op: op
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_operator' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setScaledFont: cr scaledFont: scaledFont
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_scaled_font' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setSource: cr source: source
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_source' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setSourceRgb: cr red: red green: green blue: blue
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_source_rgb' (void* double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setSourceRgba: cr red: red green: green blue: blue alpha: alpha
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_source_rgba' (void* double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setSourceSurface: cr surface: surface x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_source_surface' (void* void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setTolerance: cr tolerance: tolerance
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_set_tolerance' (void* double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
setUserData: cr key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
showGlyphs: cr glyphs: glyphs numGlyphs: numGlyphs
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_show_glyphs' (void* void* long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
showPage: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_show_page' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
showText: cr utf8: utf8
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_show_text' (void* schar* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
showTextGlyphs: cr utf8: utf8 utf8Len: utf8Len glyphs: glyphs numGlyphs: numGlyphs clusters: clusters numClusters: numClusters clusterFlags: clusterFlags
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_show_text_glyphs' (void* schar* long void* long void* long ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
status: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
statusToString: status
    "This was autogenerated by FFIGen"
    
    <cdecl: schar* 'cairo_status_to_string' (ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
stroke: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_stroke' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
strokeExtents: cr x1: x1 y1: y1 x2: x2 y2: y2
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_stroke_extents' (void* double* double* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
strokePreserve: cr
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_stroke_preserve' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceCopyPage: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_copy_page' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceCreateForRectangle: target x: x y: y width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_create_for_rectangle' (void* double double double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceCreateObserver: target mode: mode
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_create_observer' (void* ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceCreateSimilar: other content: content width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_create_similar' (void* ushort long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceCreateSimilarImage: other format: format width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_create_similar_image' (void* ushort long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceDestroy: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_destroy' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceFinish: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_finish' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceFlush: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_flush' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetContent: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_get_content' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetDevice: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_get_device' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetDeviceOffset: surface xOffset: xOffset yOffset: yOffset
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_get_device_offset' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetDeviceScale: surface xScale: xScale yScale: yScale
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_get_device_scale' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetFallbackResolution: surface xPixelsPerInch: xPixelsPerInch yPixelsPerInch: yPixelsPerInch
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_get_fallback_resolution' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetFontOptions: surface options: options
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_get_font_options' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetMimeData: surface mimeType: mimeType data: data length: length
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_get_mime_data' (void* schar* char** ulong* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetReferenceCount: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_get_reference_count' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetType: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_get_type' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceGetUserData: surface key: key
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_get_user_data' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceHasShowTextGlyphs: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_surface_has_show_text_glyphs' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceMapToImage: surface extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_map_to_image' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceMarkDirty: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_mark_dirty' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceMarkDirtyRectangle: surface x: x y: y width: width height: height
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_mark_dirty_rectangle' (void* long long long long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddFillCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_fill_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddFinishCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_finish_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddFlushCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_flush_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddGlyphsCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_glyphs_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddMaskCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_mask_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddPaintCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_paint_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverAddStrokeCallback: abstractSurface func: func data: data
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_add_stroke_callback' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverElapsed: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: double 'cairo_surface_observer_elapsed' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceObserverPrint: surface writeFunc: writeFunc closure: closure
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_observer_print' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceReference: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_surface_reference' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSetDeviceOffset: surface xOffset: xOffset yOffset: yOffset
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_set_device_offset' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSetDeviceScale: surface xScale: xScale yScale: yScale
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_set_device_scale' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSetFallbackResolution: surface xPixelsPerInch: xPixelsPerInch yPixelsPerInch: yPixelsPerInch
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_set_fallback_resolution' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSetMimeData: surface mimeType: mimeType data: data length: length destroy: destroy closure: closure
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_set_mime_data' (void* schar* char* ulong void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSetUserData: surface key: key userData: userData destroy: destroy
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_set_user_data' (void* void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceShowPage: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_show_page' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceStatus: surface
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_status' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceSupportsMimeType: surface mimeType: mimeType
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_surface_supports_mime_type' (void* schar* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceUnmapImage: surface image: image
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_surface_unmap_image' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceWriteToPng: surface filename: filename
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_write_to_png' (void* schar* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
surfaceWriteToPngStream: surface writeFunc: writeFunc closure: closure
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_surface_write_to_png_stream' (void* void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
textClusterAllocate: numClusters
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_text_cluster_allocate' (long ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
textClusterFree: clusters
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_text_cluster_free' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
textExtents: cr utf8: utf8 extents: extents
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_text_extents' (void* schar* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
textPath: cr utf8: utf8
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_text_path' (void* schar* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
toyFontFaceCreate: family slant: slant weight: weight
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_toy_font_face_create' (schar* ushort ushort ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
toyFontFaceGetFamily: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: schar* 'cairo_toy_font_face_get_family' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
toyFontFaceGetSlant: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_toy_font_face_get_slant' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
toyFontFaceGetWeight: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: ushort 'cairo_toy_font_face_get_weight' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
transform: cr matrix: matrix
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_transform' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
translate: cr tx: tx ty: ty
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_translate' (void* double double ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceCreate
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_user_font_face_create' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceGetInitFunc: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_user_font_face_get_init_func' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceGetRenderGlyphFunc: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_user_font_face_get_render_glyph_func' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceGetTextToGlyphsFunc: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_user_font_face_get_text_to_glyphs_func' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceGetUnicodeToGlyphFunc: fontFace
    "This was autogenerated by FFIGen"
    
    <cdecl: void* 'cairo_user_font_face_get_unicode_to_glyph_func' (void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceSetInitFunc: fontFace initFunc: initFunc
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_font_face_set_init_func' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceSetRenderGlyphFunc: fontFace renderGlyphFunc: renderGlyphFunc
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_font_face_set_render_glyph_func' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceSetTextToGlyphsFunc: fontFace textToGlyphsFunc: textToGlyphsFunc
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_font_face_set_text_to_glyphs_func' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userFontFaceSetUnicodeToGlyphFunc: fontFace unicodeToGlyphFunc: unicodeToGlyphFunc
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_font_face_set_unicode_to_glyph_func' (void* void* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userToDevice: cr x: x y: y
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_to_device' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
userToDeviceDistance: cr dx: dx dy: dy
    "This was autogenerated by FFIGen"
    
    <cdecl: void 'cairo_user_to_device_distance' (void* double* double* ) module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
version
    "This was autogenerated by FFIGen"
    
    <cdecl: long 'cairo_version' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-functions'!
versionString
    "This was autogenerated by FFIGen"
    
    <cdecl: schar* 'cairo_version_string' () module: 'libcairo'>
    ^ self externalCallFailed ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasBest
"This was autogenerated by FFIGen"

    ^ 6 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasDefault
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasFast
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasGood
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasGray
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasNone
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoAntialiasSubpixel
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoContentAlpha
"This was autogenerated by FFIGen"

    ^ 8192 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoContentColor
"This was autogenerated by FFIGen"

    ^ 4096 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoContentColorAlpha
"This was autogenerated by FFIGen"

    ^ 12288 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeCogl
"This was autogenerated by FFIGen"

    ^ 6 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeDrm
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeGl
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeInvalid
"This was autogenerated by FFIGen"

    ^ 4294967295 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeScript
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeWin32
"This was autogenerated by FFIGen"

    ^ 7 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeXcb
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeXlib
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoDeviceTypeXml
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoExtendNone
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoExtendPad
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoExtendReflect
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoExtendRepeat
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFillRuleEvenOdd
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFillRuleWinding
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterBest
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterBilinear
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterFast
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterGaussian
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterGood
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFilterNearest
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontSlantItalic
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontSlantNormal
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontSlantOblique
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontTypeFt
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontTypeQuartz
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontTypeToy
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontTypeUser
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontTypeWin32
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontWeightBold
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFontWeightNormal
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatA1
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatA8
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatArgb32
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatInvalid
"This was autogenerated by FFIGen"

    ^ 4294967295 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatRgb16565
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatRgb24
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoFormatRgb30
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintMetricsDefault
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintMetricsOff
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintMetricsOn
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintStyleDefault
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintStyleFull
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintStyleMedium
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintStyleNone
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoHintStyleSlight
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineCapButt
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineCapRound
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineCapSquare
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineJoinBevel
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineJoinMiter
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoLineJoinRound
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorAdd
"This was autogenerated by FFIGen"

    ^ 12 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorAtop
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorClear
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorColorBurn
"This was autogenerated by FFIGen"

    ^ 20 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorColorDodge
"This was autogenerated by FFIGen"

    ^ 19 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDarken
"This was autogenerated by FFIGen"

    ^ 17 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDest
"This was autogenerated by FFIGen"

    ^ 6 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDestAtop
"This was autogenerated by FFIGen"

    ^ 10 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDestIn
"This was autogenerated by FFIGen"

    ^ 8 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDestOut
"This was autogenerated by FFIGen"

    ^ 9 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDestOver
"This was autogenerated by FFIGen"

    ^ 7 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorDifference
"This was autogenerated by FFIGen"

    ^ 23 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorExclusion
"This was autogenerated by FFIGen"

    ^ 24 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorHardLight
"This was autogenerated by FFIGen"

    ^ 21 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorHslColor
"This was autogenerated by FFIGen"

    ^ 27 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorHslHue
"This was autogenerated by FFIGen"

    ^ 25 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorHslLuminosity
"This was autogenerated by FFIGen"

    ^ 28 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorHslSaturation
"This was autogenerated by FFIGen"

    ^ 26 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorIn
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorLighten
"This was autogenerated by FFIGen"

    ^ 18 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorMultiply
"This was autogenerated by FFIGen"

    ^ 14 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorOut
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorOver
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorOverlay
"This was autogenerated by FFIGen"

    ^ 16 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorSaturate
"This was autogenerated by FFIGen"

    ^ 13 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorScreen
"This was autogenerated by FFIGen"

    ^ 15 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorSoftLight
"This was autogenerated by FFIGen"

    ^ 22 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorSource
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoOperatorXor
"This was autogenerated by FFIGen"

    ^ 11 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPathClosePath
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPathCurveTo
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPathLineTo
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPathMoveTo
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeLinear
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeMesh
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeRadial
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeRasterSource
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeSolid
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoPatternTypeSurface
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoRegionOverlapIn
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoRegionOverlapOut
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoRegionOverlapPart
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusClipNotRepresentable
"This was autogenerated by FFIGen"

    ^ 22 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusDeviceError
"This was autogenerated by FFIGen"

    ^ 35 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusDeviceFinished
"This was autogenerated by FFIGen"

    ^ 37 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusDeviceTypeMismatch
"This was autogenerated by FFIGen"

    ^ 34 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusFileNotFound
"This was autogenerated by FFIGen"

    ^ 18 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusFontTypeMismatch
"This was autogenerated by FFIGen"

    ^ 25 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidClusters
"This was autogenerated by FFIGen"

    ^ 29 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidContent
"This was autogenerated by FFIGen"

    ^ 15 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidDash
"This was autogenerated by FFIGen"

    ^ 19 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidDscComment
"This was autogenerated by FFIGen"

    ^ 20 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidFormat
"This was autogenerated by FFIGen"

    ^ 16 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidIndex
"This was autogenerated by FFIGen"

    ^ 21 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidMatrix
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidMeshConstruction
"This was autogenerated by FFIGen"

    ^ 36 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidPathData
"This was autogenerated by FFIGen"

    ^ 9 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidPopGroup
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidRestore
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidSize
"This was autogenerated by FFIGen"

    ^ 32 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidSlant
"This was autogenerated by FFIGen"

    ^ 30 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidStatus
"This was autogenerated by FFIGen"

    ^ 6 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidStride
"This was autogenerated by FFIGen"

    ^ 24 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidString
"This was autogenerated by FFIGen"

    ^ 8 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidVisual
"This was autogenerated by FFIGen"

    ^ 17 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusInvalidWeight
"This was autogenerated by FFIGen"

    ^ 31 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusJbig2GlobalMissing
"This was autogenerated by FFIGen"

    ^ 38 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusLastStatus
"This was autogenerated by FFIGen"

    ^ 39 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusNegativeCount
"This was autogenerated by FFIGen"

    ^ 28 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusNoCurrentPoint
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusNoMemory
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusNullPointer
"This was autogenerated by FFIGen"

    ^ 7 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusPatternTypeMismatch
"This was autogenerated by FFIGen"

    ^ 14 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusReadError
"This was autogenerated by FFIGen"

    ^ 10 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusSuccess
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusSurfaceFinished
"This was autogenerated by FFIGen"

    ^ 12 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusSurfaceTypeMismatch
"This was autogenerated by FFIGen"

    ^ 13 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusTempFileError
"This was autogenerated by FFIGen"

    ^ 23 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusUserFontError
"This was autogenerated by FFIGen"

    ^ 27 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusUserFontImmutable
"This was autogenerated by FFIGen"

    ^ 26 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusUserFontNotImplemented
"This was autogenerated by FFIGen"

    ^ 33 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoStatusWriteError
"This was autogenerated by FFIGen"

    ^ 11 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSubpixelOrderBgr
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSubpixelOrderDefault
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSubpixelOrderRgb
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSubpixelOrderVbgr
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSubpixelOrderVrgb
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceObserverNormal
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceObserverRecordOperations
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeBeos
"This was autogenerated by FFIGen"

    ^ 8 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeCogl
"This was autogenerated by FFIGen"

    ^ 24 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeDirectfb
"This was autogenerated by FFIGen"

    ^ 9 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeDrm
"This was autogenerated by FFIGen"

    ^ 19 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeGl
"This was autogenerated by FFIGen"

    ^ 18 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeGlitz
"This was autogenerated by FFIGen"

    ^ 5 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeImage
"This was autogenerated by FFIGen"

    ^ 0 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeOs2
"This was autogenerated by FFIGen"

    ^ 11 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypePdf
"This was autogenerated by FFIGen"

    ^ 1 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypePs
"This was autogenerated by FFIGen"

    ^ 2 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeQt
"This was autogenerated by FFIGen"

    ^ 15 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeQuartz
"This was autogenerated by FFIGen"

    ^ 6 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeQuartzImage
"This was autogenerated by FFIGen"

    ^ 13 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeRecording
"This was autogenerated by FFIGen"

    ^ 16 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeScript
"This was autogenerated by FFIGen"

    ^ 14 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeSkia
"This was autogenerated by FFIGen"

    ^ 22 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeSubsurface
"This was autogenerated by FFIGen"

    ^ 23 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeSvg
"This was autogenerated by FFIGen"

    ^ 10 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeTee
"This was autogenerated by FFIGen"

    ^ 20 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeVg
"This was autogenerated by FFIGen"

    ^ 17 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeWin32
"This was autogenerated by FFIGen"

    ^ 7 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeWin32Printing
"This was autogenerated by FFIGen"

    ^ 12 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeXcb
"This was autogenerated by FFIGen"

    ^ 4 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeXlib
"This was autogenerated by FFIGen"

    ^ 3 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoSurfaceTypeXml
"This was autogenerated by FFIGen"

    ^ 21 ! !

!Cairo class methodsFor: 'ffi-enums'!
CairoTextClusterFlagBackward
"This was autogenerated by FFIGen"

    ^ 1 ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 20:26:20'!
clip
	Cairo clip: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 20:27:11'!
clipExtents: aRectangle
	Cairo clipExtents: ctx x1: aRectangle origin x  y1: aRectangle origin y  x2: aRectangle corner x  y2: aRectangle corner y! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 20:26:27'!
clipPreserve
	Cairo clipPreserve: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/26/2019 10:36:31'!
closePath
	Cairo closePath: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 09:31:36'!
context
	^ ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/20/2019 10:36:21'!
curveTo: aPoint control1: control1 control2: control2
	Cairo curveTo:  ctx x1: control1 x asFloat y1: control1 y asFloat x2: control2 x  asFloat y2: control2 y asFloat  x3: aPoint x asFloat  y3: aPoint y asFloat ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 02:03'!
destroy
	Cairo destroy: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/30/2019 12:49:13'!
deviceToUser: aPoint

	| x y  |
	
	x _ ExternalAddress gcallocate: (ExternalType atomicTypeNamed: 'double') byteSize.
	y _ ExternalAddress gcallocate: (ExternalType atomicTypeNamed: 'double') byteSize.
	
	x doubleAt: 1 put: aPoint x.
	y doubleAt: 1 put: aPoint y.
	
	Cairo deviceToUser: ctx x: x  y: y.	
	
	^ Point x: (x doubleAt: 1) y: (y doubleAt: 1)! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 09:28:25'!
fill
	Cairo fill: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 01:43'!
initialize: aCairoContext
	ctx _ aCairoContext! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 01:46'!
lineTo: aPoint
	Cairo lineTo: ctx x: aPoint x y: aPoint y! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/19/2019 19:27:44'!
moveTo: aPoint
	Cairo moveTo: ctx x: aPoint x asFloat y: aPoint y asFloat! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 11/2/2019 13:35:33'!
newPath
	Cairo newPath: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 12:46:06'!
paint
	Cairo paint: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/18/2019 17:45:06'!
rectangle: rect
	Cairo rectangle: ctx 
			x: rect origin x asFloat  
			y: rect origin y asFloat  
			width: rect width asFloat  
			height: rect height asFloat ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 09:29:20'!
rectangleFrom: aPoint extent: anotherPoint
	self rectangle: (aPoint extent: anotherPoint)! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 09:29:11'!
rectangleFrom: aPoint to: anotherPoint
	self rectangle: (aPoint to: anotherPoint)! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 02:02'!
restore
	Cairo restore: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 16:14:40'!
rotate: angle
	Cairo rotate: ctx angle: angle! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 15:48:56'!
roundedRectangle: aRectangle radius: r
	"Draw a rounded rectangle"
    "#   A****BQ
       #  H      C
       #  *      *
       #  G      D
       #   F****E"

	"Cairo at: 0@0 extent: 100@100 display: [:ctx |
	ctx setSourceColor: Color white;
		rectangleFrom: 0@0 extent: 100@100;
		fill;
		setSourceColor: Color blue;
		setLineWidth: 3;
		roundedRectangle: (10@10 extent: 70@70) radius: 10;
		stroke] "

	self moveTo: (aRectangle origin x + r)@aRectangle origin y; "Move to A"
		lineTo: (aRectangle corner x - r)@aRectangle origin y; "Line to B"
		curveTo: (aRectangle corner x@(aRectangle origin y + r)) "Q corner"
			control1: (aRectangle corner x@aRectangle origin y)
			control2: (aRectangle corner x@aRectangle origin y);
		lineTo: (aRectangle corner x@(aRectangle corner y - r)); "Line to D"
		curveTo: (aRectangle corner x - r)@aRectangle corner y 
			control1: aRectangle corner
			control2: aRectangle corner;
		lineTo: ((aRectangle origin x + r)@aRectangle corner y);
		curveTo: (aRectangle origin x@(aRectangle corner y - r))
				control1: (aRectangle origin x@aRectangle corner y)
				control2:  (aRectangle origin x@aRectangle corner y);
		lineTo: (aRectangle origin x@(aRectangle origin y + r));
		curveTo: (aRectangle origin x + r@aRectangle origin y)
			control1: aRectangle origin
			control2: aRectangle origin! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 02:02'!
save
	Cairo save: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 16:15:15'!
scale: aPoint
	Cairo scale: ctx x: aPoint x y: aPoint y! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:18:56'!
selectFontFace: familiy slant: slant weight: weight
	Cairo selectFontFace: ctx family: familiy slant: slant weight: weight! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 21:20:06'!
setFontSize: size
	Cairo setFontSize: ctx size: size ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 01:48'!
setLineWidth: aNumber
	Cairo setLineWidth: ctx width: aNumber! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 12:53:57'!
setOperator: op
	Cairo setOperator: ctx operator: op ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:38:44'!
setSourceColor: aColor
	Cairo setSourceRGBA: ctx r: aColor red g: aColor green b: aColor blue a: aColor alpha! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 09:41:40'!
setSourceColor: aColor alpha: alpha
	Cairo setSourceRGBA: ctx r: aColor red g: aColor green b: aColor blue a: alpha! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/9/2019 12:45:32'!
setSourceSurface: surface at: aPoint
	Cairo setSourceSurface: ctx surface: surface  x: aPoint x  y: aPoint y ! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 19:19:31'!
showText: aString
	Cairo showText: ctx text: aString! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/6/2019 02:02'!
stroke
	Cairo stroke: ctx! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/7/2019 16:15:01'!
translate: aPoint
	Cairo translate: ctx x: aPoint x y: aPoint y! !

!CairoContext methodsFor: 'as yet unclassified' stamp: 'MM 10/30/2019 12:49:01'!
userToDevice: aPoint
	|x y|
	x _ ExternalAddress gcallocate: (ExternalType atomicTypeNamed: 'double') byteSize.
	y _ ExternalAddress gcallocate: (ExternalType atomicTypeNamed: 'double') byteSize.
	
	x doubleAt: 1 put: aPoint x.
	y doubleAt: 1 put: aPoint y.
	
	Cairo userToDevice: ctx x: x  y: y.
	
	^ Point x: (x doubleAt: 1) y: (y doubleAt: 1) ! !

!CairoContext class methodsFor: 'examples' stamp: 'MM 10/6/2019 02:04'!
example1
	|surf status ctx |

surf _ Cairo imageSurfaceCreate:0 width:100 height: 100.

status _ Cairo surfaceStatus: surf.

Cairo statusToString: status.

ctx _ CairoContext on: (Cairo create: surf).

ctx setSourceColor: Color red.
ctx moveTo: 0@0;
	lineTo: 50@50;
	setLineWidth: 3;
	stroke.
	
ctx destroy.

Cairo surfaceWriteToPNG: surf filename: 'cairo_test1.png'.! !

!CairoContext class methodsFor: 'examples' stamp: 'MM 10/7/2019 17:28:17'!
exampleRotate

	"self exampleRotate"
	0 to: Float pi * 100 by: 5 do: [:r |
	(Delay forSeconds: 0.1) wait.
	Cairo at: 0@0 extent: 100@100 display: [:ctx |
		ctx setSourceColor: Color white;
			rectangleFrom: 0@0 extent: 100@100;
			fill;
			translate: 45@45;
			rotate: (r / 100) asFloat;
			translate: -45@-45;
			setSourceColor: Color blue;
			setLineWidth: 3;
			roundedRectangle: (10@10 extent: 70@70) radius: 10;
			stroke]] ! !

!CairoContext class methodsFor: 'examples' stamp: 'MM 10/7/2019 17:28:45'!
exampleScale

	"self exampleScale"
	1 to: 100 do: [:s |
	(Delay forSeconds: 0.05) wait.
	Cairo at: 0@0 extent: 100@100 display: [:ctx |
		ctx setSourceColor: Color white;
			rectangleFrom: 0@0 extent: 100@100;
			fill;
			scale: (s / 100) asFloat @ (s/100) asFloat ;
			setSourceColor: Color blue;
			setLineWidth: 3;
			roundedRectangle: (10@10 extent: 70@70) radius: 10;
			stroke]] ! !

!CairoContext class methodsFor: 'instance creation' stamp: 'MM 10/6/2019 01:43'!
on: aCairoContext
	^ self new initialize: aCairoContext! !

!CairoSurface methodsFor: 'accessing' stamp: 'MM 10/12/2019 13:46:39'!
externalForm
	"Answer the value of externalForm"

	^ externalForm! !

!CairoSurface methodsFor: 'accessing' stamp: 'MM 10/12/2019 13:46:39'!
externalForm: anObject
	"Set the value of externalForm"

	externalForm _ anObject! !

!CairoSurface methodsFor: 'accessing' stamp: 'MM 10/12/2019 13:46:39'!
surface
	"Answer the value of surface"

	^ surface! !

!CairoSurface methodsFor: 'accessing' stamp: 'MM 10/12/2019 13:46:39'!
surface: anObject
	"Set the value of surface"

	surface _ anObject! !

!CairoSurface methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 17:09:46'!
finalize
	self release! !

!CairoSurface methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 13:59:39'!
release
	Cairo surfaceDestroy: surface.
	externalForm destroySurface.! !
