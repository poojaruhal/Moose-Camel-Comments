"
I am searching for code artefact references in a sentence
"
Class {
	#name : #MccReferenceFinder,
	#superclass : #Object,
	#instVars : [
		'comment',
		'environment'
	],
	#category : 'Moose-Camel-Comments-Model - Reference'
}

{ #category : #accessing }
MccReferenceFinder >> comment [
	<return: #MccComment>

	^ comment
]

{ #category : #accessing }
MccReferenceFinder >> comment: aMccComment [
	comment := aMccComment
]

{ #category : #accessing }
MccReferenceFinder >> environment [
	<return: #MccEnvironment>

	^ environment
]

{ #category : #accessing }
MccReferenceFinder >> environment: anMccEnvironment [
	environment := anMccEnvironment
]

{ #category : #searching }
MccReferenceFinder >> references [
	"Find and return code artefact references from a comment within provided environment"
	<return: #Collection of: #MccReference>
	
	^ self comment sentences flatCollect: [ :aSentence |
		| theReferences |
		theReferences := self referencesIn: aSentence.
		theReferences do: [ :eachReference | eachReference comment: self comment ].
		theReferences ]
]

{ #category : #searching }
MccReferenceFinder >> referencesIn: aSentence [
	"Find and return code artefact references from a given sentence within provided environment"
	<return: #Collection of: #MccReference>
	
	^ self subclassResponsibility
]
