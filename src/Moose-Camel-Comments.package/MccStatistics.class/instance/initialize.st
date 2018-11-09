initialization
initialize
	super initialize.

	allStatistics := Dictionary new.

	allEntities := nil. "lazy"
	filteredEntities := nil. "lazy"