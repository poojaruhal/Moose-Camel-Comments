Class {
	#name : #MccSentenceExamples,
	#superclass : #Object,
	#category : 'Moose-Camel-Comments-Examples-Examples'
}

{ #category : #'sentence - examples' }
MccSentenceExamples >> sentenseWithDirectPreciseReferenceOfPoint [
	<gtExample>
	| aSentence |

	aSentence := MccSentence string: 'Point represents a coordinate in space'.
	self assert: aSentence asString equals: 'Point represents a coordinate in space'.
	self assert: aSentence words equals: {
		MccWord string: 'Point'.
		MccWord string: 'represents'.
		MccWord string: 'a'.
		MccWord string: 'coordinate'.
		MccWord string: 'in'.
		MccWord string: 'space'
	}.
	
	^ aSentence
]
