"
I am responsibile to show examples of Nouns.
"
Class {
	#name : #MccNounExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples'
}

{ #category : #converting }
MccNounExamples >> asSymbol [
	<gtExample>
	<description: 'Represent a noun as a symbol'>
	
	^ self noun asSymbol.
	
	
	
]

{ #category : #'gt-examples' }
MccNounExamples >> noun [
	<gtExample>
	<description: 'Represent a noun'>
	
	| aWord |
	
	aWord := 'Parser'.
	
	^ (MccNoun fromWord:aWord)
	
	
	
]
