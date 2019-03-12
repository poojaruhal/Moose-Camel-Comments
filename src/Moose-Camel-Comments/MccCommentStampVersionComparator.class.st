"
I am an comparator responsibile for comparing different version of the commentStamp file.
"
Class {
	#name : #MccCommentStampVersionComparator,
	#superclass : #Object,
	#instVars : [
		'versionOne',
		'versionTwo',
		'parsedFilteredVersionOne',
		'parsedFilteredVersionTwo',
		'metrics'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'as yet unclassified' }
MccCommentStampVersionComparator class >> version: inputFileReferenceOne to: inputFileReferenceTwo [

	^ self new
		versionOne: inputFileReferenceOne;
		versionTwo: inputFileReferenceTwo.
]

{ #category : #metrics }
MccCommentStampVersionComparator >> classesHaveDifferentTimestamp [

	^ (self parsedFilteredVersionOne difference: self parsedFilteredVersionTwo) sort: [:a :b | a < b  ]
]

{ #category : #metrics }
MccCommentStampVersionComparator >> classesHaveSameTimeStampWithTimeStampFromVersions [

	| output versionOneList versionTwoList |
	
	versionOneList := self parsedFilteredVersionOne.
	versionTwoList := self parsedFilteredVersionTwo.
	output := OrderedCollection new.
	
	versionOneList
		do: [ :anAssociation | 
			(versionTwoList includes: anAssociation)
				ifTrue: [ | index |
					index := versionTwoList indexOf: anAssociation.
					output
						add:
							{anAssociation key.
							anAssociation value second.
							(versionTwoList at: index) value second} ] ].
	^ output
]

{ #category : #metrics }
MccCommentStampVersionComparator >> classesHaveSameTimestamp [

	^ (self parsedFilteredVersionOne intersection: self parsedFilteredVersionTwo) sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampVersionComparator >> commentStampChangedClasses [

	| output stampChangedClasses|

	output := OrderedCollection new.
	
	stampChangedClasses := self commonClasses
		difference: 
			(self classesHaveSameTimestamp collect: #key).
	
	stampChangedClasses
		do: [ :aClassName | 
			output add: {
			aClassName. 
			(self parsedFilteredVersionOne detect: [:anAssociation | anAssociation key = aClassName]) value second.
			(self parsedFilteredVersionTwo detect: [:anAssociation | anAssociation key = aClassName]) value second
			 }].
	^ output

]

{ #category : #metrics }
MccCommentStampVersionComparator >> commonClasses [

	^ ((self parsedFilteredVersionOne collect: #key)
			intersection:
				(self parsedFilteredVersionTwo
				 	collect: #key)) 
						sort: [:a :b | a < b ]
]

{ #category : #computing }
MccCommentStampVersionComparator >> compare [
	
	|commentStampVersionOne commentStampVersionTwo|
	
	commentStampVersionOne :=  MccCommentStamp fromCSV: self versionOne.
	commentStampVersionTwo := MccCommentStamp fromCSV: self versionTwo.
	self parsedFilteredVersionOne: commentStampVersionOne parseAndFilter.
	self parsedFilteredVersionTwo: commentStampVersionTwo parseAndFilter.
	
	self metrics addAll: 
	{ 
	'Classes Have Different Timestamp' -> self classesHaveDifferentTimestamp.
	'Different Classes' -> self differentClasses.
	'Classes Have Same Timestamp ' -> self classesHaveSameTimestamp.
	'Common Classes' -> self commonClasses.
	'Common Classes With TimeStamps from Versions' -> self classesHaveSameTimeStampWithTimeStampFromVersions.
	'Comment Stamp Changed From Common Classes' ->  self commentStampChangedClasses.
	} asDictionary.
	
	^ self metrics.
	
]

{ #category : #metrics }
MccCommentStampVersionComparator >> differentClasses [

	^ ((self parsedFilteredVersionOne collect: #key)
		difference: (self parsedFilteredVersionTwo collect: #key))sort: [:a :b | a < b ]
]

{ #category : #'gt-inspector-extension' }
MccCommentStampVersionComparator >> gtInspectorVersionsMetricsIn: aComposite [
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
MccCommentStampVersionComparator >> initialize [ 
	super initialize.
	
	metrics := OrderedDictionary new.
	
	parsedFilteredVersionOne := nil. "lazy"
	parsedFilteredVersionTwo := nil. "lazy"
	
]

{ #category : #accessing }
MccCommentStampVersionComparator >> metrics [
	^ metrics
]

{ #category : #accessing }
MccCommentStampVersionComparator >> metrics: anObject [
	metrics := anObject
]

{ #category : #accessing }
MccCommentStampVersionComparator >> parsedFilteredVersionOne [
	^ parsedFilteredVersionOne
	
	
]

{ #category : #accessing }
MccCommentStampVersionComparator >> parsedFilteredVersionOne: aCollection [
	parsedFilteredVersionOne := aCollection
	
	
]

{ #category : #accessing }
MccCommentStampVersionComparator >> parsedFilteredVersionTwo [
	^ parsedFilteredVersionTwo
]

{ #category : #accessing }
MccCommentStampVersionComparator >> parsedFilteredVersionTwo: aCollection [
	parsedFilteredVersionTwo := aCollection
	
	
]

{ #category : #accessing }
MccCommentStampVersionComparator >> versionOne [
	^ versionOne
]

{ #category : #accessing }
MccCommentStampVersionComparator >> versionOne: anObject [
	versionOne := anObject
]

{ #category : #accessing }
MccCommentStampVersionComparator >> versionTwo [
	^ versionTwo
]

{ #category : #accessing }
MccCommentStampVersionComparator >> versionTwo: anObject [
	versionTwo := anObject
]
