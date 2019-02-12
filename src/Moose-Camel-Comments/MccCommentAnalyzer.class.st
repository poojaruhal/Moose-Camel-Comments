"
I am an analyzer responsibile for analyzing two different version of the class-comment file.
"
Class {
	#name : #MccCommentAnalyzer,
	#superclass : #Object,
	#instVars : [
		'versionOne',
		'versionTwo',
		'versionOneClassesAndComments',
		'versionTwoClassesAndComments',
		'metrics'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #versions }
MccCommentAnalyzer class >> version: inputFileReferenceOne to: inputFileReferenceTwo [

	^ self new
		versionOne: inputFileReferenceOne;
		versionTwo: inputFileReferenceTwo.
]

{ #category : #private }
MccCommentAnalyzer >> analyze [
	
	
	self versionOneClassesAndComments: (MccExternalEnvironment fromCSV:self versionOne) classesAndComments.
	self versionTwoClassesAndComments: (MccExternalEnvironment fromCSV: self versionTwo) classesAndComments.
	
	self metrics addAll: 
	{ 
	'Different Classes' -> self differentClasses.
	'Common Classes' -> self commonClasses.
	'Classes Have Different comment' ->  self classesHaveDifferentComment.
	} asDictionary.
	
	^ self metrics.
	
]

{ #category : #metrics }
MccCommentAnalyzer >> classesHaveDifferentComment [

	| output commentChangedClasses|

	output := OrderedCollection new.
	
	commentChangedClasses := self commonClasses
		difference: 
			(self classesHaveSameComments collect: #key).
	
	commentChangedClasses
		do: [ :aClassName | 
			output add: {
			aClassName. 
			(self versionOneClassesAndComments  detect: [:anAssociation | anAssociation key = aClassName]) value.
			(self versionTwoClassesAndComments  detect: [:anAssociation | anAssociation key = aClassName]) value
			 }].
	^ output

]

{ #category : #metrics }
MccCommentAnalyzer >> classesHaveSameComments [
	^ (self versionOneClassesAndComments intersection: self versionTwoClassesAndComments) sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentAnalyzer >> commonClasses [

	^ ((self versionOneClassesAndComments collect: #key)
			intersection:
				(self versionTwoClassesAndComments
				 	collect: #key)) 
						sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentAnalyzer >> differentClasses [

	^ ((self versionOneClassesAndComments  collect: #key)
		difference: (self versionTwoClassesAndComments collect: #key))sort: [:a :b | a < b ]
]

{ #category : #'gt-inspector-extension' }
MccCommentAnalyzer >> gtInspectorVersionsMetricsIn: aComposite [
	<gtInspectorPresentationOrder: 0>
	
	^	aComposite fastTable
			title:'Metric';
			display: [  self metrics associations];
			column: 'Key'
				evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
			column: 'Value'
				evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
				beMultiple;
				send: [ :selection | 
				selection isNil 
				ifTrue: [ nil ]
				ifFalse: [ selection size = 1  
					ifTrue: [ selection anyOne value ] 
					ifFalse: [ selection collect: #value ] ]]		
			
		
]

{ #category : #initialization }
MccCommentAnalyzer >> initialize [ 
	super initialize.
	
	metrics := OrderedDictionary new.
	
	versionOneClassesAndComments := nil. "lazy"
	versionTwoClassesAndComments := nil. "lazy"
]

{ #category : #accessing }
MccCommentAnalyzer >> metrics [
	^ metrics
]

{ #category : #accessing }
MccCommentAnalyzer >> metrics: anObject [
	metrics := anObject
]

{ #category : #accessing }
MccCommentAnalyzer >> versionOne [
	^ versionOne
]

{ #category : #accessing }
MccCommentAnalyzer >> versionOne: anObject [
	versionOne := anObject
]

{ #category : #accessing }
MccCommentAnalyzer >> versionOneClassesAndComments [
	^ versionOneClassesAndComments
]

{ #category : #accessing }
MccCommentAnalyzer >> versionOneClassesAndComments: anObject [
	versionOneClassesAndComments := anObject
]

{ #category : #accessing }
MccCommentAnalyzer >> versionTwo [
	^ versionTwo
]

{ #category : #accessing }
MccCommentAnalyzer >> versionTwo: anObject [
	versionTwo := anObject
]

{ #category : #accessing }
MccCommentAnalyzer >> versionTwoClassesAndComments [
	^ versionTwoClassesAndComments
]

{ #category : #accessing }
MccCommentAnalyzer >> versionTwoClassesAndComments: anObject [
	versionTwoClassesAndComments := anObject
]
