'ha' asPParser, [ :aPP2Context |
	| position smalltalkParser aResult |
	position := aPP2Context rememberPosition.

	smalltalkParser := MccSmalltalkInCommentParser new.
	aResult := smalltalkParser parseOn: aPP2Context.
	
	aResult isPetit2Failure
		ifTrue: [ aPP2Context restorePosition: position ]
		ifFalse: [
			aResult isVariable
				ifTrue: [ aPP2Context restorePosition: position ]
				ifFalse: [  ] ].
	aResult
	] asPParser, #any asPParser star parse: 'haOb[ject class'