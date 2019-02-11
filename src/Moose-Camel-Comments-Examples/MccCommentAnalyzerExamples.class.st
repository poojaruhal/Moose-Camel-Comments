Class {
	#name : #MccCommentAnalyzerExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> analyzeVersions [
	<gtExample>
		
	|anAnalyzer|
	
	anAnalyzer := MccCommentAnalyzer version: self pharo3FileReference  to: self pharo4FileReference.
	^ anAnalyzer analyze.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo3FileReference [
	<gtExample>
	
	^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-comments-pharo3-package-morph.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo4FileReference [
	<gtExample>
	
	^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference.
]
