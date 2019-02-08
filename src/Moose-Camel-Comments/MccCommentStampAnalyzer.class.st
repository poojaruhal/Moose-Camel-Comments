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
MccCommentStampAnalyzer >> authorsWithCommentDate [
	"get information which author commited on which date"
	
	^ (self filterHistorical 
			collect:[:eachItem |
				(eachItem value at:1)-> (eachItem value at:2)]) sort: [ :a :b | a value < b value ]
]

{ #category : #'as yet unclassified' }
MccCommentStampAnalyzer >> classesWithCommentDate [
	"get information which author commited on which date"
	
	^ (self filterHistorical 
			collect:[:eachItem |
				(eachItem key )-> (eachItem value at:2)]) sort: [ :a :b | a value < b value ]
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
MccCommentStampAnalyzer >> filterHistorical [
	"return all classes without comment stamp as historical. 
	Historical means comment stamp is not available."
	
	^ self classesWithCommentStamp select:[:eachItem | eachItem value ~= 'historical'].
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

{ #category : #accessing }
MccCommentStampAnalyzer >> historical [
	"return all classes with comment stamp as historical. 
	Historical means comment stamp is not available."
	
	^ self classesWithCommentStamp select:[:eachItem | eachItem value = 'historical']
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
