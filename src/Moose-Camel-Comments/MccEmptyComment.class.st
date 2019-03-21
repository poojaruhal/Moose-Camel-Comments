"
An object can have emtpty comment
"
Class {
	#name : #MccEmptyComment,
	#superclass : #MccComment,
	#category : #'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccEmptyComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ true
]

{ #category : #converting }
MccEmptyComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ ''
]

{ #category : #references }
MccEmptyComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ #()
]
