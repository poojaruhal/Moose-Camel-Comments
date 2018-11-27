visiting
visitUnimplementedMessageToGlobal
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'Object can'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid not.
	self assert: aResult isPartiallyValid not.
	
	^ aResult