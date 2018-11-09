metrics
metrics

	allStatistics addAll:
	{ 
		'average number of EntityComment' -> self avgEntitiesWithComment. 
		'average number of lines' -> self avgLines.
		'average number of words' -> self avgWords.
	} asDictionary.
		
	^ allStatistics.