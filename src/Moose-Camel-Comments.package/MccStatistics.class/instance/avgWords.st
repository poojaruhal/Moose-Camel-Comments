metrics
avgWords
	"Return the average amount of words per entity with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity mccComment words size ]) / self filteredEntities size asFloat