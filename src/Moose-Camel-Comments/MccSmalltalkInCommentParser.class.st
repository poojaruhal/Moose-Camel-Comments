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
	| theSnippets aStringToSplit  |

	aString
		ifEmpty: [ ^ aString ].

	aStringToSplit := ({ Character cr . Character lf } includes: aString last)
		ifTrue: [ aString ]
		ifFalse: [ aString, String cr ]. 

	theSnippets := aStringToSplit splitOn: ('(\',String cr,'|\', String lf, ')[\s|\-]*(\',String cr,'|\', String lf, ')') asRegex.

	^ theSnippets flatCollect: [ :eachSnippet |
		Array streamContents: [ :aStream |
			| result stringToParse |
			
			stringToParse := eachSnippet.
			result := (MccSmalltalkInCommentParser new sea) parse: stringToParse.
			
			[ result isNotEmpty and: [ stringToParse isNotEmpty ] ] whileTrue: [
				aStream nextPut: (result first as: String).
				aStream nextPut: (result second).
				stringToParse := result third as: String.
				result := (MccSmalltalkInCommentParser new sea) parse: stringToParse ] ] ]
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
