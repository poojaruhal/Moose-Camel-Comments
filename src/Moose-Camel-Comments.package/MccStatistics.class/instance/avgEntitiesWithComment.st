metrics
avgEntitiesWithComment
	"Return the percentage of entities with comments out of all entities"
	<return: #Number>

	^ (self filteredEntities size / self allEntities size) asFloat