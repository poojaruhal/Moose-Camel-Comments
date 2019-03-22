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
MccCommentsVersionComparator class >> version: versionOne to: versionTwo [

	^ self new
		versionOne: versionOne;
		versionTwo: versionTwo.
]

{ #category : #metrics }
MccCommentsVersionComparator >> classesHaveDifferentComment [

	| output commentChangedClasses|

	output := OrderedCollection new.
	
	commentChangedClasses := self commonClassesWithComments
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
	
	^ ((self onlyWithComments:versionOneClassesAndComments) intersection: (self onlyWithComments: versionTwoClassesAndComments)) sort: [:a :b | a name < b name]
]

{ #category : #metrics }
MccCommentsVersionComparator >> commonClasses [

	^ ((self versionOneClassesAndComments collect:[:anAssociation | anAssociation key name])
			intersection:
				(self versionTwoClassesAndComments
				 	collect: [:anAssociation | anAssociation key name])) 
						sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentsVersionComparator >> commonClassesWithComments [

	^ (((self onlyWithComments: versionOneClassesAndComments) collect: #key)
			intersection:
				((self onlyWithComments: versionTwoClassesAndComments)
				 	collect: #key)) 
						sort: [:a :b | a name < b name ]
]

{ #category : #private }
MccCommentsVersionComparator >> compare [

	self versionOneClassesAndComments: self versionOne classesAndComments.
	self versionTwoClassesAndComments: self versionTwo classesAndComments.
	
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

	^ ((self versionOneClassesAndComments  collect: [:anAssociation | anAssociation key name])
		difference: (self versionTwoClassesAndComments collect: [:anAssociation | anAssociation key name]))sort: [:a :b | a < b ]
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

{ #category : #'as yet unclassified' }
MccCommentsVersionComparator >> onlyWithComments: aCollectionOfClassesAndComments [

	^ aCollectionOfClassesAndComments reject:[:anAssociation | anAssociation value isEmpty]
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
