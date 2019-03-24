"
I represent an external environment. I am created from a csv file of classes with its comment.
I collobrate with MccTextModel to create text model of the comment. 

"
Class {
	#name : #MccExternalEnvironment,
	#superclass : #MccEnvironment,
	#instVars : [
		'classes',
		'comments',
		'classesAndComments'
	],
	#category : #'Moose-Camel-Comments-Model - Environment'
}

{ #category : #'instance creation' }
MccExternalEnvironment class >> fromCSV: aFileReference [

	| aCollectionOfClassComment |
	"first column- className, secondColumn- class comment"
	
	aCollectionOfClassComment := (NeoCSVReader on: aFileReference readStream)
		addField;
		addField;
		upToEnd.
		
	^ self new classes: (aCollectionOfClassComment
		reject: [ :eachItem | eachItem first isEmptyOrNil and: [ eachItem second isEmptyOrNil ] ]
		thenCollect: [ :eachItem | 
					MccTextClass
						from: (eachItem at: 1) 
						comment: (MccTextComment of: (eachItem at: 2))])
	
]

{ #category : #'instance creation' }
MccExternalEnvironment class >> fromCSV: aFileReference of: aVersionNumber [
	| aCollectionOfClassComment |
	"first column- className, secondColumn- class comment"
	aCollectionOfClassComment := (NeoCSVReader on: aFileReference readStream)
		addField;
		addField;
		upToEnd.
		
	^ self new classes: 
		(aCollectionOfClassComment
		reject: [ :eachItem | eachItem first isEmptyOrNil and: [ eachItem second isEmptyOrNil ] ]
		thenCollect: [ :eachItem | 
					aVersionNumber isNil
						ifTrue: [
							MccTextClass
								from: (eachItem at: 1) 
								comment: (MccTextComment of: (eachItem at: 2))]
						ifFalse: [ 
							MccTextClass
								from: (eachItem at: 1)
								comment: (MccTextComment of: (eachItem at: 2))
								version: aVersionNumber ]]).
]

{ #category : #navigation }
MccExternalEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ self classes
]

{ #category : #'as yet unclassified' }
MccExternalEnvironment >> allComments [
	"Return all comments in this environment"
	<return: #Collection of: #MccComment>

	^ self comments.
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
MccExternalEnvironment >> classesAndComments [
	
	classesAndComments := OrderedCollection new.
	classesAndComments := self classes collect:[:aClass | aClass -> aClass comment].
	^ classesAndComments
]

{ #category : #accessing }
MccExternalEnvironment >> comments [
	<return: #Collection of: #MccComment>
	
	comments := OrderedCollection new.
	comments := self classes collect:#comment.
	^ comments
]

{ #category : #initialization }
MccExternalEnvironment >> initialize [
	super initialize.
	
	classes := OrderedCollection new.
	comments := nil. "lazy initialzation"
	classesAndComments := nil. "lazy initialzation"

]
