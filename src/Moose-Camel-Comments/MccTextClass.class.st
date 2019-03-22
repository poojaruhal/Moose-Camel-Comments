"
I am a class created from exeternal enviornment (CSV).

I know my comment stored in ""comment"" variable.

"
Class {
	#name : #MccTextClass,
	#superclass : #Object,
	#instVars : [
		'comment',
		'version',
		'name'
	],
	#category : #'Moose-Camel-Comments-Model - Comment'
}

{ #category : #'instance creation' }
MccTextClass class >> from: aTextClassName comment: aTextComment [
 "create a MccTextClass  with given className and aTextComment"
	(aTextClassName isEmptyOrNil)
		ifTrue:[
			^ MccTextComment of: aTextComment.
			]
		ifFalse: [^ self new name: aTextClassName; comment: aTextComment]


]

{ #category : #'instance creation' }
MccTextClass class >> from: aTextClassName comment: aTextComment version: aVersion [
 "create a MccTextClass  with given className and aTextComment"
	(aTextClassName isEmptyOrNil)
		ifTrue:[
			^ MccTextComment of: aTextComment.
			]
		ifFalse: [^ (self new) name: aTextClassName; comment: aTextComment; version: aVersion]


]

{ #category : #comparing }
MccTextClass >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #converting }
MccTextClass >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self name asString
]

{ #category : #accessing }
MccTextClass >> comment [
	^ comment
]

{ #category : #accessing }
MccTextClass >> comment: anObject [
	comment := anObject
]

{ #category : #testing }
MccTextClass >> hasComment [ 
	^ self comment isNotEmpty and: [ self comment isNotNil ]
]

{ #category : #comparing }
MccTextClass >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
MccTextClass >> name [
	^ name
]

{ #category : #accessing }
MccTextClass >> name: anObject [
	name := anObject
]

{ #category : #printing }
MccTextClass >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' class: ';
		print: name
]

{ #category : #accessing }
MccTextClass >> version [
	^ version
]

{ #category : #accessing }
MccTextClass >> version: anObject [
	version := anObject
]
