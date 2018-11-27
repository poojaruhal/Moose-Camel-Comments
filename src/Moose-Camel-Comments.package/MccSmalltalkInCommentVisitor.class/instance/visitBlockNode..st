visiting
visitBlockNode: aBlockNode
	| theBodyResult |
	self pushArgumentNodes: aBlockNode arguments.
	
	theBodyResult := self visitNode: aBlockNode body.
	
	self popArgumentNodes: aBlockNode arguments.
	
	^ theBodyResult isValid
		ifTrue: [ self resultFor: aBlockNode ]
		ifFalse: [ (self errorFor: aBlockNode) errorResult: theBodyResult ].