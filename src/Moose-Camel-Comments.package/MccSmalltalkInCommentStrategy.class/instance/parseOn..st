parsing
parseOn: aPP2Context
	| position smalltalkParser aResult  |
	position := aPP2Context rememberPosition.
	
	smalltalkParser := MccSmalltalkParser new.
	
	WrapperSignal emit: (aPP2Context copyFrom: (position + 1) to: aPP2Context contents size).
	aResult := smalltalkParser parseOn: aPP2Context.
	
	WrapperSignal emit: aResult.
	
	aResult isPetit2Failure
		ifTrue: [ aPP2Context restorePosition: position ]
		ifFalse: [ aResult := self processAST: aResult with: aPP2Context at: position ].
	
	^ aResult