"
Exmaples to test MccSentence
"
Class {
	#name : #MccSentenceProcessorExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples'
}

{ #category : #accessing }
MccSentenceProcessorExamples >> sentence [
<gtExample>

	^ MccSentenceExamples new sentence.
]

{ #category : #accessing }
MccSentenceProcessorExamples >> sentenceProcessor [
<gtExample>

	 ^ (MccSentenceProcessor fromSentence: (self sentence))
]

{ #category : #'gt-examples' }
MccSentenceProcessorExamples >> splitIntoNouns [
<gtExample>

	 ^ self sentenceProcessor splitIntoNouns.
		
	
]

{ #category : #'gt-examples' }
MccSentenceProcessorExamples >> tokens [
<gtExample>

	 ^ self sentenceProcessor tokens.
		
	
]

{ #category : #'gt-examples' }
MccSentenceProcessorExamples >> tokensWithoutStopwords [
<gtExample>

	 ^ self sentenceProcessor tokensWithoutStopwordsFrom.
	
]

{ #category : #converting }
MccSentenceProcessorExamples >> uniqueTokens [
<gtExample>

	^ self sentenceProcessor uniqueTokens
		
	
]
