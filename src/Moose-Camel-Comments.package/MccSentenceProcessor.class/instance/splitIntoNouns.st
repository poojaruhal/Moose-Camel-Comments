gt-examples
splitIntoNouns
	<return: #Array of: #MccNoun>
	|nouns|
	 
	"UnComment this out once you load the project"
	
	  nouns:=(((self  mcInputProcessor) process: self sentence)
						 nouns collect: [ :eachNoun |
									eachNoun word asLowercase asSymbol]).
		
		
		"Comment this out once you load the project"
		" self nouns: ({'brick'.'block'.'blelement' })."
								
		^ nouns.