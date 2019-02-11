"
I analyze difference versions given in inputOne and inputTwo.
inputOne and InputTwo are 2 version to be analyzed.

I can find different classes, common classes in two versions.
"
Class {
	#name : #MccCommentStampAnalyzerExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> analyzeVersions [
	<gtExample>
		
	|anAnalyzer|
	
	anAnalyzer := MccCommentStampAnalyzer version: self pharo3FileReference  to: self pharo4FileReference.
	^ anAnalyzer analyze.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> classesHaveDifferentTimestamp [
	<gtExample>
	
	^ self classesHaveDifferentTimestamp.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> classesHaveSameTimestamp [
	<gtExample>
	
	^ self classesHaveSameTimestamp.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> collectTimeStampsOfTwoVersions [
	<gtExample>
	
	^ self collectTimeStampsOfTwoVersions.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> commonClasses [
	<gtExample>
	
	^ self commonClasses.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> differentClasses [
	<gtExample>
	
		^ self differentClasses.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> inputVersionOne [
	<gtExample>
	
	"self pharo3FileReference."	
	^ self pharo4FileReference.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> inputVersionTwo [
	<gtExample>
	
	"self pharo4FileReference."
	^ self pharo3FileReference.
	
	
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> parsedFilteredVersionOne [
	<gtExample>
	
	^ self parsedFilteredVersionOne.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> parsedFilteredVersionTwo [
	<gtExample>
	
	^ self parsedFilteredVersionTwo.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> pharo3FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo3-package-morph.csv'
		asFileReference
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> pharo4FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo4-package-morph.csv'
		asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> pharo5FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo5-package-morph.csv'
		asFileReference
]
