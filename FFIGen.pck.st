'From Cuis 5.0 [latest update: #3866] on 12 October 2019 at 7:17:51 pm'!
'Description Automatic FFI generator from c2ffi.

Author: Mariano Montone <marianomontone@gmail.com>

See: https://github.com/rpav/c2ffi'!
!provides: 'FFIGen' 1 26!
!requires: 'FFI' 1 35 nil!
!requires: 'JSON' 1 19 nil!
SystemOrganization addCategory: #FFIGen!


!classDefinition: #FFIGenerator category: #FFIGen!
Object subclass: #FFIGenerator
	instanceVariableNames: 'libraryName className categoryName outputFile inputFile autogeneratedMessage json outputStream removePrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFIGen'!
!classDefinition: 'FFIGenerator class' category: #FFIGen!
FFIGenerator class
	instanceVariableNames: ''!

!classDefinition: #SimpleFFIGenerator category: #FFIGen!
FFIGenerator subclass: #SimpleFFIGenerator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFIGen'!
!classDefinition: 'SimpleFFIGenerator class' category: #FFIGen!
SimpleFFIGenerator class
	instanceVariableNames: ''!

!classDefinition: #SmalltalkWriter category: #FFIGen!
Object subclass: #SmalltalkWriter
	instanceVariableNames: 'stream indentation indentSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFIGen'!
!classDefinition: 'SmalltalkWriter class' category: #FFIGen!
SmalltalkWriter class
	instanceVariableNames: ''!


!SimpleFFIGenerator commentStamp: 'MM 10/11/2019 23:11:17' prior: 0!
Opinionated FFI generator.

Examples: 

SimpleFFIGenerator new
	inputFile: '/home/marian/src/Cuis/mold/cairo-ffi.json';
	outputFile: '/home/marian/src/Cuis/mold/CairoFFI.st';
	className: #CairoFFI;
	categoryName: 'Cairo';
	libraryName: 'libcairo';
	removePrefix: 'cairo_';
	generate.
	
SimpleFFIGenerator new
	inputFile: '/home/marian/src/Cuis/mold/nanovg-ffi.json';
	outputFile: '/home/marian/src/Cuis/mold/NanoVGFFI.st';
	className: #NanoVG;
	categoryName: 'NanoVG';
	libraryName: 'nanovg';
	removePrefix: 'nvg';
	generate.!

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 18:51:16'!
autogeneratedMessage
	"Answer the value of autogeneratedMessage"

	^ autogeneratedMessage! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 18:51:16'!
autogeneratedMessage: anObject
	"Set the value of autogeneratedMessage"

	autogeneratedMessage _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 18:48:00'!
categoryName
	"Answer the value of categoryName"

	^ categoryName! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 18:48:00'!
categoryName: anObject
	"Set the value of categoryName"

	categoryName _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 18:48:00'!
className: anObject
	"Set the value of className"

	className _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:46:42'!
inputFile
	"Answer the value of inputFile"

	^ inputFile! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:46:42'!
inputFile: anObject
	"Set the value of inputFile"

	inputFile _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
json
	"Answer the value of json"

	^ json! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
json: anObject
	"Set the value of json"

	json _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:45:52'!
libraryName
	"Answer the value of libraryName"

	^ libraryName! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:45:52'!
libraryName: anObject
	"Set the value of libraryName"

	libraryName _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:45:52'!
outputFile
	"Answer the value of outputFile"

	^ outputFile! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 16:45:52'!
outputFile: anObject
	"Set the value of outputFile"

	outputFile _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
outputStream
	"Answer the value of outputStream"

	^ outputStream! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
outputStream: anObject
	"Set the value of outputStream"

	outputStream _ anObject! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
removePrefix
	"Answer the value of removePrefix"

	^ removePrefix! !

!FFIGenerator methodsFor: 'accessing' stamp: 'MM 10/11/2019 23:06:50'!
removePrefix: anObject
	"Set the value of removePrefix"

	removePrefix _ anObject! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 20:20:42'!
asCamelCase: aString
	"Answer a new String, without any whitespace, and with words capitalized (Except for the first one)
	' how do you do? ' asCamelCase
	"
	^ String streamContents: [ :outStream | | inStream capitalize wroteSome |
		wroteSome _ false.
		capitalize _ false.
		inStream _ aString readStream.
		[ inStream atEnd ] whileFalse: [ | c |
			c _ inStream next.
			c = $_
				ifTrue: [ capitalize _ true ]
				ifFalse: [
					capitalize & wroteSome ifTrue: [ c _ c asUppercase ].
					outStream nextPut: c.
					wroteSome _ true.
					capitalize _ false ]]]! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:05:26'!
finishGeneration: aStream
	! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:36:16'!
generate
	json _ Json readFrom: inputFile asFileEntry readStream.
	outputFile asFileEntry writeStreamDo: [:s |
		outputStream _ SmalltalkWriter on: s.
		json explore.
		self startGeneration: outputStream.
		json do: [:val | |methodName|
			methodName _ ('generate', val tag capitalized, ':on:') asSymbol.
			self perform: methodName withArguments: {val. outputStream}].
		self finishGeneration: outputStream.
		s contents asText edit.
		s close].! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:04:04'!
generateEnum: definition on: aStream! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:01:13'!
generateFunction: aFunction on: aStream
	! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:03:39'!
generateStruct: definition on: aStream! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:01:41'!
generateTypedef: aTypedef on: aStream! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:04:21'!
generateUnion: definition on: aStream! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 23:09:29'!
initialize
	autogeneratedMessage _ 'This was autogenerated by FFIGen'.
	removePrefix _ ''! !

!FFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:17:55'!
startGeneration: aStream
	! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 22:54:05'!
findType: aType
	^ json detect: [:x | x name = aType] ifNone: [self error: 'Invalid type: ', aType] ! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 18:58:21'!
generateEnum: definition on: aStream
	definition fields do: [:field |
		self generateEnumValue: field on: aStream]! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 19:06:49'!
generateEnumValue: anEnumValue on: aStream

	aStream wl: '!!', className, ' class methodsFor: ''ffi-enums'' !!';
	            wl: (self asCamelCase: anEnumValue name asLowercase capitalized);
			wl: '"', autogeneratedMessage , '"'; newLine;
			  indentedDo: [
				aStream wl: '^ ', anEnumValue value asString, ' !! !! ']! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 22:25:25'!
generateFunction: aFunction on: aStream

	|returnType|
	
	returnType _ aFunction at: 'return-type'.
	
	aStream wl: '!!', className, ' class methodsFor: ''ffi-functions'' !!';
	            wl: (self methodDefFor: aFunction);
			indentedDo: [
				aStream wl: '"', autogeneratedMessage , '"'; newLine;
						w: '<cdecl: ';
						w: (self getFFIType: returnType).
				aStream w: ' ''', aFunction name , ''' ('.
				aFunction parameters do: [:param |
					aStream nextPutAll: (self getFFIType: param type).
					aStream nextPut: Character space].
				aStream wl: ') module: ''', libraryName, '''>';
						  wl: '^ self externalCallFailed !! !!'; newLine]
				
	! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 22:33:05'!
getFFIPointerType: aType
	^ (self getFFIType: aType type) , '*'! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 19:17:47'!
getFFIType: aType

	|typeSymbol|
	
	typeSymbol _ aType tag allButFirst asString asSymbol.
	
	^ typeSymbol caseOf: {
		[#int] -> ['long'].
		[#void] -> ['void'].
		[#'unsigned-int'] -> ['ushort'].
		[#'unsigned-long'] -> ['ulong'].
		[#float] -> ['float'].
		[#double] -> ['double'].
		[#char] -> ['schar'].
		[#'unsigned-char'] -> ['char'].
		[#pointer] -> [self getFFIPointerType: aType].
	} otherwise: [self getNonPrimitiveFFIType: aType]
! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 22:59:58'!
getNonPrimitiveFFIType: aType
	"^ aType tag"
	"Simplifcation: An object pointer or an enum"
	|type|
	
	type _ self findType: aType tag.
	type tag = 'typedef' ifTrue: [type _ type type].
	
	^ type tag caseOf: {
		[':enum'] -> ['ushort'].
		[':struct'] -> ['void'].
		['enum'] -> ['ushort'].
		['struct'] -> ['void'].
		[':function-pointer'] -> ['void*']}
		otherwise: [self getFFIType: type]! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/12/2019 19:07:24'!
methodDefFor: aFunction
	^ (String streamContents: [:s | 
		s nextPutAll: (self asCamelCase: (aFunction name withoutPrefix: removePrefix) uncapitalized) .
		aFunction parameters ifNotEmpty: [
			s nextPutAll: ': ', (self asCamelCase: aFunction parameters first name).
			aFunction parameters allButFirst do: [:param |
				s nextPutAll: ' ', (self asCamelCase: param name), ': ', (self asCamelCase: param name)]	
		]]) asSymbol! !

!SimpleFFIGenerator methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 20:02:20'!
startGeneration: aStream
	
	aStream w: '!!classDefinition: #', className, ' category: #', categoryName, '!!'; newLine.

	aStream wl: 'Object subclass: #', className;
			   indentedDo: [
				aStream    wl: 'instanceVariableNames: ''''';
							wl: 'classVariableNames: ''''';
							wl: 'poolDictionaries: ''''';
							wl: 'category: ''', categoryName, '''!!'; newLine; newLine].
						
	aStream w: '!!classDefinition: #', className, ' class category: #', categoryName, '!!'; newLine.
						
	aStream wl: className, ' class instanceVariableNames: '''' !!'; newLine; newLine. ! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:21:37'!
cr
	self newLine! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:23:35'!
indent
	indentation timesRepeat: [stream nextPut: Character space].! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:23:40'!
indentedDo: aBlock
	indentation _ indentation + indentSize.
	self indent.
	aBlock value.
	indentation _ indentation - indentSize! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:13:12'!
initialize: aStream
	stream _ aStream.
	indentation _ 0.
	indentSize _ 4.! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:23:30'!
newLine
	stream newLine.
	self indent.! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:11:07'!
nextPut: aChar
	stream nextPut: aChar! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:20:17'!
nextPutAll: aString
	stream nextPutAll: aString! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:13:27'!
w: aString
	self writeString: aString! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:14:42'!
wl: aString
	self writeLine: aString! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:21:45'!
writeLine: aString
	stream nextPutAll: aString. self newLine.! !

!SmalltalkWriter methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:13:54'!
writeString: aString
	stream nextPutAll: aString! !

!SmalltalkWriter class methodsFor: 'as yet unclassified' stamp: 'MM 10/11/2019 19:10:42'!
on: aStream
	^ self new initialize: aStream! !