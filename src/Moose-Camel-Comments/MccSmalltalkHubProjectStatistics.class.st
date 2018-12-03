"
I am a project selected from SmalltalkHub.
I know all parameters of a project like commits, contributers, metadata, project, timestamp of the project.
My instance is created from MccSmalltalkHubStatistics smalltalkHubJson.
MccSmalltalkHubStatistics smalltalkHubJson can take ExampleData or File.


"
Class {
	#name : #MccSmalltalkHubProjectStatistics,
	#superclass : #MccStatistics,
	#instVars : [
		'project'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccSmalltalkHubProjectStatistics class >> from: aProject [

	^ self new project: aProject.
]

{ #category : #walking }
MccSmalltalkHubProjectStatistics >> commits [
	<return:#Dictionary of:#Commits>
	
	^ (self project at:'commits')
	ifEmpty: [ '' ].
]

{ #category : #walking }
MccSmalltalkHubProjectStatistics >> contributers [

	^ (self project at:'contributers')
	ifEmpty: [ '' ].
]

{ #category : #metrics }
MccSmalltalkHubProjectStatistics >> graphData [
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
MccSmalltalkHubProjectStatistics >> metadata [
	<return:#Dictionary>
	
	^ (self project at:'data')
	ifNil: [''] .
]

{ #category : #walking }
MccSmalltalkHubProjectStatistics >> project [
	<return:#Dictionary of:#ProjectData>
	
	^ project
]

{ #category : #accessing }
MccSmalltalkHubProjectStatistics >> project: anObject [
	project := anObject
]

{ #category : #accessing }
MccSmalltalkHubProjectStatistics >> projectName [
	<return:#String>
	
	^ self project at: 'project'
]

{ #category : #walking }
MccSmalltalkHubProjectStatistics >> timestamp [
	<return:#TimeStamp>
	
	^ (self unixTimestamp)
	ifNil: [ '']
	ifNotNil: [ DateAndTime fromUnixTime: self unixTimestamp - 2177452800].
]

{ #category : #walking }
MccSmalltalkHubProjectStatistics >> unixTimestamp [
	
	^ (self metadata) 
	ifEmpty:[]
	ifNotEmpty: [  self metadata at:'created' ]	.
]
