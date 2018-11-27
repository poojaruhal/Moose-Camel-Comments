parsing
parseSelfKeywordWithBlockArgument
	<gtExample>
	| aParser aString anAST |
	
	aParser := self parser.
	aString := 'self show: ''Doing...'' from: 0 to: 50 during: [ :bar |
	0 to: 50 do: [ :x | 
		bar increment.
		bar label: x asString.
		(Delay forMilliseconds: 20) wait "Just to slow it down so we can see what''s going on" ] ].'.
	
	anAST := aParser parse: aString.
	
	^ anAST