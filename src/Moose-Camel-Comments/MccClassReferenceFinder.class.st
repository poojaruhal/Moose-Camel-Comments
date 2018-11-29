"
I am looking for class references
"
Class {
	#name : #MccClassReferenceFinder,
	#superclass : #MccReferenceFinder,
	#category : #'Moose-Camel-Comments-Model - Reference'
}

{ #category : #searching }
MccClassReferenceFinder >> findExactReferencesIn: aSentence [
	"Find and return exact class references"
	<return: #Collection of: #MccReference>

	^ Array streamContents: [ :aStream | 
		aSentence words do: [ :eachWord |
			self environment
				classNamed: eachWord asSymbol
				ifFound: [ :aClass | aStream nextPut: (MccClassReference new
					interval: eachWord interval;
					artefact: aClass) ]
				ifNone: [  ] ] ]
]

{ #category : #searching }
MccClassReferenceFinder >> referencesIn: aSentence [
	"Find and return code artefact references from a given sentence within provided environment"
	<return: #Collection of: #MccReference>

	^ self findExactReferencesIn: aSentence
]
