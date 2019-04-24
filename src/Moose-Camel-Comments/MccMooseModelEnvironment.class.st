"
I represent an Moose model environment. I am created from a moose model of a version. The versions are Pharo versions.

Moose should be installed.

I collobrate with MccTextModel to create text model of the comment. 
"
Class {
	#name : #MccMooseModelEnvironment,
	#superclass : #MccEnvironment,
	#category : #'Moose-Camel-Comments-Model - Environment'
}

{ #category : #navigation }
MccMooseModelEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ self allModelClasses.
]

{ #category : #'as yet unclassified' }
MccMooseModelEnvironment >> allComments [
	"Return all comments in this environment"
	<return: #Collection of: #MccComment>

	^ (self allClasses reject:[:aModelClass | aModelClass value comments isEmpty]) withIndexCollect: [ :aModelClass :index | aModelClass value comments first content ].
]
