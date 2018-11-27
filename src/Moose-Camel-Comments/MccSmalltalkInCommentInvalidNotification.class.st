Class {
	#name : #MccSmalltalkInCommentInvalidNotification,
	#superclass : #Notification,
	#instVars : [
		'errorNode'
	],
	#category : 'Moose-Camel-Comments-Parser'
}

{ #category : #accessing }
MccSmalltalkInCommentInvalidNotification >> errorNode [
	^ errorNode
]

{ #category : #accessing }
MccSmalltalkInCommentInvalidNotification >> errorNode: anObject [
	errorNode := anObject
]
