Class {
	#name : #MccSmalltalkInCommentParserExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseFortyTwo [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'fortyTwo := 42.
fortyTwo logCr'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseHelloWorld [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'Hello World'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseSelfKeywordWithBlockArgument [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ].'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseSequenceWithOnlyFirstValidExpression [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'SystemProgressMorph reset.
Examples.'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTextAndSimpleMessageSendsToGlobal [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'I display a set of progress indicator in a list.
Special care is taken to update the view while the rest of the UI process is blocked.

Reset.
SystemProgressMorph reset.

Examples.'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTextWithMessageSendsToGlobalAndBlockClosures [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'I display a set of progress indicator in a list.
Special care is taken to update the view while the rest of the UI process is blocked.

Reset.
SystemProgressMorph reset.

Examples.
self show: ''Doing...'' from: 500 to: 600 during: [ :bar |
	500 to: 600 do: [ :x | 
		bar current: x.
		(Delay forMilliseconds: 20) wait 
		"Just to slow it down so we can see what''s going on" ] ].

self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ].'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTwoExamples [
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'Example:
| p |
p := ProgressBarMorph from: 0 to: 200.

Another example:
| p |
p := ProgressBarMorph from: 0 to: 100.'.
	
	anAST := aParser parse: aString.
	
	^ anAST
]

{ #category : #'instance creation' }
MccSmalltalkInCommentParserExamples >> parser [
	<gtExample>
	
	^ MccSmalltalkInCommentParser
]
