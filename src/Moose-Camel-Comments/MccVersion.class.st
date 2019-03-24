"
A Pharo version that holds the version number and the enviornment from which it is created.

The environment can be for example  MccExternalEnvironment. The environment holds the data. 
"
Class {
	#name : #MccVersion,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'version',
		'environment'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'instance creation' }
MccVersion class >> loadFrom: aFileReference version: aVersion [
	
	^ self new environment: (MccExternalEnvironment fromCSV: aFileReference  of: aVersion); version: aVersion.
	
]

{ #category : #accessing }
MccVersion >> classesAndComments [
	
	^ self environment classesAndComments.
]

{ #category : #accessing }
MccVersion >> environment [
	^ environment
]

{ #category : #accessing }
MccVersion >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
MccVersion >> version [
	^ version
]

{ #category : #accessing }
MccVersion >> version: anObject [
	version := anObject
]
