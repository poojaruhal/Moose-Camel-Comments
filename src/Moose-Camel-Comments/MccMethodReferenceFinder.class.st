Class {
	#name : #MccMethodReferenceFinder,
	#superclass : #MccReferenceFinder,
	#instVars : [
		'classOrMetaclass'
	],
	#category : #'Moose-Camel-Comments-Model - Reference'
}

{ #category : #accessing }
MccMethodReferenceFinder >> classOrMetaclass [
	^ classOrMetaclass
]

{ #category : #accessing }
MccMethodReferenceFinder >> classOrMetaclass: anObject [
	classOrMetaclass := anObject
]

{ #category : #searching }
MccMethodReferenceFinder >> findExactReferencesIn: aSentence [
	"Find and return exact class references"
	<return: #Collection of: #MccReference>

	^ Array streamContents: [ :aStream | 
		aSentence words do: [ :eachWord |
			classOrMetaclass
				classAndMethodFor: eachWord asSymbol
				do: [ :c :aMethod | aStream nextPut: (MccMethodReference new
					interval: eachWord interval;
					artefact: aMethod) ]
				ifAbsent: [] ] ]
]

{ #category : #searching }
MccMethodReferenceFinder >> referencesIn: aSentence [
	"Find and return code artefact references from a given sentence within provided environment"
	<return: #Collection of: #MccReference>

	^ self findExactReferencesIn: aSentence
]
