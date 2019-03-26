"
I am just a textual comment that does not belong to anything. I am generally created form external environment CSV of class and its comments. If I am loaded with class information, I know my class using className.

[[[
	MccTextComment of: 'Number holds the most general methods for dealing with numbers.'
]]]
"
Class {
	#name : #MccTextComment,
	#superclass : #MccComment,
	#instVars : [
		'textClassName'
	],
	#category : #'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccTextComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ anObject isString
]

{ #category : #comparing }
MccTextComment >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self text = anObject text
]

{ #category : #converting }
MccTextComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self text asString
]

{ #category : #'as yet unclassified' }
MccTextComment >> gtInspectorLinguisticOverviewIn: aComposite [
	<gtInspectorPresentationOrder: 1>
	^ aComposite roassal2
		title: 'Linguistic Overview' translated;
		initializeView: [ RTGrapher new ];
		painting: [ :b | 
			| ds dataset|
			b extent: 500 @ 200.
			ds := RTData new.
			ds interaction highlight.
			ds points: self metrics associations.
			ds barShape width: 10.
			ds y: [ :e | e value ].
			ds barChartWithBarTitle: #key.
			b add: ds.
			
"			dataset := RTData new.
			dataset dotShape color: (Color red alpha: 0.3);
			labeledAs: [ :e | e value asString].
			dataset points: self metrics associations;
			y: [ :e | e value].
			b add: dataset."
			
			b axisY.
			b axisX
				noTick;
				noLabel.
			b build.
			b ]
]

{ #category : #comparing }
MccTextComment >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self text hash
]

{ #category : #printing }
MccTextComment >> printOn: aStream [
	aStream
		nextPutAll: 'Comment: ';
		nextPut: $(;
		nextPutAll: self asString;
		nextPut: $)
]

{ #category : #references }
MccTextComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ (MccClassReferenceFinder new
		comment: self;
		environment: aMccEnvironment) references
]

{ #category : #converting }
MccTextComment >> text [
	<return: #String>
	
	^ self artefact
]

{ #category : #accessing }
MccTextComment >> textClassName [
	^ textClassName.
]

{ #category : #accessing }
MccTextComment >> textClassName: anObject [
	textClassName := anObject
]
