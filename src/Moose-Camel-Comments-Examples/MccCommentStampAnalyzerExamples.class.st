Class {
	#name : #MccCommentStampAnalyzerExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> collectTimeStampsOfTwoVersions [
	<gtExample>
	
	| output pharo3List pharo4List |
	
	pharo3List := self pharo3CommentStamps.
	pharo4List := self pharo4CommentStamps.
	output := OrderedCollection new.
	
	pharo3List
		do: [ :anAssociation | 
			(pharo4List includes: anAssociation)
				ifTrue: [ | index |
					index := pharo4List indexOf: anAssociation.
					output
						add:
							{anAssociation key.
							anAssociation value second.
							(pharo4List at: index) value second} ] ].
					
	^ output
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> commonClassesInVersions [
	<gtExample>
	
	^ self pharo3CommentStamps intersection: self pharo4CommentStamps.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> differenceInVersions [
	<gtExample>
	
	^ self pharo3CommentStamps difference: self pharo4CommentStamps.
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> pharo3CommentStamps [
	<gtExample>
	
	| input aMccCommentAnalyzer |
	
	input := '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo3-package-morph.csv' asFileReference.

	aMccCommentAnalyzer := MccCommentStampAnalyzer fromCSV: input.
	aMccCommentAnalyzer parseCommentStamps .
	^ aMccCommentAnalyzer filterHistorical.
	
	
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzerExamples >> pharo4CommentStamps [
	<gtExample>
	
	| pharo4FileReference aMccCommentAnalyzer |
	
	pharo4FileReference:= '/Users/poojarani/Downloads/Pharo-Projects/pharo-versions-comment-analysis-data/classesCommentsStamp-pharo4-package-morph.csv' asFileReference.

	aMccCommentAnalyzer := MccCommentStampAnalyzer fromCSV: pharo4FileReference.
	aMccCommentAnalyzer parseCommentStamps .
	^ aMccCommentAnalyzer filterHistorical.
	
	
]
