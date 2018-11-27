"
I am an environment consisting of methods
"
Class {
	#name : #MccMethodEnvironment,
	#superclass : #MccEnvironment,
	#instVars : [
		'methods'
	],
	#category : 'Moose-Camel-Comments-Model - Environment'
}

{ #category : #navigation }
MccMethodEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ #()
]

{ #category : #accessing }
MccMethodEnvironment >> methods [
	<return: #Collection of: #CompiledMethod>

	^ methods
]

{ #category : #accessing }
MccMethodEnvironment >> methods: aCollectionOfCompiledMethods [
	methods := aCollectionOfCompiledMethods
]
