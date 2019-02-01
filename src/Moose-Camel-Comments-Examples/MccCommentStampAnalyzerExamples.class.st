Class {
	#name : #MccCommentStampAnalyzerExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> analyzePharo4CommentStamps [
	<gtExample>
	
	| aFileReference aMccCommentAnalyzer |
	
	aFileReference := 		'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classCommentStamps-pharo4-package-morph.csv' asFileReference.
			
	aMccCommentAnalyzer := MccCommentStampAnalyzer fromCSV: aFileReference.
	^ aMccCommentAnalyzer analyzeCommentStamp.
	
	
]
