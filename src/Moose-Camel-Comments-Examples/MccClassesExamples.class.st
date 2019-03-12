"
I have all the exmaples to test MccClasses class.
"
Class {
	#name : #MccClassesExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples'
}

{ #category : #navigation }
MccClassesExamples >> allMccCommentClasses [
	<gtExample>
	
	^ MccClasses from: (MccSystemEnvironment new allClasses)
]

{ #category : #converting }
MccClassesExamples >> asSymbols [
	<gtExample>
	<description: 'all classes as symbols'>
	
	^ self allMccCommentClasses asSymbols.
]

{ #category : #'gt-examples' }
MccClassesExamples >> classesWithComments [
	<gtExample>
	<description: 'all classes with comments'>
	
	^ self allMccCommentClasses withComments.
]
