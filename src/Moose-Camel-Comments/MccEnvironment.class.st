"
I play a role of an environment or scope in which we are searching references
"
Class {
	#name : #MccEnvironment,
	#superclass : #Object,
	#category : 'Moose-Camel-Comments-Model - Environment'
}

{ #category : #navigation }
MccEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ self subclassResponsibility
]

{ #category : #navigation }
MccEnvironment >> allMethods [
	"Return all methods in this environment"
	<return: #Collection of: #CompiledMethod>

	^ self allClasses flatCollect: [ :eachClass | eachClass methods ]
]

{ #category : #testing }
MccEnvironment >> classNamed: aClassName ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find a class with an exact given name in this environment and evaluate aFoundBlock if such class exists
	and aNoneBlock otherwise"
	<return: #Object>
	
	^ self allClasses
		detect: [ :eachClass | eachClass name = aClassName ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'gt-inspector-extension' }
MccEnvironment >> gtInspectorClassesIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite table
		title: 'Classes' translated;
		display: [ self allClasses ]
]

{ #category : #testing }
MccEnvironment >> hasClassNamed: aClassName [
	"Return true if there is a class in this environment with an exact name"
	<return: #Boolean>
	
	^ self
		classNamed: aClassName
		ifFound: [ true ]
		ifNone: [ false ]
]
