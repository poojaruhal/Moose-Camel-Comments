visiting
visitUseAssignmentWithGarbageInBetween
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'fortyTwo := 42. Hello World. fortyTwo + 1'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid.
	
	^ aResult