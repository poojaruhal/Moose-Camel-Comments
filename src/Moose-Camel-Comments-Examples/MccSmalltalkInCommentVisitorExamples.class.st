Class {
	#name : #MccSmalltalkInCommentVisitorExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'instance creation' }
MccSmalltalkInCommentVisitorExamples >> smalltalkParser [
	<gtExample>
	
	^ MccSmalltalkParser new
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitAssignment [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'fortyTwo := 42'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitCodeInASentence [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '(Color r: 0.2 g: 0.6 b: 1.0) are code.'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitComplexMessageChain [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '((PragmaMenuBuilder pragmaKeyword: MenuRegistrationExample pragmaKeyword model: nil) menuEntitled: ''World'') popUpInWorld'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitDot [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '.'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	self assert: aResult filteredAST sourceInterval equals: (1 to: 0).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitEmptyBlock [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '[]'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	self assert: aResult filteredAST sourceInterval equals: (1 to: 2).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitHello [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Hello'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	self assert: aResult filteredAST sourceInterval equals: (1 to: 0).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitHelloWithDot [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Hello.'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	self assert: aResult filteredAST sourceInterval equals: (1 to: 0).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitHelloWorld [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Hello World'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitLiteralArray [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '#(first second)'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitObjectWithDot [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Object.'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	self assert: aResult filteredAST sourceInterval equals: (1 to: aText size - 1).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitObjectWithoutDot [
	<gtExample>
	| aParser aText aVisitor anAST aResult |

	aParser := self smalltalkParser.
	aText := 'Object'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	self assert: aResult filteredAST sourceInterval equals: (1 to: aText size).
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitOnlyNil [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'nil'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitSelfInASentence [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'It started itself by going wild'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitSelfKeywordWithBlockArgument [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ].'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitSentenceWithApostrophes [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '''s happy it''s only a cold'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitSentenceWithColon [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'He said: this is my mom'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitSequenceWithInvalidFirstStatementAndSelfKeywordWithBlockArgument [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Examples.
	self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ].'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUnimplementedMessageToGlobal [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Object can'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseAssignment [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'fortyTwo := 42. fortyTwo + 1'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseAssignmentWithGarbageInBetween [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'fortyTwo := 42. Hello World. fortyTwo + 1'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseGlobalClass [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Object new'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseSelf [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'self new'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseSuper [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'super new'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitUseUndeclaredVariable [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'fortyTwo + 1'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult
]

{ #category : #visiting }
MccSmalltalkInCommentVisitorExamples >> visitWorld [
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'World'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult
]

{ #category : #'instance creation' }
MccSmalltalkInCommentVisitorExamples >> visitor [
	<gtExample>
	
	^ MccSmalltalkInCommentVisitor new classOrMetaclass: self class
]
