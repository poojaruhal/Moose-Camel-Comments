metrics
avgLines
	"Return the average amount of lines in a comment among entities with a comment"
	<return: #Number>

	^ (self lines size / self filteredEntities size) asFloat