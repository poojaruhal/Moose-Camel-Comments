Class {
	#name : #MccProjectStatistics,
	#superclass : #MccStatistics,
	#instVars : [
		'project'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccProjectStatistics class >> from: aProject [

	^ self new project: aProject.
]

{ #category : #walking }
MccProjectStatistics >> commits [
	<return:#Dictionary of:#Commits>
	
	^ self project at:'commits'
]

{ #category : #'as yet unclassified' }
MccProjectStatistics >> contributers [

	^ self project at:'contributers'
]

{ #category : #'as yet unclassified' }
MccProjectStatistics >> graphData [
	<return:#Dictionary of:#Metrics>

	self allStatistics addAll:{
	'#commits' -> self commits size.
	'project-name'-> self projectName.
	'time' -> self timestamp.
	'#contributors' -> self contributers size.
	}asDictionary.
	
	^ allStatistics.
]

{ #category : #accessing }
MccProjectStatistics >> metadata [
	<return:#Dictionary>
	
	^ self project at:'data'.
]

{ #category : #walking }
MccProjectStatistics >> project [
	<return:#Dictionary of:#ProjectData>
	
	^ project
]

{ #category : #accessing }
MccProjectStatistics >> project: anObject [
	project := anObject
]

{ #category : #accessing }
MccProjectStatistics >> projectName [
	<return:#String>
	
	^ self project at: 'project'
]

{ #category : #walking }
MccProjectStatistics >> timestamp [
	<return:#TimeStamp>
	
	^ DateAndTime fromUnixTime: (self metadata at:'created').
]
