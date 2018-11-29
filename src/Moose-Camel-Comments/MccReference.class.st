Class {
	#name : #MccReference,
	#superclass : #Object,
	#instVars : [
		'comment',
		'artefact',
		'interval'
	],
	#category : #'Moose-Camel-Comments-Model - Reference'
}

{ #category : #accessing }
MccReference >> artefact [
	^ artefact
]

{ #category : #accessing }
MccReference >> artefact: anObject [
	artefact := anObject
]

{ #category : #browsing }
MccReference >> browseDueTo: anEvent [
	"Browse reference artefact"

	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: self artefact).

	self class environment
		at: #GtPhlowObjectToSpawn
		ifPresent: [ :aClass |
			anEvent target fireEvent: (aClass new 
				object: self artefact;
				sourceElement: anEvent target) ]
]

{ #category : #accessing }
MccReference >> comment [
	"Return a comment from which I am referenced"
	<return: #MccComment>

	^ comment
]

{ #category : #accessing }
MccReference >> comment: anMccComment [
	comment := anMccComment
]

{ #category : #accessing }
MccReference >> from [
	^ self interval first
]

{ #category : #accessing }
MccReference >> interval [
	^ interval
]

{ #category : #accessing }
MccReference >> interval: anObject [
	interval := anObject
]

{ #category : #printing }
MccReference >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Reference to ';
		print: artefact
]

{ #category : #accessing }
MccReference >> style: aText [
	aText foreground: Color blue
]

{ #category : #accessing }
MccReference >> to [
	^ self interval last
]
