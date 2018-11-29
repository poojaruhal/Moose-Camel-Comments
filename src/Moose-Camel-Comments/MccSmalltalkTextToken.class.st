Class {
	#name : #MccSmalltalkTextToken,
	#superclass : #MccSmalltalkToken,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #testing }
MccSmalltalkTextToken >> isEmpty [
	<return: #Boolean>
	
	^ self value isEmpty
]
