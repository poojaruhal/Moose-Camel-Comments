metrics
avgStopwords
	"Return the average amount of stopwords per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity mccComment stopwords size ]) / self filteredEntities size asFloat