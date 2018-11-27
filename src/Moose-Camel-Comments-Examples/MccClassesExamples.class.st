Class {
	#name : #MccClassesExamples,
	#superclass : #Object,
	#category : 'Moose-Camel-Comments-Examples'
}

{ #category : #navigation }
MccClassesExamples >> allMccCommentClasses [
	<gtExample>
	
	^ (self allMccClasses) mccCommentClasses.
]

{ #category : #converting }
MccClassesExamples >> asSymbols [
	<gtExample>
	<description: 'all classes as symbols'>
	
	^ (self allMccClasses) asSymbols.
]

{ #category : #'gt-examples' }
MccClassesExamples >> classesWithComments [
	<gtExample>
	<description: 'all classes with comments'>
	
	^ (self allMccClasses) classesWithComments
]
