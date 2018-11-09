accessing
filteredEntities
	^ filteredEntities ifNil: [ filteredEntities := self createFilteredEntities ]