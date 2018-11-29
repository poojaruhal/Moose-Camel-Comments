Class {
	#name : #MccSmalltalkToken,
	#superclass : #PP2Token,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #enumerating }
MccSmalltalkToken >> codeDo: aBlock [
	"Evaluate a given block if I am a code token"
]

{ #category : #testing }
MccSmalltalkToken >> isEmpty [
	<return: #Boolean>
	
	^ self subclassResponsibility
]
