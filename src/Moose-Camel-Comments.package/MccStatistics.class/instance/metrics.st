metrics
metrics

	self allStatistics addAll:
	{ 
		'average number of EntityComment' -> self avgEntitiesWithComment. 
		'average number of lines in comments' -> self avgLines.
		'average number of words' -> self avgWords.
		'average number of stopwords' -> self avgStopwords.
		'lexical Density' -> self lexicalDensity
	} asDictionary.
		
	^ self allStatistics.