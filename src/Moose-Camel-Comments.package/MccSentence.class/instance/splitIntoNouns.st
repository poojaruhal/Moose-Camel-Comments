as yet unclassified
splitIntoNouns
	 self nouns:(((NlpInputProcessor new) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol]).
								
		^ self nouns.