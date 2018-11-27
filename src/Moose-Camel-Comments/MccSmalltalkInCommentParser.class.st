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
	#superclass : #PP2Node,
	#category : 'Moose-Camel-Comments-Parser'
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
				| eachSnippetToken tokenToParse theCode theCodeToken |

				eachSnippetToken := PP2Token
					on: aString
					start: (aStart min: aString size) stop: (anEnd min: aString size).
				
				tokenToParse := eachSnippetToken.
				
				[ tokenToParse value isNotEmpty ] whileTrue: [
					| parsedResult |
					parsedResult := (MccSmalltalkInCommentParser new sea) parse: tokenToParse value.
					theCode := parsedResult second.
					theCodeToken := PP2Token
						on: aString
						start: (theCode sourceInterval first min: theCode sourceInterval last) + tokenToParse start - 1
						stop: theCode sourceInterval last + tokenToParse start - 1.
					
					theCode sourceInterval
						ifNotEmpty: [ aStream nextPut: theCodeToken ].
					
					tokenToParse := PP2Token
						on: aString
						start: (tokenToParse start + parsedResult first size - 1 + theCode sourceInterval size + aStart) stop: (anEnd min: aString size).

					tokenToParse ] ] ].
]

{ #category : #visiting }
MccSmalltalkInCommentParser >> accept: aPP2ParserVisitor [
	^ aPP2ParserVisitor visitPluggable: self
]

{ #category : #'parsing - adaptable' }
MccSmalltalkInCommentParser >> parseOn: aPP2Context [
	^ strategy parseOn: aPP2Context
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> resetStrategy [
	strategy := MccSmalltalkInCommentStrategy on: self
]
