visiting
visitSequenceNode: aSequenceNode
	| theStatements theResult |
	self visitTemporaryNodes: aSequenceNode temporaries.

	theStatements := aSequenceNode statements.
	
	theResult := self resultFor: aSequenceNode.
	
	theStatements withIndexDo: [ :eachStatement :eachIndex |
		| eachResult |
		eachResult := self visitNode: eachStatement.
		eachResult isValid
			ifFalse: [
				| toBeRemoved |
				toBeRemoved := theStatements last: (theStatements size - eachIndex + 1).
				toBeRemoved do: [ :statementToRemove | aSequenceNode removeNode: statementToRemove ].

				aSequenceNode periods: (aSequenceNode periods first: eachIndex - 1).

				theResult isValid: false.
				theResult isPartiallyValid: (eachIndex > 1).
				theResult errorNode: eachStatement.
				theResult errorResult: eachResult.
				
				^ theResult ] ].

	^ theResult