"
A External environment is created from the CSv file.
A CSV file contains each class with its comment in a row.

"
Class {
	#name : #MccExternalEnvironmentExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Environment- Examples'
}

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> externalEnvironmentModel [
	<gtExample>
	
	"get the collection of the class with its comment"
	
	^ MccExternalEnvironment fromCSV:(MccCommentComparatorExamples new pharo1FileReference).
	
]

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> pharo1FileReference [
	"path of the csv file that we want to analyze"
	<gtExample>
	^'/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/Pharo-only-class-with-comments CSV/1-Classes-comments-pharo.csv' asFileReference
]

{ #category : #'as yet unclassified' }
MccExternalEnvironmentExamples >> pharo7FileReference [
	"path of the csv file that we want to analyze"
	<gtExample>
	^'/Users/poojarani/Downloads/Phd/Projects/Comment-Analysis/Pharo-only-class-with-comments CSV/7-Classes-comments-pharo.csv' asFileReference.
]
