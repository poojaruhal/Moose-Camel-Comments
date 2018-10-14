accessing
sentence
	<gtExample>
	<description: 'return a sentence'>
	
	| sentenceExample mccSentence |
	
	sentenceExample:= 'I am responsibile for calculating the distance between question one and question two'.
	mccSentence := MccCommentExamples new sentences first.
	self assert: (mccSentence sentence) equals: sentenceExample.
	
	^ mccSentence