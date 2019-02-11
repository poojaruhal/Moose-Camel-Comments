"
I am an analyzer responsibile for analyzing different version of the commentStamp file.
"
Class {
	#name : #MccCommentStampAnalyzer,
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
MccCommentStampAnalyzer class >> version: inputFileReferenceOne to: inputFileReferenceTwo [

	^ self new
		versionOne: inputFileReferenceOne;
		versionTwo: inputFileReferenceTwo.
]

{ #category : #computing }
MccCommentStampAnalyzer >> analyze [
	
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
MccCommentStampAnalyzer >> classesHaveDifferentTimestamp [

	^ (self parsedFilteredVersionOne difference: self parsedFilteredVersionTwo) sort: [:a :b | a < b  ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> classesHaveSameTimeStampWithTimeStampFromVersions [

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
MccCommentStampAnalyzer >> classesHaveSameTimestamp [

	^ (self parsedFilteredVersionOne intersection: self parsedFilteredVersionTwo) sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> commentStampChangedClasses [

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
MccCommentStampAnalyzer >> commonClasses [

	^ ((self parsedFilteredVersionOne collect: #key)
			intersection:
				(self parsedFilteredVersionTwo
				 	collect: #key)) 
						sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> differentClasses [

	^ ((self parsedFilteredVersionOne collect: #key)
		difference: (self parsedFilteredVersionTwo collect: #key))sort: [:a :b | a < b ]
]

{ #category : #'gt-inspector-extension' }
MccCommentStampAnalyzer >> gtInspectorVersionsMetricsIn: aComposite [
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
MccCommentStampAnalyzer >> initialize [ 
	super initialize.
	
	metrics := OrderedDictionary new.
	
	parsedFilteredVersionOne := nil. "lazy"
	parsedFilteredVersionTwo := nil. "lazy"
	
]

{ #category : #accessing }
MccCommentStampAnalyzer >> metrics [
	^ metrics
]

{ #category : #accessing }
MccCommentStampAnalyzer >> metrics: anObject [
	metrics := anObject
]

{ #category : #accessing }
MccCommentStampAnalyzer >> parsedFilteredVersionOne [
	^ parsedFilteredVersionOne
	
	
]

{ #category : #accessing }
MccCommentStampAnalyzer >> parsedFilteredVersionOne: aCollection [
	parsedFilteredVersionOne := aCollection
	
	
]

{ #category : #accessing }
MccCommentStampAnalyzer >> parsedFilteredVersionTwo [
	^ parsedFilteredVersionTwo
]

{ #category : #accessing }
MccCommentStampAnalyzer >> parsedFilteredVersionTwo: aCollection [
	parsedFilteredVersionTwo := aCollection
	
	
]

{ #category : #accessing }
MccCommentStampAnalyzer >> versionOne [
	^ versionOne
]

{ #category : #accessing }
MccCommentStampAnalyzer >> versionOne: anObject [
	versionOne := anObject
]

{ #category : #accessing }
MccCommentStampAnalyzer >> versionTwo [
	^ versionTwo
]

{ #category : #accessing }
MccCommentStampAnalyzer >> versionTwo: anObject [
	versionTwo := anObject
]
