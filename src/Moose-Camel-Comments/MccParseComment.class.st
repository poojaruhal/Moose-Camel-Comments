Class {
	#name : #MccParseComment,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'string'
	],
	#category : #'Moose-Camel-Comments'
}

{ #category : #accessing }
MccParseComment >> start [ 
	^ string end
]

{ #category : #accessing }
MccParseComment >> string [
	^ #any asPParser starLazy
]
