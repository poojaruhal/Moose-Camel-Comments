Class {
	#name : #MccSmalltalkInCommentParserExamples,
	#superclass : #Object,
	#category : #'Moose-Camel-Comments-Examples-Parser'
}

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> morphicParseComplexBorder [
	<gtExample>
	| aParser aString theAST theTokens |
	
	aParser := self parser.
	aString := 'see BorderedMorph.

poly := polygon250 

baseColor := Color blue twiceLighter.
border := (ComplexBorder framed: 10) baseColor: poly color.
border frameRectangle: ((100@100 extent: 200@200) insetBy: -5) on: Display getCanvas.
baseColor := Color red twiceLighter.
border := (ComplexBorder framed: 10) baseColor: baseColor.
border drawPolygon: {100@100. 300@100. 300@300. 100@300} on: Display getCanvas.

border drawPolyPatchFrom: 100@200 via: 100@100 via: 200@100 to: 200@200 on: Display getCanvas.
border drawPolyPatchFrom: 100@100 via: 200@100 via: 200@200 to: 100@200 on: Display getCanvas.
border drawPolyPatchFrom: 200@100 via: 200@200 via: 100@200 to: 100@100 on: Display getCanvas.
border drawPolyPatchFrom: 200@200 via: 100@200 via: 100@100 to: 200@100 on: Display getCanvas.

border := (ComplexBorder raised: 10) baseColor: poly color.
border drawPolygon: poly getVertices on: Display getCanvas

360 / 16.0 22.5
points := (0 to: 15) collect:[:i| (Point r: 100 degrees: i*22.5) + 200].
Display getCanvas fillOval: (100@100 extent: 200@200) color: baseColor.
border drawPolygon: points on: Display getCanvas.

-1 to: points size + 1 do:[:i|
	border drawPolyPatchFrom: (points atWrap: i) via: (points atWrap: i+1) via: (points atWrap: i+2) to: (points atWrap: i+3) on: Display getCanvas.
].

Display getCanvas fillOval: (100@100 extent: 200@200) color: baseColor.
0 to: 36 do:[:i|
	border drawLineFrom: (Point r: 100 degrees: i*10) + 200 to: (Point r: 100 degrees: i+1*10) + 200
		on: Display getCanvas.
].
drawPolygon:
Point r: 1.0 degrees: 10
MessageTally spyOn:[
Display deferUpdates: true.
t1 := [1 to: 1000 do:[:i|
	border drawLineFrom: (100@100) to: (300@100) on: Display getCanvas.
	border drawLineFrom: (300@100) to: (300@300) on: Display getCanvas.
	border drawLineFrom: (300@300) to: (100@300) on: Display getCanvas.
	border drawLineFrom: (100@300) to: (100@100) on: Display getCanvas]] timeToRun.
Display deferUpdates: false.
].

MessageTally spyOn:[
Display deferUpdates: true.
t2 := [1 to: 1000 do:[:i|
	border drawLine2From: (100@100) to: (300@100) on: Display getCanvas.
	border drawLine2From: (300@100) to: (300@300) on: Display getCanvas.
	border drawLine2From: (300@300) to: (100@300) on: Display getCanvas.
	border drawLine2From: (100@300) to: (100@100) on: Display getCanvas]] timeToRun.
Display deferUpdates: false.
].'.
	
	theAST := aParser parse: aString.
	theTokens := theAST textAndCodeTokens.
	self assert: theTokens size equals: 10.
	self assert: (theTokens first isText).
	self assert: (theTokens second isCode).
	self assert: (theTokens third isCode).
	self assert: (theTokens fourth isCode).
	self assert: (theTokens fifth isCode).
	self assert: (theTokens sixth isCode).
	self assert: (theTokens seventh isCode).


	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> morphicParseTextParagraph [
	<gtExample>
	| aParser aString theAST theTokens |
	
	aParser := self parser.
	aString := 'Morphs exist in a tree, rooted at a World (generally a PasteUpMorph). The morphs owned by a morph ...Morph and its submorphs, set its #visible property to false using the #visible: method. '.
	
	theAST := aParser parse: aString.
	theTokens := theAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens first) start equals: 1.
	self assert: (theTokens first) stop equals: aString size.
	self assert: theTokens first value equals: aString.

	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> morphicParseTitleMorph [
	<gtExample>
	| aParser aString theAST theTokens |
	
	aParser := self parser.
	aString := 'Example usage:

	| menu |
	
	menu := MenuMorph new.

	menu buildTitle: [ :titleMorph | titleMorph
		title: ''aCoolTitle'';
		icon: self theme icons alertIcon;
		withCloseBox;
		withPinBox;
		color: Color purple		
	].

	... " add items" ...
	
	menu popUpInWorld'.
	
	theAST := aParser parse: aString.
	theTokens := theAST textAndCodeTokens.
	self assert: theTokens size equals: 7.
	self assert: (theTokens first isText).
	self assert: (theTokens second isCode).
	self assert: (theTokens third isText).
	self assert: (theTokens fourth isCode).
	self assert: (theTokens fifth isCode).
	self assert: (theTokens sixth isText).
	self assert: (theTokens seventh isCode).


	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseCodeWithLastDot [
	<gtExample>
	| aParser aString anAST theTokens |
	
	aParser := self parser.
	aString := 'self extent: 200@200.'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aString size.
	self assert: theTokens first value equals: aString.
	
	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseCodeWithoutLastDot [
	<gtExample>
	| aParser aString anAST theTokens |
	
	aParser := self parser.
	aString := 'self extent: 200@200'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aString size.
	self assert: theTokens first value equals: aString.
	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseEmpty [
	<gtExample>
	| aParser aString theTokens |
	
	aParser := self parser.
	aString := ''.
	
	theTokens := aParser parse: aString.
	self assert: theTokens size equals: 0.
	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseFortyTwo [
	<gtExample>
	| aParser aString anAST theTokens |
	
	aParser := self parser.
	aString := 'fortyTwo := 42.
fortyTwo logCr'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aString size.
	self assert: theTokens first value equals: aString.
	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseGiveMyselfYourself [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'Give myself yourself'.
	
	theToken := aParser parse: aString.
	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.

	^ theToken
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseHashtagExample [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := '#Variable is an instance variable'.
	
	theToken := aParser parse: aString.

	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.
	
	^ theToken
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseHelloWorld [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'Hello World'.
	
	theToken := aParser parse: aString.
	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.
	
	^ theToken
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseMultipleSnippetsInSentence [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.
	aString := 'Also, (Color red: 0.2 green: 0.6 blue: 1.0) or (Color r: 0.2 g: 0.6 b: 1.0) are code.'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 5.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens second isKindOf: MccSmalltalkCodeToken).
	self assert: (theTokens third isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens fourth isKindOf: MccSmalltalkCodeToken).
	self assert: (theTokens fifth isKindOf: MccSmalltalkTextToken).

	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseRandomCodeSnippet [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.

	aString := '[
	(1 to: 200) do: [ :i | p value: i.  (Delay forMilliseconds: 10) wait ].
	p delete ] fork'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	"self assert: (theTokens second isKindOf: MccSmalltalkCodeToken)."

	
	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseRandomSentenceWithLiteral [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.

	aString := '1 is the smallest number after zero.'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	"self assert: (theTokens second isKindOf: MccSmalltalkCodeToken)."

	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseSelfInSentence [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'It started itself a few minutes ago.'.
	
	theToken := aParser parse: aString.
	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.

	^ theToken
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseSelfKeywordWithBlockArgument [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.
	aString := 'self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ]'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aString size.
	self assert: theTokens first value equals: aString.
	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseSentenceWithApostrophes [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'He''s happy it''s only a cold.'.
	
	theToken := aParser parse: aString.

	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.
	
	^ theToken
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseSentenceWithColon [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'Example: this.'.
	
	theToken := aParser parse: aString.
	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.
	
	^ theToken
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseSequenceWithInvalidFirstStatementAndSelfKeywordWithBlockArgument [
	<gtExample>
	| aParser aTextString aCodeString aString theTokens anAST |
	
	aParser := self parser.
	
	aTextString := '
Examples.
'.
	
	aCodeString := 'self show: ''Doing...'' from: 500 to: 600 during: [ :bar |
	500 to: 600 do: [ :x | 
		bar current: x.
		(Delay forMilliseconds: 20) wait 
		"Just to slow it down so we can see what''s going on" ] ]'.

	aString := aTextString, aCodeString.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 2.
	
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aTextString size.
	self assert: theTokens first value equals: aTextString.
	
	self assert: (theTokens second isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens second start equals: aTextString size + 1.
	self assert: theTokens second stop equals: aString size.
	self assert: theTokens second value equals: aCodeString.
	
	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseSequenceWithOnlyFirstValidExpression [
	<gtExample>
	| aParser aString theTokens anAST aTextString aCodeString |
	
	aParser := self parser.
	
	aCodeString := 'SystemProgressMorph reset.'.
	aTextString := '
Examples.'.

	aString := aCodeString, aTextString.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 2.
	
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aCodeString size.
	self assert: theTokens first value equals: aCodeString.
	
	self assert: (theTokens second isKindOf: MccSmalltalkTextToken).
	self assert: theTokens second start equals: aCodeString size + 2. "Cr is not there"
	self assert: theTokens second stop equals: aString size.
	self assert: theTokens second value equals: aTextString allButFirst. "without Cr"
	
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseSingleCodeInSentence [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.
	aString := 'Also, (Color red: 0.2 green: 0.6 blue: 1.0) is code.'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 3.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens second isKindOf: MccSmalltalkCodeToken).
	self assert: (theTokens third isKindOf: MccSmalltalkTextToken).

	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTextAndSimpleMessageSendsToGlobal [
	<gtExample>
	| aParser aString anAST theTokens |
	
	aParser := self parser.
	aString := 'I display a set of progress indicator in a list.
Special care is taken to update the view while the rest of the UI process is blocked.

Reset.
SystemProgressMorph reset.

Examples.'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	
	self assert: theTokens size equals: 4.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens second isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens third isKindOf: MccSmalltalkCodeToken).
	self assert: (theTokens fourth isKindOf: MccSmalltalkTextToken).
	
	^ theTokens
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTextWithMessageSendsToGlobalAndBlockClosures [
	<gtExample>
	| aParser aString anAST theTokens |
	
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
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 6.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens third isKindOf: MccSmalltalkCodeToken).
	
	^ theTokens 
]

{ #category : #parsing }
MccSmalltalkInCommentParserExamples >> parseTwoExamples [
	<gtExample>
	| aParser aString anAST theTokens allTokens |
	aParser := self parser.
	aString := 'Example:
| p |
p := ProgressBarMorph from: 0 to: 200.

Another example:
| p |
p := ProgressBarMorph from: 0 to: 100.'.
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: (theTokens first isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens second isKindOf: MccSmalltalkCodeToken).
	self assert: (theTokens third isKindOf: MccSmalltalkTextToken).
	self assert: (theTokens fourth isKindOf: MccSmalltalkCodeToken).
	^ theTokens
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parseUndeclaredVariableAsReceivedObject [
	<gtExample>
	| aParser aString theTokens anAST |
	
	aParser := self parser.
	aString := 'LayoutFrame identity
	topOffset: topHeight;
	bottomFraction: 0;
	bottomOffset: self buttonsBarHeight;
	leftOffset: -1;
	rightOffset: 1'.
	
	anAST := aParser parse: aString.
	theTokens := anAST textAndCodeTokens.
	self assert: theTokens size equals: 1.
	self assert: (theTokens first isKindOf: MccSmalltalkCodeToken).
	self assert: theTokens first start equals: 1.
	self assert: theTokens first stop equals: aString size.
	self assert: theTokens first value equals: aString.

	^ theTokens
]

{ #category : #'instance creation' }
MccSmalltalkInCommentParserExamples >> parser [
	<gtExample>
	
	^ MccSmalltalkInCommentParser
]

{ #category : #'parsing - simple' }
MccSmalltalkInCommentParserExamples >> parserLowersMySelfEsteem [
	<gtExample>
	| aParser aString theToken |
	
	aParser := self parser.
	aString := 'My self esteem is too high'.
	
	theToken := aParser parse: aString.
	self assert: (theToken isKindOf: MccSmalltalkTextToken).
	self assert: theToken start equals: 1.
	self assert: theToken stop equals: aString size.
	self assert: theToken value equals: aString.

	^ theToken
]

{ #category : #'parsing - sea' }
MccSmalltalkInCommentParserExamples >> seaParseDot [
	<gtExample>
	| aParser aString theAST |
	
	aParser := self seaParser.
	aString := '.'.
	
	theAST := aParser parse: aString.
	self assert: theAST first isEmpty.
	self assert: theAST second sourceInterval equals: (1 to: 0).
	self assert: theAST third isEmpty.
	
	^ theAST
]

{ #category : #'parsing - sea' }
MccSmalltalkInCommentParserExamples >> seaParseExamplesWithDot [
	<gtExample>
	| aParser aString theAST |
	
	aParser := self seaParser.
	aString := 'Examples.'.
	
	theAST := aParser parse: aString.
	self assert: theAST first equals: aString allButLast asOrderedCollection.
	self assert: theAST second sourceInterval equals: (1 to: 0).
	self assert: theAST third isEmpty.
	
	^ theAST
]

{ #category : #'parsing - sea' }
MccSmalltalkInCommentParserExamples >> seaParseObject [
	<gtExample>
	| aParser aString theAST |
	
	aParser := self seaParser.
	aString := 'Object'.
	
	theAST := aParser parse: aString.
	self assert: theAST first equals: aString asOrderedCollection.
	self assert: theAST second sourceInterval equals: (1 to: 0).
	self assert: theAST third isEmpty.

	^ theAST
]

{ #category : #'parsing - sea' }
MccSmalltalkInCommentParserExamples >> seaParseObjectWithDot [
	<gtExample>
	| aParser aString theAST |
	
	aParser := self seaParser.
	aString := 'Object.'.
	
	theAST := aParser parse: aString.
	self assert: theAST first equals: aString allButLast asOrderedCollection.
	self assert: theAST second sourceInterval equals: (1 to: 0).
	self assert: theAST third isEmpty.

	^ theAST
]

{ #category : #'instance creation' }
MccSmalltalkInCommentParserExamples >> seaParser [
	<gtExample>
	
	^ MccSmalltalkInCommentParser new sea
]
