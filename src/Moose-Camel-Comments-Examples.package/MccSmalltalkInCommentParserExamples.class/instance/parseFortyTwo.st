parsing
parseFortyTwo
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'fortyTwo := 42.
fortyTwo logCr'.
	
	anAST := aParser parse: aString.
	
	^ anAST