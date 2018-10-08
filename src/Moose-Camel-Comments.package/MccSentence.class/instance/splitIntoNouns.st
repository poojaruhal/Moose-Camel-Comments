as yet unclassified
splitIntoNouns
	<return: #Array of: #MccNoun>
	
	 self nouns:(((McInputProcessor new) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol]).
								
		^ self nouns.