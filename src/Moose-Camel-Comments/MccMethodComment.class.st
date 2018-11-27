"
I represent a method comment
"
Class {
	#name : #MccMethodComment,
	#superclass : #MccComment,
	#category : 'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccMethodComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ anObject comment isNotNil
]

{ #category : #converting }
MccMethodComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self method comment
]

{ #category : #accessing }
MccMethodComment >> method [
	<return: #CompiledMethod>

	^ self artefact
]

{ #category : #references }
MccMethodComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ {
		MccClassReferenceFinder new
			comment: self;
			environment: aMccEnvironment.
		MccMethodReferenceFinder new
			comment: self;
			environment: aMccEnvironment;
			classOrMetaclass: self method methodClass
	} flatCollect: #references
]
