initialization
createFilteredEntities
	<return:#Array of: #Object>

	^ self createAllEntities reject: [ :eachEntity | eachEntity mccComment isEmpty ]