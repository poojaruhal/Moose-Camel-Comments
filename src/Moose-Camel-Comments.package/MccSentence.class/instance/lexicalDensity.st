as yet unclassified
lexicalDensity
	|aSentenceProcessor tokens tokensType|
	
	aSentenceProcessor := MccSentenceProcessor fromSentence: self sentence.
	tokens := aSentenceProcessor tokens.
	tokensType := aSentenceProcessor uniqueTokens.
	
	^  ((tokensType size)/(tokens size)).
