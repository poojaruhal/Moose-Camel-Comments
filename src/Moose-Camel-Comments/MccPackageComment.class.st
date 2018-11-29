"
I represent a package comment
"
Class {
	#name : #MccPackageComment,
	#superclass : #MccComment,
	#category : #'Moose-Camel-Comments-Model - Comment'
}

{ #category : #testing }
MccPackageComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ anObject packageManifestOrNil isNotNil and: [ anObject packageManifestOrNil hasComment ]
]

{ #category : #converting }
MccPackageComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self package packageComment
]

{ #category : #accessing }
MccPackageComment >> package [
	<return: #RPackage>
	
	^ self artefact
]

{ #category : #references }
MccPackageComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ (MccClassReferenceFinder new
		comment: self;
		environment: aMccEnvironment) references
]
