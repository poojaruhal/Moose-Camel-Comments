metrics
lexicalDensity
	"Return the average amount of unique words per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | (eachEntity mccComment words as: Set) size ]) / self filteredEntities size asFloat