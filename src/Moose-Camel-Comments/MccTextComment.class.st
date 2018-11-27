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

{ #category : #converting }
MccTextComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self text asString
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
