"
I represent a noun from English langauge.

I also have  an external represention.

    Instance Variables
	noun:		<Object>

"
Class {
	#name : #MccNoun,
	#superclass : #MccWord,
	#instVars : [
		'noun'
	],
	#category : 'Moose-Camel-Comments-Model - Text'
}

{ #category : #'instance creation' }
MccNoun class >> fromWord: aWord [
	^ self new noun: aWord.
]

{ #category : #converting }
MccNoun >> asSymbol [
	<return: #Noun as:#Symbol>

	^ self noun asSymbol.
]

{ #category : #'as yet unclassified' }
MccNoun >> gtInspectorNounIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
			title: 'Noun';
			display: [self noun].
]

{ #category : #accessing }
MccNoun >> noun [
	^ noun
]

{ #category : #accessing }
MccNoun >> noun: aNoun [
	noun := aNoun
]
