"
I am an environment consisting of classes
"
Class {
	#name : #MccClassEnvironment,
	#superclass : #MccEnvironment,
	#instVars : [
		'classes'
	],
	#category : #'Moose-Camel-Comments-Model - Environment'
}

{ #category : #'instance creation' }
MccClassEnvironment class >> with: aClass [
	^ self new classes: { aClass }
]

{ #category : #'instance creation' }
MccClassEnvironment class >> withAll: aCollectionOfClasses [
	^ self new classes: aCollectionOfClasses
]

{ #category : #navigation }
MccClassEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ self classes
]

{ #category : #accessing }
MccClassEnvironment >> classes [
	<return: #Collection of: #Class>

	^ classes
]

{ #category : #accessing }
MccClassEnvironment >> classes: aCollectionOfClasses [
	classes := aCollectionOfClasses
]

{ #category : #initialization }
MccClassEnvironment >> initialize [
	super initialize.
	
	classes := OrderedCollection new
]
