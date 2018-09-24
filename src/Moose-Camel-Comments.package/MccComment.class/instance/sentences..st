accessing
sentences: aCollectionOfSentences

	aCollectionOfSentences do: [ :eachSentence | 
		sentences add: (MccSentence fromSentence: eachSentence)].
	