accessing
allEntities
	^ allEntities ifNil: [ allEntities := self createAllEntities ]