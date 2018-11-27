visiting
visitUseSelf
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'self new'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult