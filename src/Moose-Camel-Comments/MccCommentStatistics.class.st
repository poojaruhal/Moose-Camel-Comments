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
	#instVars : [
		'metrics'
	],
	#category : #'Moose-Camel-Comments-Model - Statistics'
}

{ #category : #metrics }
MccCommentStatistics >> avgMetrics [

	^ {  
		'avg sentences in comments' -> self avgSentences.
		'avg words' -> self avgWords.
		'avg stopwords' -> self avgStopwords.
		'avg unique words' -> self lexicalDensity.
		'avg pronouns' -> self avgPronouns.
	}asDictionary.
]

{ #category : #metrics }
MccCommentStatistics >> avgPronouns [
	"Return the average amount of pronouns per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity pronouns size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgSentences [
	"Return the average amount of lines in a comment among entities with a comment"
	<return: #Number>

	^ ((self sentences select:[:aSentence | aSentence isNotEmpty])size) / (self filteredEntities size) asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgStopwords [
	"Return the average amount of stopwords per MccTextComment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity stopwords size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccCommentStatistics >> avgWords [
	"Return the average amount of words per MccTextComment with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity |
		 eachEntity words size ]) / self filteredEntities size asFloat
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

{ #category : #'as yet unclassified' }
MccCommentStatistics >> commentLengthFrequency [
	
	^ ((( self environment classes reject: [ :e | e comment isEmpty]) collect: [ :f |  f comment sentences size]) sorted) withIndexCollect: [ :f :i | i -> f ].
]

{ #category : #private }
MccCommentStatistics >> compute [ 

	self allStatistics addAll: 
	{ 
	'Metrics' -> self metrics.
	'Avergare Metrics' -> self avgMetrics.	
	 }
]

{ #category : #initialization }
MccCommentStatistics >> createAllEntities [
	^ self environment allComments
]

{ #category : #initialization }
MccCommentStatistics >> createFilteredEntities [
	<return: #Array of: #Object>
	"filtered entities are same as allEntities as we are taking all comments"
		
	^ 	self environment allComments
			reject:[:eachComment | eachComment isEmpty]
]

{ #category : #accessing }
MccCommentStatistics >> gtInspectorCommentAverageMetricsIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ aComposite roassal2 
		title: 'Avergae Metric Overview' translated;
		when:[self allStatistics isNotEmpty];
		initializeView: [ RTGrapher new ];
		painting: [ :view | 
			|  avgDataSet|
			view extent: 500 @ 200.
	
			avgDataSet := RTData new.
			avgDataSet dotShape color: (Color red alpha: 0.3);
			labeledAs: [ :e | e key asString].
			avgDataSet
			points: self avgMetrics associations;
			y: [ :e | e value].
			view add: avgDataSet.
			view axisY.
			view axisX
				noTick;
				noLabel.
			view build.
			]
]

{ #category : #accessing }
MccCommentStatistics >> gtInspectorCommentMetricsIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ aComposite roassal2 
		title: ' Metric Overview' translated;
		when:[self allStatistics isNotEmpty];
		initializeView: [ RTGrapher new ];
		painting: [ :view | 
			| ds |
			view extent: 500 @ 200.
			
			ds := RTData new.
			ds interaction highlight.
			ds points: self metrics associations.
			ds barShape width: 10.
			ds y: [ :e | e value].
			ds barChartWithBarTitle: #key.
			view add: ds.
			view axisY.
			view axisX
				noTick;
				noLabel.
			view build.
			].
	
]

{ #category : #accessing }
MccCommentStatistics >> gtInspectorCommentOverviewIn: aComposite [
	"<gtInspectorPresentationOrder: 3>"
	
	^ aComposite roassal2 
		title: ' Overview' translated;
		when:[self allStatistics isNotEmpty];
		initializeView: [ RTGrapher new ];
		painting: [ :view | 
			| ds avgDataSet|
			view extent: 500 @ 200.
			
			ds := RTData new.
			ds interaction highlight.
			ds points: self metrics associations.
			ds barShape width: 10.
			ds y: [ :e | e value].
			ds barChartWithBarTitle: #key.
			view add: ds.
	
			avgDataSet := RTData new.
			avgDataSet dotShape color: (Color red alpha: 0.3);
			labeledAs: [ :e | e key asString].
			avgDataSet
			points: self avgMetrics associations;
			y: [ :e | e value].
			view add: avgDataSet.
			view axisY.
			view axisX
				noTick;
				noLabel.
			view build.
			]
	
	
	"| b ds dataSet|.

	b := RTGrapher new.
	b extent: 500 @ 200.
	
	ds := RTData new.
	ds interaction highlight.
	ds points: self metrics associations.
	ds barShape width: 10.
	ds y: [ :e | e value].
	ds barChartWithBarTitle: #key.
	b add: ds.
	
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
 	^ b"
]

{ #category : #'gt-inspector-extension' }
MccCommentStatistics >> gtInspectorCommentsIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite roassal2 
		title: 'Overview' translated;
		when:[self allStatistics isNotEmpty];
		initializeView: [ RTMondrian new ];
		painting: [ :view | 
			view interaction popupText: [ :aClass | aClass name ].
			view shape
				circle;
				size: [ :c | c comment words size ].
			view nodes: self environment classes.
			view normalizer
				objects: self environment classes;
				normalizeColor: [ :c | c comment words asSet size ] using: (Array with: Color gray with: Color blue with: Color red) using: [ :value | (value + 1) ln ].
			view layout grid.
			"view build." ].
			
			
]

{ #category : #initialization }
MccCommentStatistics >> initialize [
	super initialize.
]

{ #category : #metrics }
MccCommentStatistics >> lexicalDensity [
	"Return the average amount of unique words per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity lemmas size ]) / self filteredEntities size asFloat.
]

{ #category : #metrics }
MccCommentStatistics >> metrics [
 
	 ^ { 
		'total number of classes' -> self environment allClasses size.
		'total number of comments' -> self filteredEntities size.
		'total sentences' -> self sentences size.
		'total words' -> self totalWords.
		'total stopwords' -> self totalStopwords.
		'total pronouns' -> self totalPronouns.
	}asDictionary.

	
	
	
	
]

{ #category : #'as yet unclassified' }
MccCommentStatistics >> showCommentDistribution [
	
	|points b ds| 
	
	points := self commentLengthFrequency.
	
	b := RTGrapher new.
	b extent: 300 @ 300.
	ds := RTData new.
	ds label: 'Comment distribution w.r.t #sentence'.
	ds dotShape color:  (Color blue alpha: 0.2).
	ds points: points .
	ds x: #key.
	ds y: #value.
	b add: ds.
	b axisX noDecimal.
	b axisY noDecimal.
	^ b.

]

{ #category : #metrics }
MccCommentStatistics >> totalPronouns [
	"Return total sum of pronouns in filteredEntiies calculated from each comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity pronouns size ])
]

{ #category : #metrics }
MccCommentStatistics >> totalSentences [
	"Return the total number of sentences of filteredEntiies calculated from each comment"
	<return: #Number>
	
	^ self filteredEntities sum: [ :eachEntity | 
		(eachEntity sentences select:[:aSentence | aSentence isNotEmpty])size]
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
