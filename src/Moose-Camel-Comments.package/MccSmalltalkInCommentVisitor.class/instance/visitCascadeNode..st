visiting
visitCascadeNode: aCascadeNode 	
	| theMessages theResult |

	theResult := self resultFor: aCascadeNode.

	theMessages := aCascadeNode messages.	
	theMessages withIndexDo: [ :eachMessage :eachIndex |
		| eachResult |
		eachResult := self visitNode: eachMessage.
		eachResult isValid
			ifFalse: [
				aCascadeNode messages: (aCascadeNode messages first: eachIndex - 1).

				theResult isValid: false.
				theResult isPartiallyValid: (eachIndex > 1).
				theResult errorNode: eachMessage.
				theResult errorResult: eachResult.
				
				^ theResult ] ].
	^ theResult