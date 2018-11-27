Class {
	#name : #MccParseCommentText,
	#superclass : #MccParseComment,
	#instVars : [
		'text'
	],
	#category : 'Moose-Camel-Comments'
}

{ #category : #accessing }
MccParseCommentText >> comment [ 
	^ text
]

{ #category : #accessing }
MccParseCommentText >> text [ 
	^ (string, ('[[[' asParser, string , ']]]' asParser) ==> [ :aToken |  { aToken first } ]) star.
]
