parsing
parseSequenceWithOnlyFirstValidExpression
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'SystemProgressMorph reset.
Examples.'.
	
	anAST := aParser parse: aString.
	
	^ anAST