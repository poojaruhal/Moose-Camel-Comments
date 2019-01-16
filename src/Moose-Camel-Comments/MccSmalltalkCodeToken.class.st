Class {
	#name : #MccSmalltalkCodeToken,
	#superclass : #MccSmalltalkToken,
	#instVars : [
		'ast'
	],
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #accessing }
MccSmalltalkCodeToken >> ast [
	^ ast
]

{ #category : #accessing }
MccSmalltalkCodeToken >> ast: anObject [
	ast := anObject
]

{ #category : #enumerating }
MccSmalltalkCodeToken >> codeDo: aBlock [
	"Evaluate a given block if I am a code token"
	
	aBlock value: self
]

{ #category : #enumerating }
MccSmalltalkCodeToken >> codeOrTextDo: aBlock [
	aBlock value: self
]

{ #category : #testing }
MccSmalltalkCodeToken >> isCode [
	^ true
]

{ #category : #testing }
MccSmalltalkCodeToken >> isEmpty [
	<return: #Boolean>
	
	^ self ast sourceInterval isEmpty
]

{ #category : #parsing }
MccSmalltalkCodeToken >> parse [
	^ self
]
