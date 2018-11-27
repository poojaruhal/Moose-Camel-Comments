"
I represent empty comment in case some code artefact does not have a comment.

Empty comments do not reference any code artefacts
"
Class {
	#name : #MccEmptyComment,
	#superclass : #MccComment,
	#category : 'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccEmptyComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	"Any object can have empty comment, therefore return true"
	^ true
]

{ #category : #converting }
MccEmptyComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ ''
]

{ #category : #testing }
MccEmptyComment >> isEmpty [
	<return: #Boolean>
	
	^ true
]

{ #category : #references }
MccEmptyComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ #()
]
