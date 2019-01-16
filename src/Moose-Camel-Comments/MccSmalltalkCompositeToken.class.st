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
