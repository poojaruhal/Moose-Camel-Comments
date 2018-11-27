Class {
	#name : #MccClassStatistics,
	#superclass : #MccStatistics,
	#category : 'Moose-Camel-Comments-Model'
}

{ #category : #accessing }
MccClassStatistics >> createAllEntities [
	<return:#Array of: #Class>

	^ self environment allClasses
]
