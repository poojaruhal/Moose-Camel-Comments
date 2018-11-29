Class {
	#name : #MccSmalltalkInCommentVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'assignments',
		'classOrMetaclass'
	],
	#category : 'Moose-Camel-Comments-Parser'
}

{ #category : #accessing }
MccSmalltalkInCommentVisitor >> assignments [
	^ assignments
]

{ #category : #accessing }
MccSmalltalkInCommentVisitor >> assignments: anObject [
	assignments := anObject
]

{ #category : #accessing }
MccSmalltalkInCommentVisitor >> classOrMetaclass [
	^ classOrMetaclass
]

{ #category : #accessing }
MccSmalltalkInCommentVisitor >> classOrMetaclass: anObject [
	classOrMetaclass := anObject
]

{ #category : #'instance creation' }
MccSmalltalkInCommentVisitor >> errorFor: aRBNode [
	^ (self resultFor: aRBNode)
		isValid: false;
		isPartiallyValid: false;
		errorNode: aRBNode
]

{ #category : #initialization }
MccSmalltalkInCommentVisitor >> initialize [
	super initialize.
	
	assignments := OrderedCollection new
]

{ #category : #'private - testing' }
MccSmalltalkInCommentVisitor >> isGlobal: aRBNode [
	^ aRBNode isVariable
		and: [ self class environment includesKey: aRBNode name ]
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> popArgumentNode: anArgumentNode [
	assignments remove: anArgumentNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> popArgumentNodes: aNodeCollection [
	aNodeCollection do: [ :each | self popArgumentNode: each ]
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> pushArgumentNode: anArgumentNode [
	assignments add: anArgumentNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> pushArgumentNodes: aNodeCollection [
	aNodeCollection do: [ :each | self pushArgumentNode: each ]
]

{ #category : #'instance creation' }
MccSmalltalkInCommentVisitor >> resultFor: aRBNode [
	^ MccSmalltalkInCommentParserResult for: aRBNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitArrayNode: anArrayNode [ 
	^ self resultFor: anArrayNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitAssignmentNode: anAssignmentNode [
	assignments add: anAssignmentNode variable.
	
	^ self resultFor: anAssignmentNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitBlockNode: aBlockNode [
	| theBodyResult |
	self pushArgumentNodes: aBlockNode arguments.
	
	theBodyResult := self visitNode: aBlockNode body.
	
	self popArgumentNodes: aBlockNode arguments.
	
	^ theBodyResult isValid
		ifTrue: [ self resultFor: aBlockNode ]
		ifFalse: [
			| anError |
			anError := (self errorFor: aBlockNode) errorResult: theBodyResult.
			aBlockNode right: aBlockNode left - 1.
			anError ].
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitCascadeNode: aCascadeNode [ 	
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
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitLiteralArrayNode: aLiteralNode [
	^ self resultFor: aLiteralNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitLiteralNode: aLiteralNode [
	^ self resultFor: aLiteralNode
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitMessageNode: aMessageNode [ 
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
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitSequenceNode: aSequenceNode [
	| theStatements theResult |
	self visitTemporaryNodes: aSequenceNode temporaries.

	theStatements := aSequenceNode statements.
	theStatements ifEmpty: [ aSequenceNode periods: #() ].
	
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
]

{ #category : #visiting }
MccSmalltalkInCommentVisitor >> visitVariableNode: aVariableNode [
	"a variable is already assigned"
	| theResult |
	
	theResult := self resultFor: aVariableNode.
	
	(assignments includes: aVariableNode)
		ifTrue: [ ^ theResult ].
	
	"is a global"
	(self isGlobal: aVariableNode)
		ifTrue: [ ^ theResult ].

	aVariableNode name = #self
		ifTrue: [ ^ theResult ].
	
	aVariableNode name = #super
		ifTrue: [ ^ theResult ].
	
	^ (self errorFor: aVariableNode) filteredAST: (aVariableNode class named: #'' start: 1)
]
