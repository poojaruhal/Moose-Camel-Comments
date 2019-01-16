Class {
	#name : #MccClassStatistics,
	#superclass : #MccStatistics,
	#instVars : [
		'inst'
	],
	#classVars : [
		'cls'
	],
	#classInstVars : [
		'stat'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #accessing }
MccClassStatistics >> createAllEntities [
	<return:#Array of: #Class>

	^ self environment allClasses
]
