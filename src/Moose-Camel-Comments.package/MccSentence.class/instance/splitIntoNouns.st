as yet unclassified
splitIntoNouns
	<return: #Array of: #MccNoun>
	
	"UnComment this out once you load the project"
	
 	 "self nouns:(((McInputProcessor new) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol])."
		
		
		"Comment this out once you load the project"
		 self nouns: ({'brick'.'block'.'blelement' }).
								
		^ self nouns.