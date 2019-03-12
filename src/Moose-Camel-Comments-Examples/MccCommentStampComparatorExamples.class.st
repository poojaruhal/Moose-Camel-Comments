"
I analyze difference versions given in inputOne and inputTwo.
inputOne and InputTwo are 2 version to be analyzed.

I can find different classes, common classes in two versions.
"
Class {
	#name : #MccCommentStampComparatorExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> classesHaveDifferentTimestamp [
	<gtExample>
	
	^ self classesHaveDifferentTimestamp.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> classesHaveSameTimestamp [
	<gtExample>
	
	^ self classesHaveSameTimestamp.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> collectTimeStampsOfTwoVersions [
	<gtExample>
	
	^ self collectTimeStampsOfTwoVersions.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> commonClasses [
	<gtExample>
	
	^ self commonClasses.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> compareVersions [
	<gtExample>
		
	|anAnalyzer|
	
	anAnalyzer := MccCommentStampVersionComparator version: self pharo3FileReference  to: self pharo4FileReference.
	^ anAnalyzer compare.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> differentClasses [
	<gtExample>
	
		^ self differentClasses.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> inputVersionOne [
	<gtExample>
	
	"self pharo3FileReference."	
	^ self pharo4FileReference.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> inputVersionTwo [
	<gtExample>
	
	"self pharo4FileReference."
	^ self pharo3FileReference.
	
	
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> parsedFilteredVersionOne [
	<gtExample>
	
	^ self parsedFilteredVersionOne.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> parsedFilteredVersionTwo [
	<gtExample>
	
	^ self parsedFilteredVersionTwo.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> pharo3FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo3-package-morph.csv'
		asFileReference
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> pharo4FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo4-package-morph.csv'
		asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentStampComparatorExamples >> pharo5FileReference [
	<gtExample>
	
	^ '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo5-package-morph.csv'
		asFileReference
]
