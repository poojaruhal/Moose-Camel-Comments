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
MccCommentAnalyzerExamples >> pharo1FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/1-Classes-comments-pharo.csv'
		
	
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo2FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/2-Classes-comments-pharo.csv'
		
	
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo3FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-comments-pharo3-package-morph.csv' asFileReference."
		
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/3-Classes-comments-pharo.csv'
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo4FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/1-Classes-comments-pharo.csv'
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo5FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/5-Classes-comments-pharo.csv'
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo6FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/6-Classes-comments-pharo.csv'
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo7FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo class somments/7-Classes-comments-pharo.csv'
]
