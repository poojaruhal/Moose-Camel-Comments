visiting
visitVariableNode: aVariableNode
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
	
	^ self errorFor: aVariableNode