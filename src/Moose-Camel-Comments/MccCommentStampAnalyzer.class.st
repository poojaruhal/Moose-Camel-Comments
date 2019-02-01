Class {
	#name : #MccCommentStampAnalyzer,
	#superclass : #Object,
	#instVars : [
		'commentClass',
		'commentStamp',
		'classesWithCommentStamp',
		'parsedCommentStamps'
	],
	#category : #'Moose-Camel-Comments'
}

{ #category : #'instance creation' }
MccCommentStampAnalyzer class >> fromCSV: aFileReference [

	|aCollectionOfClassAndCommentStamps|
	
	aCollectionOfClassAndCommentStamps := (NeoCSVReader on: aFileReference readStream)
		addField;
		addField;
		upToEnd.
		
	^ self new classesWithCommentStamp: (aCollectionOfClassAndCommentStamps
		collect:[:eachItem |
			(eachItem at:1) -> (eachItem at:2)])
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzer >> analyzeCommentStamp [

	^ self parseCommentStamps.
	
]

{ #category : #accessing }
MccCommentStampAnalyzer >> classesWithCommentStamp [
	^ classesWithCommentStamp
]

{ #category : #accessing }
MccCommentStampAnalyzer >> classesWithCommentStamp: aCollection [
	classesWithCommentStamp := aCollection
]

{ #category : #accessing }
MccCommentStampAnalyzer >> commentStamp [
	^ commentStamp
]

{ #category : #accessing }
MccCommentStampAnalyzer >> commentStamp: anObject [
	commentStamp := anObject
]

{ #category : #'gt-inspector-extension' }
MccCommentStampAnalyzer >> gtInspectorCommentStampsIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite table
		title: 'Classes With CommentStamps' translated;
		display: [
			 self classesWithCommentStamp.
			]
]

{ #category : #initialization }
MccCommentStampAnalyzer >> initialize [ 	
	super initialize.
	classesWithCommentStamp := OrderedCollection new.
]

{ #category : #parsing }
MccCommentStampAnalyzer >> parseCommentStamps [
	| mccCommentStampParser|
	
	mccCommentStampParser := MccCommentStampParser new.
	
	^ self classesWithCommentStamp collect: [ 
		:eachRecord |
		eachRecord value: (mccCommentStampParser parse:(eachRecord value))]
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzer >> viewStatisticsGroupedByYearAndClasses [
	| b ds dataSet|.

	b := RTGrapher new.
	b extent: 500 @ 200.
	ds := RTData new.
	ds interaction highlight.
	ds points: self classesWithCommentStamp.
	ds barShape width: 10.
	ds y: [ :e | e value size].
	ds barChartWithBarTitle: #key.
	b add: ds.
	dataSet := RTData new.
	dataSet dotShape color: (Color red alpha: 0.3);
	labeledAs: [ :e | e value size asString].
	dataSet
	points: self classesWithCommentStamp;
	y: [ :e | e value size].
	b add: dataSet.
	b axisY.
	b axisX
		noTick;
		noLabel.
 	^ b
]
