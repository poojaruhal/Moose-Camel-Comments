parsing
parseHelloWorld
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'Hello World'.
	
	anAST := aParser parse: aString.
	
	^ anAST