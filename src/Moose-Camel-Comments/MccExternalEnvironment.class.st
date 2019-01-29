"
I represent an external environment. I am created from a csv file of classes with its comment.
I collobrate with MccTextModel to create text model of the comment. 

"
Class {
	#name : #MccExternalEnvironment,
	#superclass : #MccEnvironment,
	#instVars : [
		'classes',
		'classesWithComment',
		'classCommentModel'
	],
	#category : #'Moose-Camel-Comments-Model - Environment'
}

{ #category : #'instance creation' }
MccExternalEnvironment class >> fromCSV: aFileReference [

	|aCollectionOfclassComment|
	
	aCollectionOfclassComment:=
		(NeoCSVReader on: aFileReference readStream)
			addField;
			addField;
			upToEnd.
			
	^ self new classesWithComment: aCollectionOfclassComment
	
	
	 
]

{ #category : #navigation }
MccExternalEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ self classes
]

{ #category : #'as yet unclassified' }
MccExternalEnvironment >> classCommentModel [

	^ self classCommentModel 
	
				

]

{ #category : #accessing }
MccExternalEnvironment >> classes [
	<return: #Collection of: #Class>

	^ classes
]

{ #category : #accessing }
MccExternalEnvironment >> classes: aCollectionOfClasses [
	classes := aCollectionOfClasses
]

{ #category : #accessing }
MccExternalEnvironment >> classesWithComment [
	^ classesWithComment
]

{ #category : #accessing }
MccExternalEnvironment >> classesWithComment: anObject [
	classesWithComment := anObject
]

{ #category : #'as yet unclassified' }
MccExternalEnvironment >> createClassCommentModel [

	classCommentModel := (self classesWithComment) collect:
		[:eachClassCommentArray |
			(eachClassCommentArray at:1) -> 
				(MccTextComment of:(eachClassCommentArray at:2))].
			
	self classes: (classCommentModel collect:[:eachItem | eachItem key]).

	
				

]

{ #category : #initialization }
MccExternalEnvironment >> initialize [
	super initialize.
	
	classes := OrderedCollection new
]
