Class {
	#name : #MccSmalltalkInCommentStrategy,
	#superclass : #PP2Strategy,
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #parsing }
MccSmalltalkInCommentStrategy >> parseOn: aPP2Context [
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
]

{ #category : #parsing }
MccSmalltalkInCommentStrategy >> processAST: anRBNode with: aPP2Context at: aPosition [
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
]
