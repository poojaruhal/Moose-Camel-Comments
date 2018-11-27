"
'ha' asPParser, [ :aPP2Context |
	| position smalltalkParser aResult |
	position := aPP2Context rememberPosition.

	smalltalkParser := MccSmalltalkInCommentParser new.
	aResult := smalltalkParser parseOn: aPP2Context.
	
	aResult isPetit2Failure
		ifTrue: [ aPP2Context restorePosition: position ]
		ifFalse: [
			aResult isVariable
				ifTrue: [ aPP2Context restorePosition: position ]
				ifFalse: [  ] ].
	aResult
	] asPParser, #any asPParser star parse: 'haOb[ject class'
"
Class {
	#name : #MccParseCommentPlainCode,
	#superclass : #MccParseComment,
	#instVars : [
		'smalltalk',
		'smalltalkSea'
	],
	#category : 'Moose-Camel-Comments'
}

{ #category : #'as yet unclassified' }
MccParseCommentPlainCode >> smalltalk [
	^ string, MccSmalltalkInCommentParser new, string
]

{ #category : #'as yet unclassified' }
MccParseCommentPlainCode >> smalltalkSea [
	^ (smalltalk sea ==> #second) star
]

{ #category : #accessing }
MccParseCommentPlainCode >> start [ 
	^ smalltalk end
]
