private-accessing
lines
	<return:#Array of:#MccClasses>
	
	^ self filteredEntities flatCollect: [ :eachEntity | eachEntity mccComment sentences ]