"
I represent a verb from English langauge.

I also have  an external represention.

    Instance Variables
	verb:		<Object>
"
Class {
	#name : #MccVerb,
	#superclass : #MccWord,
	#instVars : [
		'verb'
	],
	#category : #'Moose-Camel-Comments-Model - Text'
}

{ #category : #'instance creation' }
MccVerb class >> fromWord: aWord [
	^ self new verb: aWord
]

{ #category : #accessing }
MccVerb >> asSymbol [
	<return: #Verb as: #Symbol>
	^ self verb asSymbol
]

{ #category : #accessing }
MccVerb >> verb [
	^ verb
]

{ #category : #accessing }
MccVerb >> verb: anObject [
	verb := anObject
]
