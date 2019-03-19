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

	|aCollectionOfClassComment|

	"first column- className, secondColumn- class comment"
	aCollectionOfClassComment:=
		(NeoCSVReader on: aFileReference readStream)
			addField;
			addField;
			upToEnd.
		
	^ self new classesAndComments: (
		aCollectionOfClassComment 
			reject:[:eachItem | eachItem first isEmptyOrNil and:[eachItem second isEmptyOrNil]]
			thenCollect:[:eachItem |
				 (eachItem at:1) -> (MccTextComment of:(eachItem at:2) with:(eachItem at:1))]).
	
	
	 
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
	^ classesAndComments
]

{ #category : #accessing }
MccExternalEnvironment >> classesAndComments: theAssociations [	
	
	classesAndComments := theAssociations sort:[:a :b | a key < b key].
	self classes:(theAssociations collect:[:eachItem | eachItem key]).
	self comments:(theAssociations collect:[:eachItem | eachItem value]).
	
	^ self.
]

{ #category : #accessing }
MccExternalEnvironment >> comments [
	<return: #Collection of: #MccComment>

	^ comments
]

{ #category : #accessing }
MccExternalEnvironment >> comments: aCollectionOfComments [
	comments:= aCollectionOfComments
]

{ #category : #initialization }
MccExternalEnvironment >> initialize [
	super initialize.
	
	classes := OrderedCollection new.
	comments := OrderedCollection new.
	classesAndComments := OrderedDictionary new.
]
