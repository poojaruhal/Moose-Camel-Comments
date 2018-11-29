Class {
	#name : #MccSentenceProcessor,
	#superclass : #Object,
	#instVars : [
		'sentence',
		'mcInputProcessor'
	],
	#category : #'Moose-Camel-Comments'
}

{ #category : #'instance creation' }
MccSentenceProcessor class >> fromSentence: aSentence [
	^ (self new) sentence:aSentence.
]

{ #category : #'as yet unclassified' }
MccSentenceProcessor >> coreNlpResponse: aSentence [
	
	^ self mcInputProcessor serviceResponse: aSentence
]

{ #category : #initialization }
MccSentenceProcessor >> initialize [
	super initialize.
	mcInputProcessor := McInputProcessor new.
]

{ #category : #accessing }
MccSentenceProcessor >> mcInputProcessor [
	^ mcInputProcessor
]

{ #category : #accessing }
MccSentenceProcessor >> mcInputProcessor: anObject [
	mcInputProcessor := anObject
]

{ #category : #accessing }
MccSentenceProcessor >> sentence [
	^ sentence
]

{ #category : #accessing }
MccSentenceProcessor >> sentence: anObject [
	sentence := anObject
]

{ #category : #'gt-examples' }
MccSentenceProcessor >> splitIntoNouns [
	<return: #Array of: #MccNoun>
	|nouns|
	 
	"UnComment this out once you load the project"
	
	  nouns:=(((self  mcInputProcessor) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol]).
		
		
		"Comment this out once you load the project"
		" self nouns: ({'brick'.'block'.'blelement' })."
								
		^ nouns.
]

{ #category : #accessing }
MccSentenceProcessor >> tokens [
	|aCoreResponse|
	
	aCoreResponse := self coreNlpResponse: self sentence.
	^ aCoreResponse tokens.
	
	
]

{ #category : #'as yet unclassified' }
MccSentenceProcessor >> tokensWithoutStopwordsFrom [

	^ self mcInputProcessor removeStopwordsFrom: self sentence.
]

{ #category : #converting }
MccSentenceProcessor >> uniqueTokens [
	|aCoreResponse|
	
	aCoreResponse := self coreNlpResponse: self sentence.
	^ aCoreResponse tokens uniqueTokens.
	
	
]
