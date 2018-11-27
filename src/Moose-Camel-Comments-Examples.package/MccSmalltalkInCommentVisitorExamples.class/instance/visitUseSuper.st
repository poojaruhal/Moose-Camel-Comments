visiting
visitUseSuper
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := 'super new'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult