as yet unclassified
splitIntoNouns
	<return: #Array of: #MccNoun>
	
	 self nouns:(((NlpInputProcessor new) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol]).
								
		^ self nouns.