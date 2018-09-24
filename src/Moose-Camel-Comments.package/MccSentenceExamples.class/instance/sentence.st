accessing
sentence
	<gtExample>
	<description: 'return a sentence'>
	
	| sentenceExample mccSentence |
	
	sentenceExample:= 'Answer the set of temporary variables that are read before they are written in the visited parse tree'.
	mccSentence := MccCommentExamples new sentences first.
	self assert: (mccSentence sentence) equals: sentenceExample.
	
	^ mccSentence