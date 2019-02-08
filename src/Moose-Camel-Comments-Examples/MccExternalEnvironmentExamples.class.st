"
A External environment is created from the CSv file.
A CSV file contains each class with its comment in a row.

"
Class {
	#name : #MccExternalEnvironmentExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Examples'
}

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> externalEnvironmentModel [
	<gtExample>
	
	|anExternalEnviornment|
	
	"get the collection of the class with its comment"
	
	^ MccExternalEnvironment fromCSV:(self inputFileReference).
	
]

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> inputFileReference [
	"path of the csv file that we want to analyze"
	
	^'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/Pharo class somments/1-Classes-comments-pharo.csv' asFileReference
]
