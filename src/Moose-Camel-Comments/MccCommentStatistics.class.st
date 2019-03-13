"
I am responsible for gathering metrics from the comments. The comments are general text comment. 
I can be instantiated with 
[ [ [ 
			MccCommentStatistics with: anExternalEnvironment.
			 ] ] ]
The external enviornment can be created using 
[ [ [ 
			MccExternalEnvironment fromCSV: (MccCommentComparatorExamples new pharo1FileReference)
			 ] ] ]
"
Class {
	#name : #MccCommentStatistics,
	#superclass : #MccStatistics,
	#category : #'Moose-Camel-Comments-Model - Statistics'
}

{ #category : #metrics }
MccCommentStatistics >> avgLines [
	"Return the average amount of lines in a comment among entities with a comment"
	<return: #Number>

	^ (self lines size / self filteredEntities size) asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgMetrics [
	
	^ { 
		'avg lines in comments' -> self avgLines.
		'avg words' -> self avgWords.
		'avg stopwords' -> self avgStopwords.
		'avg unique words' -> self lexicalDensity.
		'avg pronouns' -> self avgPronouns.
	} asDictionary.

]

{ #category : #metrics }
MccCommentStatistics >> avgPronouns [
	"Return the average amount of pronouns per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity pronouns size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgStopwords [
	"Return the average amount of stopwords per entity with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity stopwords size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgWords [
	"Return the average amount of words per entity with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity words size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccCommentStatistics >> collectPronouns [
	"Return the average amount of pronouns per entity with a comment"
	<return: #Number>

	^ self filteredEntities
		select:
			[ :eachEntity | 
				eachEntity pronouns isNotEmpty]
		thenCollect:
			[ :eachEntity | eachEntity className -> eachEntity pronouns ]
]

{ #category : #initialization }
MccCommentStatistics >> createAllEntities [
	^ self environment allComments
]

{ #category : #initialization }
MccCommentStatistics >> createFilteredEntities [
	<return: #Array of: #Object>
	
	^ self createAllEntities
		reject: [ :eachEntity | 
			eachEntity isEmpty ]
]

{ #category : #'gt-inspector-extension' }
MccCommentStatistics >> gtInspectorClassesIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite roassal2 
		title: 'Overview' translated;
		initializeView: [ RTMondrian new ];
		painting: [ :view | 
			view interaction popupText: [ :aComment | aComment className ].
			view shape
				circle;
				size: [ :e | e words size ].
			view nodes: self environment comments.
			view normalizer
				objects: self environment comments;
				normalizeColor: [ :e | e words asSet size ] using: (Array with: Color gray with: Color blue with: Color red) using: [ :value | (value + 1) ln ].
			view layout grid.
			"view build." ].
			
			
]

{ #category : #metrics }
MccCommentStatistics >> lexicalDensity [
	"Return the average amount of unique words per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachComment |
		 (eachComment words as: Set) size ]) / self filteredEntities size asFloat
]

{ #category : #'private-accessing' }
MccCommentStatistics >> lines [
	<return: #Array of: #MccSentences>
	
	^ self filteredEntities
		flatCollect: [ :eachEntity |
			 eachEntity sentences
			 	select: [ :aSentence | aSentence isNotEmpty ] ]
]

{ #category : #metrics }
MccCommentStatistics >> metrics [

	self allStatistics addAll:
	{ 
		'total number of comments' -> self filteredEntities size.
		'total lines' -> self lines size.
		'total words' -> self totalWords.
		'total stopwords' -> self totalStopwords.
		'total pronouns' -> self totalPronouns.
	} asDictionary.
		
	^ self allStatistics.
]

{ #category : #metrics }
MccCommentStatistics >> totalPronouns [
	"Return total sum of pronouns in filteredEntiies calculated from each comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity pronouns size ])
]

{ #category : #metrics }
MccCommentStatistics >> totalStopwords [
	"Return the total number of stopwords in filteredEntiies calculated from each comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity stopwords size ])
]

{ #category : #metrics }
MccCommentStatistics >> totalWords [
	"Return the total number of words of filteredEntiies calculated from each comment"
	<return: #Number>
	
	^ self filteredEntities sum: [ :eachEntity | eachEntity words size ]
]

{ #category : #accessing }
MccCommentStatistics >> view [
	| b ds dataSet|.

	b := RTGrapher new.
	b extent: 500 @ 200.
	"ds := RTData new.
	ds interaction highlight.
	ds points: self metrics associations.
	ds barShape width: 10.
	ds y: [ :e | e value].
	ds barChartWithBarTitle: #key.
	b add: ds."
	dataSet := RTData new.
	dataSet dotShape color: (Color red alpha: 0.3);
	labeledAs: [ :e | e key asString].
	dataSet
	points: self avgMetrics associations;
	y: [ :e | e value].
	b add: dataSet.
	b axisY.
	b axisX
		noTick;
		noLabel.
 	^ b
]
