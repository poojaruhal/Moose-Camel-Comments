"
I am just a textual comment that does not belong to anything.

[[[
	MccTextComment of: 'Number holds the most general methods for dealing with numbers.'
]]]
"
Class {
	#name : #MccTextComment,
	#superclass : #MccComment,
	#category : 'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccTextComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ anObject isString
]

{ #category : #comparing }
MccTextComment >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self text = anObject text
]

{ #category : #converting }
MccTextComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self text asString
]

{ #category : #comparing }
MccTextComment >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self text hash
]

{ #category : #printing }
MccTextComment >> printOn: aStream [
	aStream
		nextPutAll: 'Comment: ';
		nextPut: $(;
		nextPutAll: self asString;
		nextPut: $)
]

{ #category : #references }
MccTextComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ (MccClassReferenceFinder new
		comment: self;
		environment: aMccEnvironment) references
]

{ #category : #converting }
MccTextComment >> text [
	<return: #String>
	
	^ self artefact
]
