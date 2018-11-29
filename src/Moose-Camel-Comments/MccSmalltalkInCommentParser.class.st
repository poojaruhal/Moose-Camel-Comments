"
Array streamContents: [ :aStream |
	| result string |
	
	string := 'ha

object := Object new.

asdadasdasd

object printString.
object.

asfafasfj' copyReplaceAll: String cr with: String cr, '.'.


	result := (MccSmalltalkInCommentParser new sea) parse: string.
	
	[ result isNotEmpty and: [ string isNotEmpty ] ] whileTrue: [
		aStream nextPut: (result first as: String).
		aStream nextPut: (result second).
		string := result third as: String.
		result := (MccSmalltalkInCommentParser new sea) parse: string.
	] ]
"
Class {
	#name : #MccSmalltalkInCommentParser,
	#superclass : #PP2PluggableNode,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #parsing }
MccSmalltalkInCommentParser class >> parse: aString [
	| aStringToSplit |

	aString
		ifEmpty: [ ^ #() ].

	aStringToSplit := ({ Character cr . Character lf } includes: aString last)
		ifTrue: [ aString ]
		ifFalse: [
			aString, String cr ]. 

	^ Array streamContents: [ :aStream |
		aStringToSplit
			splitOn: ('(\',String cr,'|\', String lf, ')[\s|\-]*(\',String cr,'|\', String lf, ')') asRegex
			indicesDo: [ :aStart :anEnd |
				| tokenToParse |
				
				"initial value"
				tokenToParse := MccSmalltalkSnippetToken
					on: aString
					start: (aStart min: aString size) stop: (anEnd min: aString size).
				
				[ (tokenToParse := self processToken: tokenToParse in: aStream of: aString) isEmpty ] whileFalse ] ]
]

{ #category : #parsing }
MccSmalltalkInCommentParser class >> processToken: aToken in: aStream of: aString [
	| parsedResult theTextToken theCode theCodeToken nextToken |
					
	parsedResult := (MccSmalltalkInCommentParser new sea) parse: aToken value.

	"the island (second item) is the AST"
	theCode := parsedResult second.

	theCodeToken := MccSmalltalkCodeToken
		on: aString
		start: theCode sourceInterval first + aToken start - 1
		stop: ((parsedResult third isEmpty and: [ theCode sourceInterval isNotEmpty ]) ifTrue: [ aToken stop ] ifFalse: [ theCode sourceInterval last + aToken start - 1 ]).
	theCodeToken ast: theCode.

	theTextToken := MccSmalltalkTextToken
		on: aString
		start: aToken start
		stop: (theCodeToken isEmpty ifTrue: [ aToken stop ] ifFalse: [ (theCodeToken start - 1) ]).
		
	theTextToken isEmpty
		ifFalse: [ aStream nextPut: theTextToken ].

	theCodeToken isEmpty
		ifFalse: [ aStream nextPut: theCodeToken ].
	
	nextToken := MccSmalltalkSnippetToken
		on: aString
		start: aToken stop - parsedResult third size + 1
		stop: aToken stop.

	^ nextToken
]

{ #category : #visiting }
MccSmalltalkInCommentParser >> accept: aPP2ParserVisitor [
	^ true
]

{ #category : #'parsing - adaptable' }
MccSmalltalkInCommentParser >> parseOn: aPP2Context [
	^ strategy parseOn: aPP2Context
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> resetStrategy [
	strategy := MccSmalltalkInCommentStrategy on: self
]
