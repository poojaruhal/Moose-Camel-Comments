"
I represent all the classes considered for the experiment.
I know classes with comments and without comments.
I also have responsibility of creating mccComment Object using API mccCommentClasses.

    Instance Variables
	allClasses:		<Object>
	mccCommentClasses:		<Object>

"
Class {
	#name : #MccClasses,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'mccCommentClasses'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccClasses class >> fromClasses: aListOfClasses [
	^ aListOfClasses as: self
]

{ #category : #converting }
MccClasses >> asSymbols [

	^ self collect: [ :eachClass | eachClass name asLowercase asSymbol ]
]

{ #category : #'gt-examples' }
MccClasses >> classesWithComments [
	<return: #Array of: #Classe>
	
	^ self select: #hasComment
]

{ #category : #accessing }
MccClasses >> comments [
	^ self collect: #mccComment as: Array
]

{ #category : #'as yet unclassified' }
MccClasses >> gtInspectorallClassesIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite fastList
		title: 'Classes';
		display: [ self ];
		format: [ :eachClass | eachClass printString ]
]

{ #category : #initialization }
MccClasses >> initialize [
	super initialize.
	
	mccCommentClasses := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MccClasses >> mccCommentAllClasses [

	^ self mccCommentClasses collect:[:eachCommentClass | eachCommentClass commentClass]
]

{ #category : #accessing }
MccClasses >> mccCommentClasses [
	
	<return: #Array of: #MccComment>
	
	 ^ mccCommentClasses:=  self classesWithComments collect: #mccComment.
	

]

{ #category : #accessing }
MccClasses >> withComments [
	
	<return: #Array of: #MccComment>
	
	 ^ mccCommentClasses:=  (self select: #hasComment) collect: #mccComment.
	

]

{ #category : #'as yet unclassified' }
MccClasses >> withoutComments [
	<return: #Array of: #Classes>

	^ self reject: #hasComment
]
