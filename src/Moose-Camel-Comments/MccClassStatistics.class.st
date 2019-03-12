"
This gathers all the statistics  about the class comments. Some metrics like avg line of code are not applicable on class comments but on the method comments. 
"
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
