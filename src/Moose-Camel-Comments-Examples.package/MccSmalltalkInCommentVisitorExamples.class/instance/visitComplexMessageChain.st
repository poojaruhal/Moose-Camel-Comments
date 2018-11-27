visiting
visitComplexMessageChain
	<gtExample>
	| aParser aText aVisitor anAST aResult |
	
	aParser := self smalltalkParser.
	aText := '((PragmaMenuBuilder pragmaKeyword: MenuRegistrationExample pragmaKeyword model: nil) menuEntitled: ''World'') popUpInWorld'.
	aVisitor := self visitor.
	
	anAST := aParser parse: aText.
	aResult := anAST acceptVisitor: aVisitor.
	
	self assert: aResult isValid.
	self assert: aResult isPartiallyValid.
	
	^ aResult