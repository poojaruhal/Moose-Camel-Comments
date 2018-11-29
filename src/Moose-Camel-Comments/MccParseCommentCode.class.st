Class {
	#name : #MccParseCommentCode,
	#superclass : #MccParseComment,
	#instVars : [
		'code',
		'codeSea'
	],
	#category : #'Moose-Camel-Comments'
}

{ #category : #accessing }
MccParseCommentCode >> code [ 
	^ '[[[' asPParser, string, ']]]' asPParser  ==> [ :aToken | aToken second as: String ]
]

{ #category : #accessing }
MccParseCommentCode >> codeSea [
	^ (code sea ==> #second) star
]

{ #category : #accessing }
MccParseCommentCode >> start [ 
	^ codeSea end
]
