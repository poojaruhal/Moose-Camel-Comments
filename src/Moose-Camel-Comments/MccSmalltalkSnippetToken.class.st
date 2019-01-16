Class {
	#name : #MccSmalltalkSnippetToken,
	#superclass : #MccSmalltalkToken,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #testing }
MccSmalltalkSnippetToken >> isEmpty [
	<return: #Boolean>
	
	^ self value isEmpty
]

{ #category : #parsing }
MccSmalltalkSnippetToken >> parse [
	<return: #MccSmalltalkToken>
	| parsedResult theCode theCodeToken theLeftToken theRightToken theCompositeToken |

	parsedResult := (MccSmalltalkInCommentParser new sea) parse: self value.

	"the island (second item) is the AST"
	theCode := parsedResult second.

	theCodeToken := MccSmalltalkCodeToken
		on: self collection
		start: theCode sourceInterval first + self start - 1
		stop: ((parsedResult third isEmpty and: [ theCode sourceInterval isNotEmpty ]) ifTrue: [ self stop ] ifFalse: [ theCode sourceInterval last + self start - 1 ]).
	theCodeToken ast: theCode.
	
	theCodeToken isEmpty
		ifTrue: [ ^ MccSmalltalkTextToken
			on: self collection
			start: self start
			stop: self stop ].

	theLeftToken := MccSmalltalkSnippetToken
		on: self collection
		start: self start
		stop: (theCodeToken isEmpty ifTrue: [ self stop ] ifFalse: [ (theCodeToken start - 1) ]).

	theRightToken := MccSmalltalkSnippetToken
		on: self collection
		start: self stop - parsedResult third size + 1
		stop: self stop.

	theCompositeToken := (MccSmalltalkCompositeToken 
		on: self collection
		start: theLeftToken start
		stop: theRightToken stop) children: { theLeftToken . theCodeToken . theRightToken }.

	^ theCompositeToken parse
]
