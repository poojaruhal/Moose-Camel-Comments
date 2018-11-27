visiting
visitMessageNode: aMessageNode 
	| aMessageResult theArguments |
	
	aMessageResult := self resultFor: aMessageNode.
	
	(aMessageNode isCascaded not or: [aMessageNode isFirstCascaded]) 
		ifTrue: [
			| aReceiverResult |
			aReceiverResult := self visitNode: aMessageNode receiver.
			aReceiverResult isValid
				ifFalse: [
					aMessageResult isValid: false.
					aMessageResult isPartiallyValid: false.
					aMessageResult errorNode: aMessageNode receiver.
					aMessageResult errorResult: aReceiverResult.
					^ aMessageResult ] ].
			
	"here we know that receiver is valid"
	(self isGlobal: aMessageNode receiver)
		ifTrue: [
			| aReceiverObject |
			aReceiverObject := self class environment at: aMessageNode receiver name.
			(aReceiverObject respondsTo: aMessageNode selector)
				ifFalse: [ ^ self errorFor: aMessageNode ] ].
	
	(aMessageNode receiver isVariable and: [ aMessageNode receiver name isPseudovariableName ])
		ifTrue: [ ^ self errorFor: aMessageNode ].

	theArguments := aMessageNode arguments.
	theArguments withIndexDo: [ :eachArgument :eachIndex |
		| eachResult |
		eachResult := self visitNode: eachArgument.
		eachResult isValid
			ifFalse: [
				| newArguments |
				newArguments := theArguments first: (eachIndex - 1).
				aMessageNode arguments: newArguments.

				aMessageResult isValid: false.
				aMessageResult isPartiallyValid: (eachIndex > 1).
				aMessageResult errorNode: eachArgument.
				aMessageResult errorResult: eachResult.
				
				^ aMessageResult ] ].
		
	^ aMessageResult