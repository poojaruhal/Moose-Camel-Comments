"
My responsibility is to parse commentStamps from given file, extract author 
information, create data struture of classes and associated comment date.

ClassesWithCommentStamp holds all classes and their associated commentStamp.
Some classes do not have comment stamps and those are marked with 'historical'.
The classes for which comment stamp is available are accessed by 
'filterHistorical' API.
 
"
Class {
	#name : #MccCommentStamp,
	#superclass : #Object,
	#instVars : [
		'commentClass',
		'commentStamp',
		'classesWithCommentStamp',
		'parsedCommentStamps'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccCommentStamp class >> fromCSV: aFileReference [

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
MccCommentStamp >> authors [
	"get information of which author commited on which date"
	
	^ (self filterHistorical
			collect:[:eachAssociation |
				eachAssociation value first]) asSet asOrderedCollection sorted.
]

{ #category : #'as yet unclassified' }
MccCommentStamp >> authorsWithCommentDate [
	"get information which author commited on which date"
	
	^ (self filterHistorical 
			collect:[:eachItem |
				(eachItem value at:1)-> (eachItem value at:2)]) sort: [ :a :b | a value < b value ]
]

{ #category : #'as yet unclassified' }
MccCommentStamp >> classesWithCommentDate [
	"get information which author commited on which date"
	
	^ (self filterHistorical 
			collect:[:eachItem |
				(eachItem key )-> (eachItem value at:2)]) sort: [ :a :b | a value < b value ]
]

{ #category : #accessing }
MccCommentStamp >> classesWithCommentStamp [
	^ classesWithCommentStamp
]

{ #category : #accessing }
MccCommentStamp >> classesWithCommentStamp: aCollection [
	classesWithCommentStamp := aCollection
]

{ #category : #accessing }
MccCommentStamp >> filterHistorical [
	"return all classes without comment stamp as historical. 
	Historical means comment stamp is not available."
	
	^ self classesWithCommentStamp select:[:eachItem | eachItem value ~= 'historical'].
]

{ #category : #'gt-inspector-extension' }
MccCommentStamp >> gtInspectorCommentStampsIn: aComposite [
	<gtInspectorPresentationOrder: 0>

	^ aComposite table
		title: 'Classes With CommentStamps' translated;
		display: [
			 self classesWithCommentStamp.
			]
]

{ #category : #accessing }
MccCommentStamp >> historical [
	"return all classes with comment stamp as historical. 
	Historical means comment stamp is not available."
	
	^ self classesWithCommentStamp select:[:eachItem | eachItem value = 'historical']
]

{ #category : #initialization }
MccCommentStamp >> initialize [ 	
	super initialize.
	classesWithCommentStamp := OrderedCollection new.
]

{ #category : #parsing }
MccCommentStamp >> parseAndFilter [
	
	self parseCommentStamps.
	^	self filterHistorical.
]

{ #category : #parsing }
MccCommentStamp >> parseCommentStamps [
	| mccCommentStampParser|
	
	mccCommentStampParser := MccCommentStampParser new.
	
	^ (self classesWithCommentStamp collect: [ 
		:eachRecord |
		eachRecord value: (mccCommentStampParser parse:(eachRecord value))]) sort: [ :a :b | a key < b key ].
]
