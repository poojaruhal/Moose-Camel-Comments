Class {
	#name : #MccSmalltalkInCommentStrategy,
	#superclass : #PP2Strategy,
	#instVars : [
		'visitor'
	],
	#classVars : [
		'allMethods'
	],
	#classInstVars : [
		'visitor'
	],
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #initialization }
MccSmalltalkInCommentStrategy >> initialize [ 
	super initialize.
	
	allMethods := allMethods ifNil: [
		(SystemNavigation default allMethods)
			collect: [ :each | each selector ]
			as: Set ]
]

{ #category : #parsing }
MccSmalltalkInCommentStrategy >> parseOn: aPP2Context [
	| position smalltalkParser aResult  |
	position := aPP2Context rememberPosition.
	
	smalltalkParser := MccSmalltalkParser new.
	aResult := smalltalkParser parseOn: aPP2Context.

	aResult isPetit2Failure
		ifTrue: [ aPP2Context restorePosition: position ]
		ifFalse: [ aResult := self processAST: aResult with: aPP2Context at: position ].
	
	^ aResult
]

{ #category : #parsing }
MccSmalltalkInCommentStrategy >> processAST: anRBNode with: aPP2Context at: aPosition [
	| aResult allNodes aFirstNode hasSequenceOrCascade |

	allNodes := { anRBNode } , anRBNode allChildren.
	
	"If all nodes are message nodes and one of them a literal, it's probably just a natural language sentence"
	(allNodes allSatisfy: [ :eachNode | eachNode isMessage or: [ eachNode isLiteralNode ] ])
	ifTrue: [ 
		| messages messageSelectors counter |
		messages := allNodes select:  [ :eachNode | eachNode isMessage ].
		messageSelectors := messages collect: [ :messageNode | messageNode selector ].
		counter := 0.
		messageSelectors do: [ :theSelector | (allMethods includes: theSelector) 
			ifTrue: [ counter := counter + 1. ]].
		"Check if less than 50% are existing messages"
		(counter < (messageSelectors size)/2) ifTrue:  [ 
			aPP2Context restorePosition: aPosition.
			^ PP2Failure message: 'Not enough existing message names' context: aPP2Context ]
	].
	
	"to get access to the first *visual* node we shoould ask for the last AST node, since it returns them breadth first"
	aFirstNode := allNodes last.

	hasSequenceOrCascade := allNodes anySatisfy: [ :eachNode | eachNode isCascade or: [ eachNode isSequence ] ].

	(hasSequenceOrCascade not and: [ anRBNode isVariable or: [ anRBNode isLiteralNode or: [ aFirstNode isSelfOrSuper ] ] ])
		ifTrue: [
			aPP2Context restorePosition: aPosition.
			^ PP2Failure message: 'First node can not be variable, self or super' context: aPP2Context ].

	aResult := anRBNode acceptVisitor: visitor.
	
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

{ #category : #accessing }
MccSmalltalkInCommentStrategy >> visitor [ 
	^ visitor
]

{ #category : #accessing }
MccSmalltalkInCommentStrategy >> visitor: anMccSmalltalkInCommentVisitor [ 

	visitor := anMccSmalltalkInCommentVisitor 
]
