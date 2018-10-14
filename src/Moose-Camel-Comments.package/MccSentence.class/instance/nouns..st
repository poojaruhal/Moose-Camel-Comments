accessing
nouns: aCollectionOfNounWords

	aCollectionOfNounWords do: [ :eachNounWord | 
		nouns add: (MccNoun fromWord: eachNounWord)].
