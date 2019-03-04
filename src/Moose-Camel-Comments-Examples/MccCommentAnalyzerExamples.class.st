Class {
	#name : #MccCommentAnalyzerExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> analyzeAllVersions [
	<gtExample>
	| rowVersions columnVersion aCommentAnalyzer |
	
	rowVersions := OrderedCollection new.
	
	1 to: 7 do: [ :row | 
		
		| versionOneReference |
		versionOneReference := (self composeFileReferenceBlock value: row) asSymbol.
		columnVersion := OrderedCollection new.
		
		1 to: 7 do: [ :column | 
			| versionTwoReference |
			versionTwoReference := (self composeFileReferenceBlock value: column) asSymbol.
			
			aCommentAnalyzer := MccCommentAnalyzer
				version: (self perform: versionOneReference)
				to: (self perform: versionTwoReference).
			columnVersion add: {(aCommentAnalyzer analyze dictionary collect: [ :e | e value size ])} ].
		rowVersions add: {((self pharoVersionBlock value: row) -> columnVersion)} ].
	
	^ rowVersions.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> analyzeVersions [
	<gtExample>
		
	|anAnalyzer|
	
	anAnalyzer := MccCommentAnalyzer version: self pharo1FileReference  to: self pharo7FileReference.
	^ anAnalyzer analyze.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> composeFileReferenceBlock [
	<gtExample>
	
	|aBlock|
	
	aBlock := [:versionNumber | 
	|aString|
	aString := String streamContents: 
        [:stream | 
            stream 
			nextPutAll: 'pharo';
			print: versionNumber ;
			nextPutAll:'FileReference'.].
		aString.]. 
	
	^ aBlock.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo1FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/1-Classes-comments-pharo.csv' asFileReference.
		
	
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo2FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/2-Classes-comments-pharo.csv' asFileReference.
		
	
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo3FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-comments-pharo3-package-morph.csv' asFileReference."
		
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/3-Classes-comments-pharo.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo4FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/4-Classes-comments-pharo.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo5FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
		
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/5-Classes-comments-pharo.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo6FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/6-Classes-comments-pharo.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharo7FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/7-Classes-comments-pharo.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentAnalyzerExamples >> pharoVersionBlock [
	<gtExample>
	
	|aBlock|
	
	aBlock := [:versionNumber | 
	|aString|
	aString := String streamContents: 
        [:stream | 
            stream 
			nextPutAll: 'Pharo';
			print: versionNumber.].
		aString.]. 
	
	^ aBlock.
]
