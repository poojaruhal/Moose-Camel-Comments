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
	
	"get the collection of the class with its comment"
	
	^ MccExternalEnvironment fromCSV:(MccCommentComparatorExamples new pharo7FileReference).
	
]

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> pharo1FileReference [
	"path of the csv file that we want to analyze"
	
	^'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/1-Classes-comments-pharo.csv' asFileReference
]

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> pharo7FileReference [
	"path of the csv file that we want to analyze"
	
	^'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/7-Classes-comments-pharo.csv' asFileReference
]
