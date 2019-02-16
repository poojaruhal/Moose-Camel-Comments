Class {
	#name : #MccClassStatistics,
	#superclass : #MccStatistics,
	#classInstVars : [
		'stat'
	],
	#category : #'Moose-Camel-Comments-Model - Statistics'
}

{ #category : #accessing }
MccClassStatistics >> createAllEntities [
	<return:#Array of: #Class>

	^ self environment allClasses
]
