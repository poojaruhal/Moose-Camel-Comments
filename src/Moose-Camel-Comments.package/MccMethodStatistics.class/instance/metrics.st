metrics
metrics
	
	super metrics.
	
	self allStatistics addAll:
	{
		'average lines of methods' -> self avgLinesOfSourceCode.	
	} asDictionary.
		
	^ self allStatistics.