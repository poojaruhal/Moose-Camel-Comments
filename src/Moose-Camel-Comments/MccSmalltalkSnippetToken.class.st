Class {
	#name : #MccSmalltalkSnippetToken,
	#superclass : #MccSmalltalkToken,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #testing }
MccSmalltalkSnippetToken >> isEmpty [
	<return: #Boolean>
	
	^ self value isEmpty
]
