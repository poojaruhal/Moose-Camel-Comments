"
I am responsible for adding special metrics to Statistics like avg line of code that is not applicable on class comments but on the method comments. I am specific to method comments.
"
Class {
	#name : #MccMethodStatistics,
	#superclass : #MccStatistics,
	#category : #'Moose-Camel-Comments-Model - Statistics'
}

{ #category : #'as yet unclassified' }
MccMethodStatistics >> avgLinesOfSourceCode [
	
	^ (self totalNumberOfLines / self allEntities size) asFloat
]

{ #category : #metrics }
MccMethodStatistics >> createAllEntities [
	<return:#Array of: #Class>

	^ self environment allMethods
]

{ #category : #metrics }
MccMethodStatistics >> metrics [
	
	super metrics.
	
	self allStatistics addAll:
	{
		'average lines of methods' -> self avgLinesOfSourceCode.	
	} asDictionary.
		
	^ self allStatistics.
]

{ #category : #accessing }
MccMethodStatistics >> totalNumberOfLines [
	"return lines of code including comments except empty lines".
	
	^ self allEntities sum: [ :eachMethod | eachMethod linesOfCode - 1 ]
]
