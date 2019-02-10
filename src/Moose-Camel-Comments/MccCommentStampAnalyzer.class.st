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
	#category : #'Moose-Camel-Comments'
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
	
	commentStampVersionOne :=  MccCommentStamp fromCSV:self versionOne.
	commentStampVersionTwo := MccCommentStamp fromCSV: self versionTwo.
	self parsedFilteredVersionOne: commentStampVersionOne parseAndFilter.
	self parsedFilteredVersionTwo: commentStampVersionTwo parseAndFilter.
	
	self metrics addAll: 
	{ 
	'Different Classes' -> self differentClassesInVersions.
	'Different Classes By Keys' -> self differentClassesByKeysInVersions.
	'Common Classes' -> self commonClassesInVersions.
	'Common Classes By Keys' -> self commonClassesByKeysInVersions.
	'Common Classes With TimeStamps from Versions' -> self commonClassesWithTimeStampsFromVersions.
	} asDictionary.
	
	^ self metrics.
	
]

{ #category : #metrics }
MccCommentStampAnalyzer >> commonClassesByKeysInVersions [

	^ ((self parsedFilteredVersionOne collect: #key)
			intersection:
				(self parsedFilteredVersionTwo
				 	collect: #key)) 
						sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> commonClassesInVersions [

	^ (self parsedFilteredVersionOne intersection: self parsedFilteredVersionTwo) sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> commonClassesWithTimeStampsFromVersions [

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
MccCommentStampAnalyzer >> differentClassesByKeysInVersions [

	^ ((self parsedFilteredVersionOne collect: #key)
		difference: (self parsedFilteredVersionTwo collect: #key))sort: [:a :b | a < b ]
]

{ #category : #metrics }
MccCommentStampAnalyzer >> differentClassesInVersions [

	^ (self parsedFilteredVersionOne difference: self parsedFilteredVersionTwo) sort: [:a :b | a < b  ]
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
