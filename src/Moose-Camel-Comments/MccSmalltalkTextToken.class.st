Class {
	#name : #MccSmalltalkTextToken,
	#superclass : #MccSmalltalkToken,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #enumerating }
MccSmalltalkTextToken >> codeOrTextDo: aBlock [
	aBlock value: self
]

{ #category : #testing }
MccSmalltalkTextToken >> isEmpty [
	<return: #Boolean>
	
	^ self value isEmpty
]

{ #category : #testing }
MccSmalltalkTextToken >> isText [
	^ true
]

{ #category : #parsing }
MccSmalltalkTextToken >> parse [
	<return: #MccSmalltalkToken>

	^ self
]
