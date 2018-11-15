parsing
parseOn: aPP2Context
	| position smalltalkParser aResult  |
	position := aPP2Context rememberPosition.

	smalltalkParser := MccSmalltalkParser new.
	aResult := smalltalkParser parseOn: aPP2Context.
	
	
	aResult logCr. '' logCr.
	
	aResult isPetit2Failure
		ifTrue: [
			aPP2Context restorePosition: position.
			"aResult := #()" ]
		ifFalse: [
			aResult isVariable
				ifTrue: [
					aPP2Context restorePosition: position + 2.
					aResult := PP2Failure message: 'First node can not be variable' context: aPP2Context ]
				ifFalse: [  ] ].
	
	(aResult isPetit2Success and: [ aResult children isNotEmpty ])
		ifTrue: [	
			| aFirstNode aSequenceNode |
			
			aSequenceNode := aResult.			
			aFirstNode := aSequenceNode children first.
	
			aFirstNode isVariable
				ifTrue: [
					aResult := PP2Failure message: 'First node can not be variable' context: aPP2Context.
					aPP2Context restorePosition: position
				]
				ifFalse: [ 			
					aSequenceNode children reverseDo: [ :eachNode |
						(eachNode isVariable and: [ 
								(aSequenceNode assignmentNodes
									anySatisfy: [ :eachAssignmentNode | eachAssignmentNode variable name = eachNode name ]) not
							])
						ifTrue: [
							aPP2Context restorePosition: eachNode start - 1.
							aSequenceNode removeNode: eachNode.
							"aResult := PP2Failure message: 'Node can not be variable that is not defined' context: aPP2Context."
						] ] ] ].
	^ aResult