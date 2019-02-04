"
I represent the collection of Statistics about the smalltalk system that can be used for various analysis in MccEnvironment.

I collect different Statistics about Smalltalk image.

I use sentenceProcessor to process a comment into sentences.


"
Class {
	#name : #MccStatistics,
	#superclass : #Object,
	#instVars : [
		'environment',
		'allStatistics',
		'filteredEntities',
		'allEntities'
	],
	#category : 'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccStatistics class >> with: anEnvironment [
	^ self new environment:anEnvironment.
]

{ #category : #accessing }
MccStatistics >> allEntities [
	^ allEntities ifNil: [ allEntities := self createAllEntities ]
]

{ #category : #accessing }
MccStatistics >> allStatistics [
	^ allStatistics
]

{ #category : #metrics }
MccStatistics >> avgEntitiesWithComment [
	"Return the percentage of entities with comments out of all entities"
	<return: #Number>

	^ (self filteredEntities size / self allEntities size) asFloat
]

{ #category : #metrics }
MccStatistics >> avgLines [
	"Return the average amount of lines in a comment among entities with a comment"
	<return: #Number>

	^ (self lines size / self filteredEntities size) asFloat
]

{ #category : #metrics }
MccStatistics >> avgStopwords [
	"Return the average amount of stopwords per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity mccComment stopwords size ]) / self filteredEntities size asFloat
]

{ #category : #metrics }
MccStatistics >> avgWords [
	"Return the average amount of words per entity with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity mccComment words size ]) / self filteredEntities size asFloat
]

{ #category : #initialization }
MccStatistics >> createAllEntities [
	^ self subclassResponsibility
]

{ #category : #initialization }
MccStatistics >> createFilteredEntities [
	<return: #Array of: #Object>
	
	^ self createAllEntities
		reject: [ :eachEntity | 
			eachEntity mccComment isEmpty ]
]

{ #category : #accessing }
MccStatistics >> environment [
	^ environment
]

{ #category : #accessing }
MccStatistics >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
MccStatistics >> filteredEntities [
	^ filteredEntities ifNil: [ filteredEntities := self createFilteredEntities ]
]

{ #category : #initialization }
MccStatistics >> initialize [
	super initialize.

	allStatistics := Dictionary new.

	allEntities := nil. "lazy"
	filteredEntities := nil. "lazy"
]

{ #category : #metrics }
MccStatistics >> lexicalDensity [
	"Return the average amount of unique words per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity |
		 (eachEntity mccComment words as: Set) size ]) / self filteredEntities size asFloat
]

{ #category : #'private-accessing' }
MccStatistics >> lines [
	<return: #Array of: #MccSentences>
	^ self filteredEntities
		 flatCollect: [ :eachEntity |
			 eachEntity mccComment sentences ]
]

{ #category : #metrics }
MccStatistics >> metrics [

	self allStatistics addAll:
	{ 
		'average number of EntityComment' -> self avgEntitiesWithComment. 
		'average number of lines in comments' -> self avgLines.
		'average number of words' -> self avgWords.
		'average number of stopwords' -> self avgStopwords.
		'lexical Density' -> self lexicalDensity
	} asDictionary.
		
	^ self allStatistics.
]
