parsing
processAST: anRBNode with: aPP2Context at: aPosition
	| aResult |
	
	(anRBNode isVariable or: [ anRBNode isLiteralNode ])
		ifTrue: [
			aPP2Context restorePosition: aPosition.
			^ PP2Failure message: 'First node can not be variable' context: aPP2Context ].

	aResult := anRBNode acceptVisitor: MccSmalltalkInCommentVisitor new.
	aResult isValid
		ifTrue: [ ^ anRBNode ].
	
	aPP2Context restorePosition: aResult errorNode start - 1.
	
	aResult isPartiallyValid
		ifTrue: [
			| allChildrenNodes |
			allChildrenNodes := aResult filteredAST allChildren reject: #isSequence.
			(allChildrenNodes size = 1 and: [ allChildrenNodes first isVariable or: [ allChildrenNodes first isLiteralNode ] ])
				ifFalse: [ ^ aResult filteredAST ] ].

	aPP2Context restorePosition: aPosition.
	^ PP2Failure message: 'AST is not a valid Pharo code' context: aPP2Context