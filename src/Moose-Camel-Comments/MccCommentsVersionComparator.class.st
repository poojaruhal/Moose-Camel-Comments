"
I am an comparator responsibile for comparator two different version of the class-comment file.
"
Class {
	#name : #MccCommentsVersionComparator,
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
MccCommentsVersionComparator class >> version: inputFileReferenceOne to: inputFileReferenceTwo [

	^ self new
		versionOne: inputFileReferenceOne;
		versionTwo: inputFileReferenceTwo.
]

{ #category : #metrics }
MccCommentsVersionComparator >> classesHaveDifferentComment [

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
MccCommentsVersionComparator >> classesHaveSameComments [
	^ (self versionOneClassesAndComments intersection: self versionTwoClassesAndComments) sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentsVersionComparator >> commonClasses [

	^ ((self versionOneClassesAndComments collect: #key)
			intersection:
				(self versionTwoClassesAndComments
				 	collect: #key)) 
						sort: [:a :b | a < b ]
]

{ #category : #private }
MccCommentsVersionComparator >> compare [
	
	
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
MccCommentsVersionComparator >> differentClasses [

	^ ((self versionOneClassesAndComments  collect: #key)
		difference: (self versionTwoClassesAndComments collect: #key))sort: [:a :b | a < b ]
]

{ #category : #'gt-inspector-extension' }
MccCommentsVersionComparator >> gtInspectorVersionsMetricsIn: aComposite [
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
MccCommentsVersionComparator >> initialize [ 
	super initialize.
	
	metrics := OrderedDictionary new.
	
	versionOneClassesAndComments := nil. "lazy"
	versionTwoClassesAndComments := nil. "lazy"
]

{ #category : #accessing }
MccCommentsVersionComparator >> metrics [
	^ metrics
]

{ #category : #accessing }
MccCommentsVersionComparator >> metrics: anObject [
	metrics := anObject
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionOne [
	^ versionOne
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionOne: anObject [
	versionOne := anObject
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionOneClassesAndComments [
	^ versionOneClassesAndComments
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionOneClassesAndComments: anObject [
	versionOneClassesAndComments := anObject
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionTwo [
	^ versionTwo
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionTwo: anObject [
	versionTwo := anObject
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionTwoClassesAndComments [
	^ versionTwoClassesAndComments
]

{ #category : #accessing }
MccCommentsVersionComparator >> versionTwoClassesAndComments: anObject [
	versionTwoClassesAndComments := anObject
]
