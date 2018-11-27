parsing
parseTextAndSimpleMessageSendsToGlobal
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'I display a set of progress indicator in a list.
Special care is taken to update the view while the rest of the UI process is blocked.

Reset.
SystemProgressMorph reset.

Examples.'.
	
	anAST := aParser parse: aString.
	
	^ anAST