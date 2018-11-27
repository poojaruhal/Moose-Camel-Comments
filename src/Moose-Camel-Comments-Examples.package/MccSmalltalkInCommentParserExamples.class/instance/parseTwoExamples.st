parsing
parseTwoExamples
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'Example:
| p |
p := ProgressBarMorph from: 0 to: 200.

Another example:
| p |
p := ProgressBarMorph from: 0 to: 100.'.
	
	anAST := aParser parse: aString.
	
	^ anAST