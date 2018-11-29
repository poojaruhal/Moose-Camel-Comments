Class {
	#name : #MccParseCommentPlainCode,
	#superclass : #MccParseComment,
	#instVars : [
		'smalltalk',
		'smalltalkSea'
	],
	#category : #'Moose-Camel-Comments'
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
