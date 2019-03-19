"
I compare all the versions with each other.

File references without empty comment: 
Pharo 1: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/1-Classes-comments-pharo.csv'
Pharo 2: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/2-Classes-comments-pharo.csv'
Pharo 3: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/3-Classes-comments-pharo.csv'
Pharo 4: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/4-Classes-comments-pharo.csv' 
Pharo 5: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/5-Classes-comments-pharo.csv'
Pharo 6: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/6-Classes-comments-pharo.csv'
Pharo 7: '/Users/poojarani/Downloads/Pharo-Projects/Pharo-class-comments/7-Classes-comments-pharo.csv'

"
Class {
	#name : #MccCommentComparatorExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> compareAllVersions [
	<gtExample>
	| rowVersions columnVersion aCommentComparator |
	
	rowVersions := OrderedCollection new.
	
	1 to: 7 do: [ :row | 
		
		| versionOneReference |
		versionOneReference := (self composeFileReferenceBlock value: row) asSymbol.
		columnVersion := OrderedCollection new.
		
		1 to: 7 do: [ :column | 
			| versionTwoReference |
			versionTwoReference := (self composeFileReferenceBlock value: column) asSymbol.
			
			aCommentComparator := MccCommentsVersionComparator
				version: (self perform: versionOneReference)
				to: (self perform: versionTwoReference).
			columnVersion add: {(aCommentComparator compare dictionary collect: [ :e | e value size ])}].
		rowVersions add: {((self pharoVersionBlock value: row) -> columnVersion)} ].
	^ rowVersions.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> compareVersions [
	<gtExample>
		
	|aComparator|
	
	aComparator := MccCommentsVersionComparator version: self pharo1FileReference  to: self pharo2FileReference.
	^ aComparator compare.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> composeFileReferenceBlock [
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
MccCommentComparatorExamples >> pharo1FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo1.csv' asFileReference.
		
	
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo2FileReference [
	<gtExample>
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo2.csv' asFileReference.
		
	
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo3FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-comments-pharo3-package-morph.csv' asFileReference."
		
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo3.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo4FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo4.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo5FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
		
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo5.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo6FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo6.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharo7FileReference [
	<gtExample>
	
	"^ 	'/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classes-Comments-pharo4-package-morph.csv' asFileReference."
	
	^	'/Users/poojarani/Downloads/Pharo-Projects/Pharo-all-classes/all-class-comments-pharo7.csv' asFileReference.
]

{ #category : #'as yet unclassified' }
MccCommentComparatorExamples >> pharoVersionBlock [
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
