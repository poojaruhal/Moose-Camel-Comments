"
A CommentStamp is in the format of ""authorName DateOfTheStamp timeOfTheStamp"".
 
For the Class part:  I represent a parser that parses a CommentStamp.

For the Responsibility part: I know Comment stamp and I am responsibile for seperating the author name and date from the commentStamp.

For the Collaborators Part: I collborate with the  Class Parser.


 
Internal Representation and Key Implementation Points.

    Instance Variables
	string:		hold the stamp string.


    Implementation Points
"
Class {
	#name : #MccCommentStampParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'commentStampString',
		'authorName',
		'stampDate',
		'stampTime',
		'space'
	],
	#category : #'Moose-Camel-Comments'
}

{ #category : #accessing }
MccCommentStampParser >> authorName [
	^ self word
]

{ #category : #accessing }
MccCommentStampParser >> colonSeperator [
	^ $: asParser
]

{ #category : #accessing }
MccCommentStampParser >> commentStampString [
	"input string to parse: ' author 04/12/2019 14:20 '"
	<return: #OrderedCollection>
	
	| commentStampArray |
	
	^ self historical /
			((authorName , space , stampDate , space , stampTime)
				==> [ :aCollection | 
					commentStampArray := OrderedCollection new.
					commentStampArray add: aCollection first.
					commentStampArray add: aCollection third.
					commentStampArray add: aCollection fifth.
					commentStampArray ]).
]

{ #category : #accessing }
MccCommentStampParser >> digit [
	^ #digit asParser plus flatten ==> #asInteger
]

{ #category : #accessing }
MccCommentStampParser >> historical [
	^ ($< asParser , self word , $> asParser) ==> [ :aCollection | aCollection second ]
]

{ #category : #accessing }
MccCommentStampParser >> slashSeperator [
	^ $/ asParser
]

{ #category : #accessing }
MccCommentStampParser >> space [
	^ #blank asParser plus
]

{ #category : #accessing }
MccCommentStampParser >> stampDate [
	^ (self digit , self slashSeperator , self digit , self slashSeperator , self digit)
		==>
			[ :aCollection | Date newDay: (aCollection at: 3) month: (aCollection at: 1) year: (aCollection at: 5) ]
]

{ #category : #accessing }
MccCommentStampParser >> stampTime [
	^ (self digit , self colonSeperator , self digit) flatten
		==> [ :aString | Time readFrom: aString readStream ].
]

{ #category : #accessing }
MccCommentStampParser >> start [
	^ commentStampString end
]

{ #category : #accessing }
MccCommentStampParser >> word [
	^ #word asParser star flatten
]
