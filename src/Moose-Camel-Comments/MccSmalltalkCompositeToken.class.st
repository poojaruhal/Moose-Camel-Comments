Class {
	#name : #MccSmalltalkCompositeToken,
	#superclass : #MccSmalltalkToken,
	#instVars : [
		'children'
	],
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #accessing }
MccSmalltalkCompositeToken >> children [
	^ children
]

{ #category : #accessing }
MccSmalltalkCompositeToken >> children: aCollecitonOfNodes [
	children := aCollecitonOfNodes
]

{ #category : #testing }
MccSmalltalkCompositeToken >> isEmpty [
	<return: #Boolean>

	^ children allSatisfy: #isEmpty
]

{ #category : #parsing }
MccSmalltalkCompositeToken >> parse [
	<return: #MccSmalltalkToken>
		
	children := children select: #isNotEmpty thenCollect: #parse.
	
	^ self
]

{ #category : #'as yet unclassified' }
MccSmalltalkCompositeToken >> textAndCodeTokens [

	| allTokens textAndCodeTokens |
	
	allTokens := self withDeepCollect: #children.
	textAndCodeTokens := allTokens
		reject: [ :each | each isKindOf: self class ].
	^ textAndCodeTokens sort: [ :a :b | a start < b start ]
]
