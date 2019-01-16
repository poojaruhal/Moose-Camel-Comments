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
	| aStringToSplit theNodes |

	aString
		ifEmpty: [ ^ #() ].

	aStringToSplit := ({ Character cr . Character lf } includes: aString last)
		ifTrue: [ aString ]
		ifFalse: [
			aString, String cr ]. 

	
		
		
	theNodes := Array streamContents: [ :aStream |
		aStringToSplit
			splitOn: ('(\',String cr,'|\', String lf, ')[\s|\-]*(\',String cr,'|\', String lf, ')') asRegex
			indicesDo: [ :aStart :anEnd |
				| tokenToParse |
				
				"initial value"
				tokenToParse := MccSmalltalkSnippetToken
					on: aString
					start: (aStart min: aString size) stop: (anEnd min: aString size).
				
				aStream nextPut: tokenToParse parse ] ].
		
	^ (theNodes size = 1)
		ifTrue: [ theNodes first ]
		ifFalse: [ (MccSmalltalkCompositeToken on: aString start: 1 stop: aString size) children: (theNodes) ]
]

{ #category : #visiting }
MccSmalltalkInCommentParser >> accept: aPP2ParserVisitor [
	^ self
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> initialize [
	super initialize.

	self isNullable: true
]

{ #category : #'parsing - adaptable' }
MccSmalltalkInCommentParser >> parseOn: aPP2Context [
	^ strategy parseOn: aPP2Context
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> resetStrategy [
	strategy := MccSmalltalkInCommentStrategy on: self
]
