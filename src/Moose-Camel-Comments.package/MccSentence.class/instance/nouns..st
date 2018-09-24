accessing
nouns: aCollectionOfNouns

	aCollectionOfNouns do: [ :eachNoun | 
		nouns add: (MccNoun fromWord: eachNoun) asSymbol].