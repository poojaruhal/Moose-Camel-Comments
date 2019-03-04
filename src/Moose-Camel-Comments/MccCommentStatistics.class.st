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
		'total stopwords' -> self stopwords.
		'total pronouns' -> self pronouns.
		'average number of lines in comments' -> self avgLines.
		'average number of words' -> self avgWords.
		'average number of stopwords' -> self avgStopwords.
		'average number of unique words' -> self lexicalDensity.
		'avg number of pronouns' -> self avgPronouns.
	} asDictionary.
		
	^ self allStatistics.
]

{ #category : #metrics }
MccCommentStatistics >> pronouns [
	"Return the average amount of pronouns per entity with a comment"
	<return: #Number>

	^ (self filteredEntities sum: [ :eachEntity | eachEntity pronouns size ])
]

{ #category : #metrics }
MccCommentStatistics >> stopwords [
	"Return the average amount of stopwords per entity with a comment"
	<return: #Number>
	
	^ (self filteredEntities sum: [ :eachEntity | eachEntity stopwords size ])
]

{ #category : #metrics }
MccCommentStatistics >> totalWords [
	"Return the total number of words per entity with a comment"
	<return: #Number>
	
	^ self filteredEntities sum: [ :eachEntity | eachEntity words size ]
]
